---
name: flow-strategy
description: Run a strategy session to decide what to work on next, place an incoming idea, re-rank existing candidates, or reflect on recent retros. Use when the user wants to think about direction, prioritization, or backlog management at the project level — not implementation details.
license: MIT
metadata:
  author: lstellway
  version: "0.1"
---

Run a strategy session for the current project.

Strategy is the role in the 5-step workflow (Vision → Strategy → Plan → Implementation → Retro) that picks *which* efforts to take on next, at what scope. It sits between Vision (what we're building) and Plan (the proposal for one specific change).

This skill is collaborative — ideas come from either side. The skill prompts; the user steers; either party may introduce candidates.

---

## When to use this skill

- The user has an idea or topic and wants to figure out where it fits
- The user wants help finding what's next given the current state of the project
- The user wants to re-rank what's already in the candidate backlog
- The user wants to reflect on recent retros to surface new candidates
- The user feels the project drifting and wants to reconnect to vision

If the user is asking for implementation detail or design for a *specific* change, that's `/flow-plan`, not this skill. Strategy is about *which* change to do next, not *how* to do one.

---

## Steps

### 1. Read project state

Delegate to the Explore agent (thoroughness: "medium") to digest the current project state. Brief it to read:

- `CLAUDE.md` — project intent, conventions, parity rules
- `openspec/specs/` — established capabilities (post-archive)
- `openspec/changes/` — in-flight changes
- `openspec/candidates/` — active candidates (if the directory exists; if not, note this — it may need to be scaffolded)
- `openspec/changes/archive/*/retro.md` — recent retros (most recent 3–5)
- Recent git commits (last ~20)
- The user's memory at `~/.claude/projects/<sanitized-cwd>/memory/MEMORY.md` and any methodology-relevant files it links to

Ask the agent for a ~1-page snapshot:

- **Vision** — one-sentence north star (lifted from CLAUDE.md)
- **Capabilities** — one line per spec
- **In flight** — each change + status
- **Active candidates** — id, impact/effort, last-reviewed date
- **Recent retros** — one-line takeaways
- **Visible pain signals** — TODOs, repeated commits to the same area, recurring themes in retros

The subagent digest protects main context — the user sees the snapshot, not the raw state.

### 2. Open the session

Show the user the snapshot. Then ask, open-ended:

> What brings you here today?

Do *not* preset a path. Let the user steer.

### 3. Branch on intent

Based on the user's answer, draw from the **question bank** (below). Don't walk sections top-to-bottom; pull prompts that match where the conversation is going. Common branches:

- *User brings a topic / idea* → **Triage prompts**
- *User wants to find what's next* → **Vision-check** + **Pain/opportunity** + **Environment** prompts
- *User wants to re-rank* → **Re-ranking prompts** against active candidates
- *User wants to reflect on retros* → **Retro-driven prompts**
- *User feels drift* → **Vision-check prompts**; if drift is real, flag and recommend `/flow-vision`

Stay conversational. Either party may introduce a candidate or a question. When you (the skill) see a candidate implied in the state, propose it — don't wait to be asked.

### 4. Synthesize

As candidates emerge or change during the conversation, propose concrete file actions:

- **New candidate** → propose a file at `openspec/candidates/<id>.md` using the template
- **Existing candidate updated** → propose impact/effort changes, dependency changes, status transitions (active → completed | rejected | superseded), or new entries in the Changes checklist
- **Bump `last-reviewed`** on any candidate discussed in this session (set to today's date)
- **Archive a candidate** → if status moves off `active`, move the file from `openspec/candidates/<id>.md` to `openspec/candidates/archive/<id>.md`

For each proposed action, the user accepts, edits, or rejects before any write happens.

### 5. Close

Output:

- Files created or modified (paths)
- Status transitions applied
- Recommended next step:
  - `Run /flow-plan <candidate-id>` to promote a candidate to a full OpenSpec change
  - `Sit with these candidates and revisit next session`
  - `Run /flow-vision first — vision feels stale` (if drift surfaced)
  - `Run /flow-retro <change-id> on the latest archive before deciding`

---

## Question bank

Pull from these as relevant. Do not ask all of them in one session.

### Vision check
Use when drift is suspected, when the user wants to reconnect, or roughly quarterly.

- Re-state the north star in your own words right now. Doesn't have to match CLAUDE.md verbatim — say what feels true today.
- What's the biggest gap between where the project is now and that north star?
- Any non-goals you'd add or remove?
- Has anything changed in *why* we're doing this?

### Pain / opportunity surfacing
Use when finding what's next or when the user says nothing specific is on their mind.

- What's been annoying you about the project lately?
- What have you been deferring? Why?
- What's fragile right now — something that works but you don't trust?
- Anything that was painful, that you fixed, that you're now afraid will regress?

### Environment / external
Use when surfacing what's next; helps catch external forcing functions.

- Anything changed in the tooling or ecosystem since last session? (deprecations, version bumps, new platforms)
- Any deadlines or external commitments?
- Any opportunities that close soon if not taken? (a contributor's bandwidth, a credit expiring, a market window)

### Triage (incoming idea)
Use when the user brings a specific topic.

- What's the problem or opportunity in one sentence?
- Rough sketch of how we'd attack it (direction, not design)?
- One effort, or does it want to break into multiple changes? What's the smallest first slice?
- What does it depend on? What does it unblock?
- First read on impact (high/medium/low) and effort (small/medium/large)?
- Why now / why not yet?

### Re-ranking
Use when the user wants to walk existing active candidates.

- For each active candidate: still active? Still rated correctly? Anything new about it since last review?
- Are there obsolete candidates that should be rejected or superseded?
- Are dependencies still accurate?

### Retro-driven
Use when reflecting on recent retros.

- Looking at the most recent retros: any candidates implied here?
- Any patterns across multiple retros that suggest a structural issue worth a candidate?
- Anything that surprised us, that we should bake into vision or conventions?

---

## Candidate file shape

When proposing a new candidate, copy `openspec/candidates/_template.md` and fill in the placeholders. The template:

```markdown
---
id: <kebab-case-id>
status: active             # active | completed | rejected | superseded
created: <YYYY-MM-DD>
last-reviewed: <YYYY-MM-DD>
impact: <high|medium|low>
effort: <small|medium|large>
dependencies: []           # candidate or change ids that must land first
---

## Problem / opportunity

<What's painful, surprising, or possible. One paragraph.>

## Sketch of direction

<A few sentences — not a design, just the shape of how we'd attack this.>

## Changes (discrete efforts within this candidate)

<Track changes as checkboxes. Mark each one's status inline.>

- [ ] **<change-name>** — <short description> *(not yet promoted)*

## Open questions

<Things to resolve before promoting the next change.>

## Why now / why not yet

*Optional.* <Urgency signal. What would make this a no-brainer. What would make us defer.>
```

When porting this skill to a new project where `openspec/candidates/_template.md` doesn't exist, write the content above as the template file during scaffolding (see Guardrails).

A candidate is **epic-style**: it can contain multiple OpenSpec changes tracked as checkboxes. When all changes are merged and any open questions are resolved, the candidate's status becomes `completed` and the file moves to `openspec/candidates/archive/`.

Note: a change does not have to come from a candidate. Hotfixes and urgent one-offs can go straight to `/opsx:propose`. The candidate→change path is the primary route, not the only one.

---

## Guardrails

- **Never replace the user's judgment.** Propose; don't decide. Every file write is gated on the user's accept.
- **Don't pad with candidates.** If nothing's worth proposing, say so. Quality > volume.
- **Don't re-litigate rejected/superseded ideas without new information.** When you see one in `archive/`, treat the rejection as standing unless something specific has changed since `last-reviewed`.
- **Vision drift is a signal, not a task.** If you notice vision feels stale, flag it and recommend `/flow-vision`. Don't try to fix it inline.
- **Keep candidates lightweight.** If a candidate file is growing past one screen, it's a hint to promote it via `/flow-plan` rather than keep refining it as a candidate.
- **Read-only on memory.** This skill reads memory for context but does not write to it. Plan, Implementation, and Retro skills handle their own memory updates.
- **If `openspec/candidates/` does not exist** (e.g. porting this skill to a new project), propose creating it (plus `archive/` subfolder and `_template.md`) using the template content from the **Candidate file shape** section above. Don't fail silently.
