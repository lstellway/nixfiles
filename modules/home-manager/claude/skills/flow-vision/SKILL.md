---
name: flow-vision
description: Refine the project's north star, values, non-goals, and guardrails as a thought-partner conversation. Output is targeted edits to CLAUDE.md (and occasionally other repo conventions), not a separate doc. Use periodically (roughly quarterly), when drift is suspected, or when a major shift in context warrants re-examining intent.
license: MIT
metadata:
  author: lstellway
  version: "0.1"
---

Refine the project's intent. Vision is a thought-partner role — it asks prompts; the user steers; either party may surface a concern.

Vision is the role in the 5-step workflow (Vision → Strategy → Plan → Implementation → Retro) that keeps the project's stated intent honest and current. It sits upstream of Strategy: Strategy decides *what* to work on next, but only by reference to what Vision says the project is *for*.

The deliverable is **targeted edits to CLAUDE.md** (and occasionally `.claude/rules/`, `.claude/skills/`, or `openspec/specs/`). Vision never produces a separate "vision doc" — the project's intent already has a home, and that home is CLAUDE.md.

---

## When to use this skill

- Roughly quarterly, as a deliberate health-check on project direction
- When `/flow-strategy` flags suspected drift and recommends a vision pass
- When a retro surfaces something that contradicts the stated intent
- When a major external shift (new constraint, new stakeholder, new market context) warrants re-examining why this project exists
- When you notice yourself describing the project in conversation differently than CLAUDE.md describes it

Vision is the **least frequent** flow skill. If you find yourself running it more often than once a quarter, look at why — frequent vision churn is usually a signal that something else (strategy, planning, or implementation) is the actual problem.

---

## Steps

### 1. Read current state

Delegate to the Explore agent (thoroughness: "quick") to digest the current intent surface. Brief it to read:

- `CLAUDE.md` — full file, with focus on intent/overview/architecture sections
- `openspec/changes/archive/*/retro.md` — most recent 3–5 retros, looking specifically for "Feeds Strategy" sections that mention vision or convention drift
- Any other repo-level docs that touch intent (e.g. `README.md`, `docs/vision.md` if it exists)
- The user's memory at `~/.claude/projects/<sanitized-cwd>/memory/MEMORY.md` and linked methodology files (read-only)

Ask the agent for a short snapshot:

- **North star (as stated)** — what CLAUDE.md says the project is for, in one or two sentences
- **Stated values / principles** — bullets from CLAUDE.md (if any)
- **Stated non-goals** — bullets from CLAUDE.md (if any)
- **Drift signals** — anything from recent retros, recent commits, or recent candidates that seems to contradict the stated intent
- **Last-touched** — when CLAUDE.md's intent-adjacent sections were last meaningfully edited (from git history)

The subagent digest protects main context — the user sees the snapshot, not the raw state.

### 2. Open the session

Show the user the snapshot. Then ask, open-ended:

> What brings you here?

If the user came in via a recommendation from `/flow-strategy` ("vision feels stale, recommend `/flow-vision`"), reflect that back as a starting point. Otherwise, let the user steer.

### 3. Branch on intent

Pull prompts from the **question bank** below. Don't walk it top-to-bottom; pick what matches where the conversation is going. Common branches:

- *Periodic health-check* — **North star** + **Drift detection** + **External**, in that order, lightly
- *Drift suspected* (often flagged by Strategy) — **Drift detection** first, deeply; then whichever bank surfaces the most signal
- *Single-area refinement* (e.g. just non-goals) — go straight to that bank
- *Major external shift* — **External** + **Failure modes**

Stay conversational. Either party may surface a concern. When you (the skill) see a contradiction between CLAUDE.md and recent retros/code, name it — don't wait to be asked.

### 4. Synthesize CLAUDE.md edits

As the conversation produces refinements, propose **small targeted edits** to CLAUDE.md:

- Add or revise a sentence in the intent/overview section
- Tighten or loosen a non-goal
- Add a value or principle that's been emerging implicitly
- Remove a stated value or non-goal that's been quietly abandoned (better to delete it honestly than leave it stale)

Each edit is user-gated. Show the diff (or the old/new text), let the user accept, modify, or reject.

**Never replace the whole file.** Vision is refinement, not rewriting. If a section feels like it needs a full rewrite, that's a signal something bigger is going on — propose it as a candidate for `/flow-strategy` rather than landing a big diff inline here.

**Sometimes the right edit isn't to CLAUDE.md.** If a value would be better encoded as a guardrail in a flow skill (`.claude/skills/flow-*/SKILL.md`), or as a capability constraint (`openspec/specs/`), or as a rule file, propose that instead. Use the right surface for the shape of the rule.

### 5. Close

Output:

- Files edited (paths + brief description of each edit)
- Anything deferred to a candidate (link by id)
- Recommended next step:
  - `Run /flow-strategy` if the refinement surfaced backlog implications
  - `Sit with the new framing for a week, revisit if it doesn't stick`
  - `Run /flow-vision again in ~3 months` for periodic health-check cadence

---

## Question bank

Pull from these as relevant. Do not ask all of them in one session.

### North star
Use when the user wants to restate the project's purpose or when the stated north star feels worn.

- State the project's north star in your own words right now. Don't peek at CLAUDE.md first.
- If a new contributor showed up tomorrow, what single sentence would tell them why this exists?
- What problem does this solve that wasn't being solved before — or wasn't being solved well?
- If you had to drop everything in the project except one thing, what would you keep?

### Values / principles
Use when surfacing implicit values, or when the user wants to codify how the project gets built.

- What's a tradeoff you'd always make in one direction, no matter who asks?
- What's a temptation you keep declining? Why?
- What "industry standard" or "best practice" do you intentionally diverge from? Why?
- What's something you've corrected someone (or yourself) on more than twice? That's probably a principle worth naming.

### Non-goals
Use when scope creep is suspected, or when the user wants to re-affirm what they're *not* building.

- What's something this project will deliberately never do?
- Is there a feature, scope, or audience you've turned down recently? What was the reasoning?
- Anything that *used* to be a non-goal that you're now reconsidering — and why? Has the underlying reason changed?
- What would success look like that you'd actually be embarrassed by?

### Failure modes
Use when stress-testing the vision, or when external pressure is high.

- A year from now, looking back, what would mark this as a failed project? Not "didn't ship" — what kind of failed?
- What's the worst-case path the project could drift down without you noticing? What would the early signals be?
- If the project succeeded but in the wrong way, what would that look like?

### Drift detection
Use when drift is suspected (often after Strategy flags it).

- Read your current CLAUDE.md vision/intent section. Does anything in it feel wrong now?
- Anything that's true about the project today that wasn't true when you wrote that?
- Anything you've said in conversation about this project lately that contradicts what CLAUDE.md says?
- Recent retros surfaced X / commits show drift toward Y. Does that ring true, or is the stated intent still right?

### External / forcing
Use when the landscape has shifted, or when a new constraint has appeared.

- Anything changed in the world (tooling, market, regulation, team) that should change *why* you're doing this?
- New constraint (legal, financial, technical) that should be reflected in non-goals or values?
- Anyone new in the picture (stakeholder, contributor, user) whose perspective should shape the vision?
- Any opportunity that closes soon if the vision doesn't expand to include it?

---

## Guardrails

- **Edits, not rewrites.** Vision refines CLAUDE.md sentence by sentence. If you find yourself proposing a full-section rewrite, stop and ask whether this is actually a Strategy-scoped change that needs a candidate.
- **CLAUDE.md is the primary surface.** Don't create a separate vision doc. Don't add a "vision" frontmatter field. The project's intent already has a home.
- **User-gated edits throughout.** Propose; don't decide. Every CLAUDE.md change is shown to the user before it lands.
- **Right surface for the rule shape.** Some refinements aren't sentences in CLAUDE.md — they're guardrails in a skill, capability constraints in `openspec/specs/`, or rules in `.claude/rules/`. Use the right surface; don't force everything into CLAUDE.md.
- **Don't pad.** If the session produces no concrete edits, say so and close out. A "no changes, vision still holds" outcome is a valid result.
- **Read-only on memory and on OpenSpec artifacts.** Vision reads them for context but doesn't write to either. (Memory is user-scoped — vision changes affect the whole team and belong in repo artifacts.)
- **Don't re-litigate recent decisions.** If a non-goal was added/removed within the last quarter, treat that as standing unless something specific has changed. Vision drift is slow; rapid oscillation usually means something other than vision is unsettled.
- **Quarterly cadence is a target, not a contract.** If nothing's drifting, don't manufacture a session.
