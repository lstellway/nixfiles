---
name: flow-implement
description: Implement an OpenSpec change in an isolated git worktree, committing section by section, and open a draft PR. Delegates the per-task work to /opsx:apply inside a subagent. Use when a change has its proposal/design/tasks ready and you want to execute it without polluting your main checkout.
license: MIT
metadata:
  author: lstellway
  version: "0.1"
---

Execute an OpenSpec change in a clean worktree and hand back a reviewable PR.

Implement is the role in the 5-step workflow (Vision → Strategy → Plan → Implementation → Retro) that turns a planned change into committed code. It sits between Plan (artifacts ready) and Retro (post-merge reflection).

This skill wraps `/opsx:apply` with three concerns Plan and Apply don't own:

- **Worktree isolation** via plain `git worktree` — main checkout stays clean
- **Iterative commit cadence** — one commit per logical section of `tasks.md`, not one giant blob
- **PR scaffolding** — draft PR opened after the first push so review can start while implementation continues

This skill does **not** archive the change. Archival is `flow-retro`'s job (post-merge).

---

## When to use this skill

- A change at `openspec/changes/<change-id>/` has `proposal.md`, `tasks.md`, and ideally `flow.md`
- You want execution in a worktree, not on the main checkout
- You want a draft PR ready for review when the work is done (or in progress)

If you want to implement directly on the main checkout without a worktree, skip this skill and use `/opsx:apply` directly.

---

## Steps

### 1. Resolve the change

Input is a change-id (e.g. `/flow-implement rotate-secrets-on-startup`). If no id is provided, list un-archived changes in `openspec/changes/` (excluding `archive/`) and ask which to implement.

Verify:

- `openspec/changes/<change-id>/proposal.md` exists
- `openspec/changes/<change-id>/tasks.md` exists and has unfinished items
- `flow.md` is present (recommended but not required — warn if missing)

If `tasks.md` is fully checked off, stop — the work is done, suggest `/flow-retro` instead.

### 2. Decide worktree path and branch

Propose:

- **Worktree path** — default to `.claude/worktrees/<change-id>` (in-repo, follows Claude conventions). Show this and let the user accept or override.
- **Branch name** — default to the change-id (e.g. `rotate-secrets-on-startup`). Let the user override.

Before creating the worktree, make sure `.claude/worktrees/` is in the host repo's `.gitignore`. If it's missing, propose adding it as a one-line edit and confirm before touching `.gitignore`.

Confirm with the user before creating anything on disk. If the proposed path already exists, surface this and ask whether to reuse or pick a different location.

### 3. Create the worktree

Run plain git commands from the main checkout:

```bash
git worktree add <worktree-path> -b <branch-name>
```

If the branch already exists (e.g. resuming a prior implementation session), use:

```bash
git worktree add <worktree-path> <branch-name>
```

Verify the worktree was created. Do **not** use the `Agent` tool's `isolation: "worktree"` parameter — the user prefers manual worktree control over Claude-managed cleanup.

### 4. Delegate to a subagent

Spawn a `general-purpose` subagent (no `isolation` parameter) with a self-contained prompt covering:

- **cwd context** — the subagent should run commands from the worktree path; the parent skill stays in the main checkout
- **Change ID and path** — e.g. `openspec/changes/<change-id>/`
- **Files to read first** — `proposal.md`, `design.md`, `tasks.md`, `flow.md` (if present), plus CLAUDE.md from the worktree
- **Task** — invoke `/opsx:apply` for the change, working through `tasks.md` **section by section**
- **Commit cadence** — after each logical section of `tasks.md` is complete and verified (tests + lint + typecheck pass for the affected scope), make a commit with a message summarizing that section's work
- **Push cadence** — keep commits local during implementation. Push **once at the end**, after all sections are complete (or after the subagent stops on a blocker)
- **PR creation** — after the final push, open a draft PR with `gh pr create --draft`. Title: a short summary derived from the change. Body: link to the OpenSpec change directory, the expected outcome from `flow.md` (if present), and a checklist mirroring the sections of `tasks.md`
- **Retry budget** — on a failing test/lint/typecheck, attempt at most **2 fixes** for the same failure mode. If still failing after the second attempt, stop and report it as a blocker rather than retrying further
- **Do NOT archive** — leave the change in `openspec/changes/<change-id>/`; `flow-retro` handles archival post-merge
- **Hand-back format** — return a structured summary (see step 5)

Brief the subagent like a colleague who hasn't seen this conversation. Include the exact change-id, worktree path, branch name, and PR title template.

### 5. Receive the hand-back

The subagent returns a summary. Pass it through to the user with these fields visible:

- **Worktree path** — where the work lives
- **Branch** — branch name + remote tracking status
- **Commits** — SHA + one-line message for each
- **PR URL** — draft PR link (or "no PR — gh not available / project not a GitHub repo")
- **Verification status** — tests, lint, typecheck — passing or which failed
- **Skipped or blocked tasks** — any sections that hit the retry limit or were deferred
- **Open questions** — anything the subagent surfaced that needs user input

### 6. Close

Output:

- The hand-back summary
- Recommended next step:
  - **Review the draft PR** — promote to ready-for-review when satisfied
  - **Resume `/flow-implement <change-id>`** to continue from where it stopped if there are blockers or skipped sections
  - **Run `/flow-retro <change-id>` after merge** — do not run retro before the PR is merged

Worktree stays in place after the skill exits. The user removes it manually with `git worktree remove <path>` when they're done with it.

---

## Guardrails

- **Plain git, not Claude-managed worktrees.** Use `git worktree add` / `git worktree remove`. Do not use the `Agent` tool's `isolation: "worktree"` parameter — the user prefers explicit control over path and cleanup.
- **Do not archive.** Even if the subagent reports all tasks complete and tests passing, leave the change in `openspec/changes/<change-id>/`. Archival is `flow-retro`'s contract.
- **One section per commit.** Resist any urge (or any subagent tendency) to squash all work into one commit at the end. Section-by-section commits make the git log readable and the PR reviewable.
- **2-attempt retry max.** On any single failure mode, two fix attempts then stop. Surfacing a blocker is better than spinning on a flaky test or a misunderstood requirement.
- **Don't write to `flow.md`.** It's Plan-owned context. The implementer reads it for direction; the retro reads it for comparison. Implementation does not mutate it.
- **Tasks.md mutations are fine.** Checking off tasks as they complete is the file's purpose.
- **Subagent does its own commits, pushes, and PR creation.** The parent skill does not do these — it only sets up the worktree and reads back the result.
- **If `gh` isn't available or this isn't a GitHub remote**, skip PR creation gracefully. The branch push is the minimum deliverable.
