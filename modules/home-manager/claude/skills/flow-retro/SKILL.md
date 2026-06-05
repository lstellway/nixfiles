---
name: flow-retro
description: Run a post-merge retrospective on an OpenSpec change. Compares the expected outcome captured in flow.md against what actually shipped, surfaces follow-ups and new candidates for Strategy, and archives the change. Use after a change has been merged but not yet archived.
license: MIT
metadata:
  author: lstellway
  version: "0.1"
---

Reflect on a merged change and feed what you learn back into Strategy.

Retro is the role in the 5-step workflow (Vision → Strategy → Plan → Implementation → Retro) that closes the loop. It compares what Plan said would happen against what actually happened, surfaces what's still open, and proposes the next set of candidates so the project keeps learning instead of just shipping.

This skill is collaborative — the user does the reflecting; the skill asks the prompts and proposes file actions.

---

## When to use this skill

- A change has been merged but is not yet archived in `openspec/changes/archive/`
- You want to close the loop on what you learned before moving on
- You want to surface follow-ups and feed them back into Strategy

Best run soon after merge while the work is fresh. Stale retros are still useful but lose detail.

If you've merged several changes without retro-ing, run this once per change rather than batching. Each change has its own `flow.md` to compare against.

If the change skipped Plan (e.g. a hotfix that went straight to `/opsx:propose`), there's no `flow.md`. Retro will offer to backfill one best-effort from the proposal so the comparison spine still exists.

---

## Steps

### 1. Resolve the change

Input is a change-id (e.g. `/flow-retro rotate-secrets-on-startup`). If no id is provided, list un-archived changes (`openspec/changes/*/` excluding `archive/`) and ask which to retro.

Verify:

- The change directory exists at `openspec/changes/<change-id>/`
- `proposal.md`, `tasks.md`, and ideally `flow.md` are present
- The change appears merged (recent commits touching its files reach main)

If `flow.md` is missing, note this — the retro will work but loses the expected-vs-happened spine. Offer to proceed with a free-form retro or stop and let the user backfill `flow.md` first.

### 2. Read context

Read these files in the change directory:

- `flow.md` — expected outcome, watch signals, open questions from the candidate (the **spine** of the retro)
- `proposal.md` — what was promised
- `tasks.md` — what was planned
- The parent candidate at `openspec/candidates/<candidate-id>.md` (id is in `flow.md` frontmatter)

Also pull a recent git log for the files touched by this change so the user can ground the reflection in actual commits. Delegate to the Explore agent (thoroughness: "quick") if the change is large or spans many files.

### 3. Conduct the reflection

Walk these four areas in order. Keep it conversational — paraphrase the user's answers rather than transcribing.

**a. Expected vs. happened**
Use `flow.md`'s **Expected outcome** as the prompt:
> Plan said: "<expected outcome>". What actually happened? Closer to that, different in what way?

Then walk **What we'll watch** bullet by bullet:
> "<watch signal>" — what did you see?

**b. Surprises**
> Anything unexpected, good or bad? Effort estimates off in either direction? Implementation revealed something the proposal didn't anticipate?

**c. Still open**
> What got punted? Any new questions this work opened? Any TODOs left in the code that should become tracked candidates rather than rotting in comments?

**d. Feeds Strategy**
> What should the next strategy session know? New candidates implied? Existing candidates that should change priority based on what you saw? Anything that nudges the project's vision or conventions?

Pull from `flow.md`'s **Open questions carried from the candidate** here — did this change resolve any of them? Are they still open?

### 4. Synthesize file actions

As the reflection produces concrete outputs, propose file actions. Each is user-gated.

**Always:**
- `openspec/changes/<change-id>/retro.md` — written in step 5 below

**Often:**
- **Update the parent candidate** — flip the shipped change's checklist line and check the box; bump `last-reviewed`. If all entries are shipped, transition `status: completed` and move file to `openspec/candidates/archive/`.
- **New candidate files** — anything from "still open" or "feeds Strategy" that's worth tracking goes to `openspec/candidates/<id>.md` using the template. Don't pad — only create candidates with real signal behind them.
- **Edits to existing candidates** — impact/effort changes, new entries in the Changes checklist, dependency adjustments.

**Sometimes — convention or rule edits:**

When a retro surfaces a convention or rule worth codifying, propose the edit at the surface that fits best — CLAUDE.md, a flow skill's guardrails, `openspec/specs/`, or memory. Ask the user where it should live if it's not obvious. If the change is too big for an inline edit, propose it as a new candidate for Strategy to schedule.

### 5. Write `retro.md`

Write `openspec/changes/<change-id>/retro.md`. This is a flow-owned file (alongside `flow.md`), not part of the OpenSpec artifact set.

```markdown
---
candidate: <candidate-id>
retro-date: <YYYY-MM-DD>
---

## Expected vs. happened
<Compare flow.md's Expected outcome to reality. One paragraph or bullets.>

## Watch signals
<Walk each signal from flow.md — what was actually observed.>

## Surprises
<What was unexpected. Effort, scope, behavior, learning.>

## Still open
<What got punted. New questions raised. Tracked candidates created (link by id).>

## Feeds Strategy
<New candidates, updates to existing candidates, vision/convention nudges. Link by candidate id where applicable.>
```

`retro.md` will travel with the change into `openspec/changes/archive/<change-id>/retro.md` when `/opsx:archive` runs in step 7.

### 6. Update the parent candidate

In `openspec/candidates/<candidate-id>.md`:

- Bump `last-reviewed` to today
- Flip the shipped change's line:

  Before:
  ```
  - [ ] **rotate-secrets-on-startup** — Rotate Vault secrets at app boot *(in flight: rotate-secrets-on-startup)*
  ```

  After:
  ```
  - [x] **rotate-secrets-on-startup** — Rotate Vault secrets at app boot *(shipped: rotate-secrets-on-startup)*
  ```

If **all** entries in `Changes` are now shipped (or otherwise closed) and any open questions are resolved:

- Set `status: completed`
- Move file from `openspec/candidates/<id>.md` to `openspec/candidates/archive/<id>.md`

### 7. Delegate to `/opsx:archive`

Hand off to `/opsx:archive` with the change id. It handles the actual move into `openspec/changes/archive/` and any spec-merge work. `retro.md` (and `flow.md`) ride along because they live in the change directory.

Do not perform the archive move manually — `/opsx:archive` owns that contract and may evolve.

### 8. Close

Output:

- Path to the archived change (`openspec/changes/archive/<change-id>/`)
- Path to the updated candidate (or its archived location if completed)
- New candidate files created (paths)
- Repo-artifact edits applied (paths)
- Recommended next step:
  - `Run /flow-strategy` — the retro likely surfaced something to triage
  - `Move on` — if nothing material came out

---

## Guardrails

- **Don't pad with candidates.** If the retro is "things went mostly as expected, nothing material to follow up on," say that and close out cleanly. Quality > volume.
- **Don't re-litigate the change.** Retro is for learning, not relitigating the decision. If the user wants to *revert* something, that's a new candidate, not a retro modification.
- **One change per retro.** If multiple changes shipped at once, run the skill once per change. Each has its own `flow.md` spine.
- **Don't skip the spine.** If `flow.md` is missing, prefer backfilling it (best-effort, based on the proposal) before running the retro, rather than running a free-form retro that loses the comparison.
- **User-gated file writes throughout.** Propose; don't decide.
