---
name: apply-change
description: Orchestrates applying an OpenSpec change — builder subagent executes tasks.md, then fans out reviewers matched to what the diff actually touches, synthesizes findings, and loops or commits.
---

## Overview

The apply-side counterpart to `plan-change`. Same fan-out shape, different goal: ship the change, not prepare it.

1. **Pre-flight** — verify the change exists, is well-formed, and is ready to apply.
2. **Discovery** — read the agent roster from `~/.claude/agents/` and `.claude/agents/`.
3. **Project context** — project-context agent → root `CLAUDE.md` → ask user.
4. **Execution planning** — decide single-pass vs parallel slices (worktrees).
5. **Build** — delegate to a general-purpose builder subagent.
6. **Review fan-out** — pick reviewers adaptively based on what the diff actually touches. No floor, no ceiling.
7. **Synthesis** — iterate, surface to user, or proceed to commit.
8. **Commit** — only with user confirmation.
9. **Report** — paths, diff summary, reviewer outcomes, deferred items.

This skill never commits without user confirmation. The diff is the artifact; the user is the final reviewer.

---

## Input parsing

**Target** (required): the change name (kebab-case) — first argument. If omitted, list directories in `openspec/changes/` and ask the user which to apply via `AskUserQuestion`.

---

## Steps

### 1. Verify OpenSpec is present

```bash
test -f openspec/config.yaml && echo present || echo missing
```

If `missing`:

> This skill applies OpenSpec changes, but the current project doesn't have OpenSpec configured (no `openspec/config.yaml`). To set it up, run `openspec init`. To apply a change without OpenSpec, just describe the work directly — this skill bails here.

**Stop.**

### 2. Verify the change is ready

Read `openspec/changes/<name>/proposal.md`, `tasks.md`, `design.md` (if present), and any specs under `openspec/changes/<name>/specs/`.

Check:

- **Required files present**: `proposal.md` and `tasks.md` exist. If not, stop and ask the user to run `/plan-change` first.
- **No unresolved decisions**: scan for `TBD`, `TODO(decide)`, `???`, or open-question markers. If any are found, list them and stop:
  > The change has unresolved decisions: <list>. Resolve them in the proposal/spec (or re-run `/plan-change`) before applying.
- **Dependencies landed**: if the proposal lists prerequisite changes, check whether they're still in `openspec/changes/` (pending) or have moved to `openspec/specs/` (landed). If a prereq is pending, stop:
  > This change depends on `<prereq>`, which hasn't landed yet. Apply that first.

Do not try to repair planning artifacts during apply. Bounce back to `/plan-change`.

### 3. Discover the agent roster

In parallel, glob `~/.claude/agents/*.md` and `.claude/agents/*.md`. Extract frontmatter; treat as an agent only if `name` and `description` are present. Build `[ { name, description, path }, ... ]`.

If the roster is empty:

> No specialist agents found. Without reviewers, this skill degrades to "run a builder subagent and report the diff." If that's acceptable, confirm and I'll proceed; otherwise install agents via the `agent-*` skills first.

The user may choose to proceed without reviewers.

### 4. Establish project context

Same convention as `plan-change`:

- Project-context agent in the roster → invoke first for stakeholder/surface map.
- Else root `CLAUDE.md` → read it.
- Else `AskUserQuestion` (open-ended) for a one-paragraph summary.

Context informs reviewer routing, not the build itself.

### 5. Plan execution shape

Read `tasks.md`. Decide:

- **Single pass** (default) — one builder subagent works `tasks.md` top to bottom.
- **Parallel slices** — only when `tasks.md` has clearly independent task groups touching disjoint file sets, *and* the change is large enough that orchestration overhead pays off. Each slice runs in `Agent(isolation: "worktree")`; the main thread merges sequentially after.

Indicators for parallel slices:
- `tasks.md` already groups tasks into named phases or sections
- Phases touch disjoint directories (e.g., `lib/` vs `app/api/` vs `tests/`)
- No phase consumes outputs from a sibling phase

When in doubt, default to single pass. Surface the chosen shape to the user with a one-line justification before building.

### 6. Build

#### Single pass

Invoke one `general-purpose` Agent (foreground):

```
You are implementing an OpenSpec change. The plan is fully resolved — do not ask the user clarifying questions. If the plan doesn't cover a small decision, make the most reasonable choice consistent with the project's existing code and note it in your return.

CHANGE NAME: <name>
CHANGE LOCATION: openspec/changes/<name>/

Procedure:
1. Read proposal.md, design.md (if present), tasks.md, and all specs under specs/.
2. Read referenced files and surrounding code to understand conventions.
3. Implement tasks.md top to bottom. Check off each task as you complete it by changing `- [ ]` to `- [x]` and saving the file. Do not batch checkmarks — update tasks.md as each task completes so progress is visible.
4. After each meaningful chunk, run any project-level checks the repo supports (lint, typecheck, tests). Resolve failures before moving on.
5. Do NOT commit. The orchestrator handles commit timing.

Return:
- Branch state (clean / dirty file list)
- Tasks completed vs deferred (with reason for each deferral)
- Project checks run and their outcomes
- Decisions you made that weren't explicit in the plan
- Anything you couldn't do, and why
```

#### Parallel slices

Invoke `general-purpose` agents with `isolation: "worktree"` simultaneously, one per slice. Each receives its slice-scoped task list and the constraint to touch only its designated file paths. After all return, the main thread merges worktrees sequentially and runs project checks on the merged tree before review.

Worktree merges are risky if slices overlap unexpectedly. Expect a brief merge-and-recheck pass before reviewer fan-out.

### 7. Review fan-out

Inspect the diff (`git diff` against the change's base branch).

**Choose reviewers adaptively based on what the diff actually touches** — not a fixed count.

Identify the surfaces actually changed:
- Code domains (auth, data, UI, infra, observability, etc.)
- File types (migrations, configs, CI, lockfiles)
- Externally-observable changes (API shape, schema, copy, flow)

For each surface, match to roster agents whose descriptions plausibly cover it. A reviewer is worth invoking only if their judgment could change the outcome (block, request change, surface risk). Skip:
- Surfaces that are trivially safe (docstring-only, comment-only, formatter sweep)
- Agents whose description doesn't plausibly cover anything in the diff

Possible outcomes:
- **Zero reviewers** — diff is trivial (typo, comment-only, dependency bump with no behavior change). Skip to step 8 with a note explaining why.
- **One reviewer** — single-domain change (pure CSS → UX; pure migration → data integrity).
- **Many reviewers** — cross-cutting (new authenticated endpoint may need security, API design, privacy, observability, *and* a persona).

No upper bound, but if you reach for >6, sanity-check whether the change is too broad to apply in one pass — consider surfacing that to the user before fanning out.

Fan out in parallel (single message, multiple `Agent` calls). Each reviewer gets:

```
You are reviewing an applied change. The implementation is in the working tree as a diff against <base>.

CHANGE NAME: <name>
CHANGE LOCATION: openspec/changes/<name>/
DIFF SCOPE: <file list, or "see git diff <base>...HEAD">

Apply your domain expertise to the diff. Focus on:
- Correctness within your domain
- Risks the spec did not anticipate
- Drift between the spec and the implementation
- Gameable edges, failure modes, or regressions in your area

Output format:
- **Blocking** — must fix before commit
- **Non-blocking** — recommend addressing but not gating
- **Drift from spec** — places the diff departs from proposal.md/specs/
- **Confirmations** — explicit "this looks right" notes for the parts you actually engaged with

If your domain isn't meaningfully touched, return: "Not applicable — diff does not affect <your domain>."

Be terse and specific. Cite file:line. No narrative.
```

### 8. Synthesize and decide

Categorize reviewer findings:

- **Blocking** — at least one reviewer flagged a must-fix.
- **Non-blocking** — concerns worth noting but not gating.
- **Drift** — implementation departs from spec; either the implementation is wrong, the spec is wrong, or both are right and the spec is silent on the deviation.

Branch:

- **No blocking, no drift** — report to user with the full summary and propose committing. Wait for confirmation.
- **Blocking** — relay findings to a builder subagent for a revision pass, then loop back to step 7. **Cap iterations at 3 total build cycles.** After that, stop and surface unresolved issues to the user — the change probably needs re-planning, not more attempts.
- **Drift only** — use `AskUserQuestion` to choose: fix the implementation, update the spec, or accept the drift. Don't auto-decide.

### 9. Commit

Only after explicit user confirmation. Commit message should reference the change name and summarize the scope. Do not push. Do not amend prior commits.

### 10. Report

```markdown
## Change applied: <change-name>

**Execution shape**: single pass | parallel slices (<N> worktrees merged)

**Builder summary**: <from builder subagent>

**Reviewers consulted** (<N>):
- `<agent-1>` — <one-line outcome>
- `<agent-2>` — <one-line>
- ...
(omit if zero reviewers; explain why)

**Iterations**: <N build cycles>

**Tasks**: <completed count> done, <deferred list with reasons>

**Project checks**: <lint / typecheck / tests outcomes>

**Drift surfaced**: <list with resolution>
(omit if none)

**Commit**: <sha if committed, or "awaiting confirmation" / "user declined">

**Next**: e.g., "archive with `openspec archive <name>` once merged", "open follow-up for <deferred-item>"
```

---

## Guardrails

- **Always verify readiness before building.** Don't repair planning artifacts during apply — bounce back to `/plan-change`.
- **Adapt reviewer count to surface area.** No floor, no ceiling. Invoking a reviewer whose domain isn't touched is a routing failure, not thoroughness.
- **Default to single-pass build.** Worktree parallelism has real coordination cost; reserve it for changes with genuinely independent slices.
- **Cap iteration loops at 3 build cycles.** After that, the spec may be wrong, not the implementation — surface to the user.
- **Never auto-commit.** The user is the final reviewer of the diff.
- **Never skip hooks or force-push** as part of apply. If pre-commit hooks fail, treat as blocking and loop.
- **Builder must update `tasks.md` as it goes**, not at the end. Visible progress is non-negotiable.
- **Builder may defer tasks**, but each deferral must include a reason. The orchestrator surfaces deferrals in the final report so they don't disappear.
- **On drift, ask the user.** Don't silently amend the spec or the implementation.
- **On scope mismatch at review time**, ask the user whether the spec needs revision before continuing the loop.
- **Never invoke a reviewer whose description doesn't plausibly touch the diff.** "Not applicable" returns waste budget.
