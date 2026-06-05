---
name: flow-plan
description: Promote an active candidate from openspec/candidates/ to a full OpenSpec change. Captures expected outcome and watch signals so the eventual retro has something concrete to compare against. Use when a candidate has been validated by Strategy and you're ready to commit to one specific change within it.
license: MIT
metadata:
  author: lstellway
  version: "0.1"
---

Promote a candidate to an OpenSpec change.

Plan is the role in the 5-step workflow (Vision → Strategy → Plan → Implementation → Retro) that turns a *which* (a candidate) into a *how* (an OpenSpec proposal). It sits between Strategy (decided this is worth doing) and Implementation (actually doing it).

This skill is a thin wrapper around `/opsx:propose`. It adds project conventions:

- A relational link from the change back to its parent candidate
- An "expected outcome / what we'll watch" capture so retros have something to compare against
- Candidate-file updates (checkbox status, last-reviewed bump)

---

## When to use this skill

- A candidate in `openspec/candidates/` has been validated and you're ready to commit to one of its discrete changes
- You want the change to carry retro-readiness metadata from the start

If the work is ad-hoc and not tied to a candidate (hotfix, urgent one-off), skip this skill and go straight to `/opsx:propose`. Plan is the candidate→change path, not the only path to a change.

---

## Steps

### 1. Resolve the candidate

Input is a candidate id (e.g. `/flow-plan rotate-secrets-pipeline`). If no id is provided, ask which candidate to plan from, listing active candidates in `openspec/candidates/`.

Read `openspec/candidates/<id>.md`. Verify:

- `status: active` — refuse if completed, rejected, or superseded (suggest the user revisit Strategy)
- At least one un-promoted entry in the `Changes` checklist

If the file is missing, stop and tell the user.

### 2. Pick the change to promote

Show the user the candidate's `Changes` checklist. Identify the un-promoted entries (those still marked `*(not yet promoted)*`).

- If there's exactly one un-promoted entry, confirm with the user that this is the one to promote.
- If there are several, ask which.
- If all entries are promoted/shipped, stop and recommend the candidate be moved to `completed` (handled by `/flow-retro` once the last change ships).

Propose a kebab-case change id derived from the entry name. Let the user accept or edit.

### 3. Capture plan notes

Short interview — keep it lightweight:

1. **Expected outcome** — when this change ships, what will be true that isn't now? One or two sentences.
2. **What we'll watch** — specific signals (good or bad) the retro should check. Bullets are fine.
3. **Open questions carried from the candidate** — anything the candidate flagged that this change is *not* resolving (so the next change in the candidate can pick them up).

These three pieces become `flow.md` in the change directory. This interview happens **before** delegating to `/opsx:propose` on purpose — the expected outcome is the contract the proposal/design should satisfy, not a description of what they already committed to. Same intuition as test-driven development.

Don't over-engineer the interview; if the user says "skip, just promote it," accept a minimal `flow.md` with just the relational link.

### 4. Delegate to `/opsx:propose`

Invoke `/opsx:propose` with the chosen change name. Let it create the scaffolded change at `openspec/changes/<change-id>/` and generate `proposal.md`, `design.md`, `tasks.md` per its own flow.

Do *not* duplicate `/opsx:propose`'s work here. Plan's job is the wrapping; OpenSpec's job is the artifacts.

### 5. Write `flow.md`

After `/opsx:propose` finishes, write `openspec/changes/<change-id>/flow.md`:

```markdown
---
candidate: <candidate-id>
promoted: <YYYY-MM-DD>
---

## Expected outcome

<One or two sentences. What will be true when this ships.>

## What we'll watch

<Bullets — signals the retro should look for.>

## Open questions carried from the candidate

<Things the candidate flagged that this change is not resolving.>
```

Use empty section bodies if the user opted out of the full interview — the relational link in frontmatter is the minimum.

### 6. Update the candidate file

In `openspec/candidates/<candidate-id>.md`:

- Bump `last-reviewed` to today's date
- Flip the promoted change's checklist line:

  Before:
  ```
  - [ ] **rotate-secrets-on-startup** — Rotate Vault secrets at app boot *(not yet promoted)*
  ```

  After:
  ```
  - [ ] **rotate-secrets-on-startup** — Rotate Vault secrets at app boot *(in flight: rotate-secrets-on-startup)*
  ```

The retro skill is responsible for the final transition (`(shipped: <change-id>)` and checking the box) and for completing the candidate when all entries are shipped.

### 7. Close

Output:

- Path to the new change directory
- Path to the candidate file (so the user can verify the update)
- Recommended next step:
  - `Run /opsx:apply` to start implementation directly, OR
  - `Run /flow-implement` to delegate implementation to a subagent in a worktree

---

## Guardrails

- **One change per invocation.** Epic-style candidates with multiple un-promoted entries promote one at a time. Multiple changes in one shot makes the retro fuzzy.
- **Don't auto-promote if the candidate looks stale.** If `last-reviewed` is more than a few weeks old, surface this and ask whether to run `/flow-strategy` first.
- **Refuse to promote completed/rejected/superseded candidates.** If the user really wants this, they should revive the candidate (status → active) via `/flow-strategy` with explicit reasoning.
- **Read-only on memory.** This skill reads memory for context but does not write to it.
