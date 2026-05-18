---
name: plan-change
description: Multi-agent change planning skill. Triages a change request, fans out to relevant specialist agents in parallel, and delegates OpenSpec artifact creation to a subagent. Use when starting a feature, fix, or modification that warrants spec-driven planning. Runs a shape pre-flight first (bails on requests too small, too big, or ambiguous). Requires OpenSpec in the project (bails if `openspec/config.yaml` is absent).
---

## Overview

This skill orchestrates a change planning pass:

1. **Shape pre-flight** — gut-check whether the request is the right size and clarity for one OpenSpec change. Splits, downsizes, or clarifies before spending agent budget.
2. **Discovery** — read the available agent roster from `~/.claude/agents/` and `.claude/agents/` so routing isn't hardcoded.
3. **Project context** — consult a project-context agent if the roster has one; otherwise read root `CLAUDE.md`; otherwise ask the user.
4. **Triage** — pick 2–4 relevant specialists from the discovered roster using implicit LLM judgment (see Routing Examples).
5. **Fan-out** — invoke chosen specialists in parallel, each with a focused ask.
6. **Synthesis + clarification** — gather constraints, tradeoffs, risks, and questions; ask the user to resolve any decisions needed before artifacts can be written.
7. **Delegate artifact creation** — spawn a `general-purpose` subagent that reads `~/.claude/skills/openspec-ff-change/SKILL.md` and executes it against the assembled brief. Subagent returns paths and a short summary; artifact text never enters this thread.
8. **Report** — surface the change name, artifact paths, specialists consulted, decisions resolved, gaps surfaced, and next steps.

This skill is the planning-side counterpart to `code-review`. Same fan-out shape, different goal: prepare to build, not assess what's built.

---

## Input Parsing

**Target** (required): the first argument — a natural-language description of the change. If omitted, use **AskUserQuestion** (open-ended, no preset options) to ask:

> "What change do you want to plan? Describe what you want to build, fix, or modify."

Do not proceed without a target.

---

## Steps

### 1. Verify OpenSpec is present

Run:

```bash
test -f openspec/config.yaml && echo present || echo missing
```

If output is `missing`, respond:

> This skill produces OpenSpec changes, but the current project doesn't appear to use OpenSpec (no `openspec/config.yaml` found). To set it up, run `openspec init`. If you'd like a plain-text plan instead, ask for one directly — this skill bails here.

**Stop.** Do not continue.

### 2. Shape pre-flight

Evaluate the request against three failure modes. Bias **permissive** — only flag on strong evidence. Marginal calls just proceed.

**Too big** — strong indicators:
- Multiple distinct user-visible behaviors bundled (e.g., "add sign-up *and* checkout *and* email")
- Spans multiple apps/services with independent stakeholders per surface
- Mixes building new with migrating existing
- Has an implicit dependency chain (you'd need to ship piece A before B before C)

**Too small** — strong indicators:
- Typo, single config tweak, dependency bump, or pure rename
- Pure internal refactor with no behavior change
- No definition-of-done beyond "the diff lands"

**Ambiguous / symptom-not-problem** — strong indicators:
- Multiple valid interpretations of what's being asked
- Request bakes in an implementation that may not be the simplest path to the actual goal
- Symptom framing ("X is slow") without enough scope to write a spec against

**Branch on the outcome:**

- **Proceed** — continue to step 3.

- **Too big** — output a concrete split sketch and stop:

  > This looks like multiple changes. Suggested split:
  >
  > 1. `<change-name-1>` — `<one-line scope>`
  > 2. `<change-name-2>` — `<one-line scope>`
  > 3. `<change-name-3>` — `<one-line scope>`
  >
  > Recommend running `/plan-change` separately per piece. If you disagree and want this as one change, tell me to proceed and I will.

  Do not continue. Do not negotiate. The user decides next.

- **Too small** — output:

  > This looks too small to justify an OpenSpec change — artifact overhead probably outweighs the value. Recommend going straight to a PR. If you disagree, tell me to proceed and I will.

  Do not continue.

- **Ambiguous** — use **AskUserQuestion** with **specific options** (not open-ended) to resolve the ambiguity. After the user answers, re-evaluate shape. Loop only once — if it's still ambiguous after one clarification, proceed with the user's stated interpretation.

### 3. Discover the agent roster

In parallel, glob agent files from both scopes:

- `Glob ~/.claude/agents/*.md`
- `Glob .claude/agents/*.md`

For each result, read just enough to extract frontmatter (top of file through the closing `---`). Treat a file as an agent only if its frontmatter has both `name` and `description` fields. Skip files like `*.sources.md` that have no frontmatter.

Build a roster:

```
[ { name, description, path }, ... ]
```

If the roster is empty across both scopes:

> No specialist agents found in `~/.claude/agents/` or `.claude/agents/`. This skill orchestrates between them; without any, there's nothing to orchestrate. Install agents using the `agent-domain`, `agent-discipline`, `agent-technology`, or `agent-persona` skills, then try again.

Stop.

### 4. Establish project context

Scan the discovered roster for a **project-context agent** — typically an agent whose description signals project-internal operations, terminology, or stakeholder mapping (descriptions mentioning terms like "platform context", "internal operations", "team", "stakeholders", "where knowledge lives", "project-internal"). Naming conventions vary across projects (`<project>-platform`, `<project>-context`, `<project>-internal`, etc.).

- **If one project-context agent exists**: invoke it as the first consultation. Ask it for: stakeholder mapping for this change, which apps/surfaces are touched, which other agents from the roster are relevant downstream, and any documentation gaps. Its output seeds the rest of the routing.

- **If none exists but a root `CLAUDE.md` exists**: read it. Use it as project context for the rest of the run. In the final report, note that consultation depth would improve with a project-context agent (point to the `agent-domain` skill).

- **If neither exists**: use **AskUserQuestion** (open-ended) to ask:

  > "I don't see a project-context agent or root `CLAUDE.md`. Give me a one-paragraph summary of this project's domain, team, and key stakeholders so I can route specialists appropriately."

### 5. Initial clarification (only if needed)

If, after project context is established, the request still has scope gaps that would meaningfully change triage or specialist consultation, use **AskUserQuestion** with **specific options** (not open-ended) to resolve them. Examples of what warrants clarification:

- Which app/surface is affected, when multiple are plausible
- Customer-facing vs. internal-tool-only
- New capability vs. modification of an existing one
- Hard deadline or dependency on other in-flight work

Aggregate related questions into a single multi-select where possible. Do not ask more than 2 questions in this step.

### 6. Triage — pick specialists

Using the agent roster, the project context, and the (possibly clarified) request, pick **2–4 specialists** to consult in parallel. Use implicit judgment — see **Routing Examples** below for the kind of reasoning to apply.

Heuristics:

- Match agent descriptions to the change's surface area: code surface, domain surface, user surface, ops surface.
- Don't invoke an agent whose description doesn't plausibly touch the change. (They'll return "not applicable" and waste a turn.)
- 4 is a soft cap. Reaching for 5+ usually means the change is too broad — re-check the shape pre-flight before fanning out.
- Discipline-level concerns (security, performance, reliability, data integrity, etc.) come from `software-*` agents. Domain depth comes from project-specific or vendor-neutral domain agents (e.g., `marketplace-*`, `payments-*`). Framework specifics come from `technology-*` agents.
- If the project has personas (`persona-*`) and the change is user-facing copy, flow, or affordance, consider invoking 1–2 of the most relevant personas for review.

### 7. Fan out in parallel

Invoke all selected agents **simultaneously in a single message** (multiple `Agent` tool calls in one assistant turn). Do not call them sequentially.

Each agent receives this prompt:

```
You are consulting on a proposed change. Apply your domain expertise.

CHANGE REQUEST: <original request, possibly scoped/clarified>

PROJECT CONTEXT: <2–4 sentence summary from the project-context agent or root CLAUDE.md>

USER CLARIFICATIONS:
<bullet list of any AskUserQuestion answers, or "(none)">

Your task: surface constraints, tradeoffs, and requirements relevant to your domain. Be concrete and specific. If this change does not touch your domain, return one line: "Not applicable — this change does not touch <your domain>."

Output format (when applicable):
- **Constraints** — must-haves the spec needs to capture
- **Tradeoffs / open decisions** — choices the user must make, with the considerations on each side
- **Risks / failure modes / gameable edges**
- **Suggested scope adjustments**, if any
- **Open questions** for the user, if any

Be terse. The orchestrator will compose your output into a brief for spec generation — do not produce narrative; produce bulleted findings.
```

### 8. Synthesize and clarify (post-specialist)

Collect specialist outputs. Build a working brief:

```
- Constraints: <merged across specialists>
- Tradeoffs the user must resolve: <merged>
- Risks / failure modes flagged: <merged>
- Scope adjustments suggested: <merged>
- Documentation gaps surfaced (from project-context agent): <list>
- Open questions: <merged>
```

If any tradeoffs require user resolution **before artifacts can be written**, use **AskUserQuestion** with **specific options sourced from the specialists' framing** to resolve them. Do not write artifacts with unresolved tradeoffs — the OpenSpec subagent runs non-interactively and will produce a confused spec.

Cap this step at 2 questions. If more decisions are open than that, the change is probably under-scoped — surface that to the user and let them choose to refine the request or accept your reasonable defaults.

### 9. Delegate artifact creation

Derive a kebab-case change name from the request. If it's not obvious, ask the user via **AskUserQuestion**.

Check if the change directory already exists:

```bash
test -d openspec/changes/<name> && echo exists || echo new
```

If `exists`, ask the user via **AskUserQuestion** whether to (a) pick a different name, (b) continue the existing change (in which case stop and recommend `/openspec-continue-change` instead of this skill), or (c) overwrite (rarely the right answer).

Then spawn a **single `general-purpose` Agent** (foreground — you need the result before reporting) with this prompt:

```
Read the file at `~/.claude/skills/openspec-ff-change/SKILL.md` and execute its procedure against the brief below.

The brief is intended to be complete. Do not ask the user clarifying questions. If you encounter context that the brief does not cover, make the most reasonable decision based on the brief and the project's existing specs/changes, and note it in your "surprises" section of the return.

CHANGE NAME: <kebab-case-name>

BRIEF:

Request: <scoped request after clarifications>

Project context: <summary>

Stakeholders / affected surface: <from project-context agent>

Constraints (from specialists):
<bulleted list>

Resolved tradeoffs (user decisions):
<bulleted list, with the user's chosen option for each>

Risks / failure modes to surface in the spec:
<bulleted list>

Scope adjustments incorporated:
<bulleted list>

When complete, return ONLY:
1. The change name (kebab-case)
2. The full paths of artifacts created
3. A 3-sentence summary of what the spec covers
4. Any surprises — decisions you had to make that the brief didn't cover

DO NOT return the artifact text. The orchestrator only needs paths and summary.
```

### 10. Report

Output to the user:

```markdown
## Change planned: <change-name>

**Location**: `openspec/changes/<change-name>/`

**Specialists consulted** (<N>):
- `<agent-1>` — <one-line on what they surfaced>
- `<agent-2>` — <one-line>
- ...

**Decisions resolved with you**:
- <question> → <answer>
- ...
(omit this section if no decisions were needed)

**Artifacts created**:
- `openspec/changes/<change-name>/proposal.md`
- `openspec/changes/<change-name>/tasks.md`
- ...

**Summary**: <3-sentence summary from the subagent>

**Surprises during artifact creation**: <from subagent, if any>

**Documentation gaps surfaced**:
- <gap-1> — recommend writing at <proposed path>
- ...
(omit if none)

**Next**: review the proposal at the location above. To start implementation, run `/openspec-apply-change`.
```

---

## Routing Examples

These illustrate the *kind* of judgment to apply. Your agent roster will differ — use these as patterns, not as a lookup table.

**Example A: "Add Sign in with Google to the public site."**

- Auth touch → a security-focused agent (`software-security` if present)
- UI flow change → a UX agent (`software-user-experience` if present)
- Framework specifics → relevant `technology-*` agent (Next.js, Rails, etc.)
- Project-context agent → stakeholder mapping, where login currently lives
- 3–4 specialists. Reasonable triage.

**Example B: "Add a 'verified' boolean to user profiles."**

- Schema change → `software-data-integrity` (defaults, migration safety, index plan)
- Auth/permission implications → `software-security`
- Privacy implications if user-visible → `software-data-privacy` if in roster
- Project-context agent → who decides what "verified" means; where it surfaces
- Probably no UX specialist unless the boolean shows up in UI.

**Example C: "The dashboard is slow; speed it up."**

- This is symptom-not-problem. **Shape pre-flight should flag this as ambiguous and clarify first**: what dashboard, slow how (load time, query latency, render?), measured how? After clarification, then triage. Demonstrates clarify-before-triage.

**Example D: "Migrate from Stripe to a different payment processor."**

- Architecture choice → `software-architecture`
- Security / PCI implications → `software-security`, `software-compliance` if in roster
- Reliability of the swap → `software-reliability`
- Project-context agent → stakeholders affected (customers, finance, support)
- No domain-specific specialist unless the project has one (e.g., a `payments-*` agent)
- **Shape pre-flight may flag this as too big** — vendor migrations are usually multiple changes (parity build, traffic cutover, decommission). Surface a split.

---

## Guardrails

- **Never skip the shape pre-flight.** It exists to save agent budget on malformed requests. Bias permissive, but always run it.
- **Never proceed without OpenSpec.** Bail with the clear message in step 1. Do not fall back to producing markdown plans — that is a different skill.
- **Always fan out in parallel.** Single message, multiple `Agent` tool calls. Sequential fan-out is a bug.
- **Cap specialists at 4 by default.** If you reach for 5+, the change is probably too broad. Re-check shape before continuing.
- **Never delegate to the OpenSpec subagent with unresolved tradeoffs.** It runs non-interactively; resolve open decisions via `AskUserQuestion` first.
- **Keep artifact text out of the main thread.** The subagent returns paths and summaries; `Read` a specific artifact later if needed for verification.
- **Never hardcode agent names in your reasoning.** Always route from the discovered roster. Names will differ across projects.
- **Don't fabricate routing.** If no agent in the roster covers a relevant concern, name the gap in the final report rather than pretending coverage exists.
- **Cap user questions at ~4 across the whole skill run.** Aggregate. More than that means scope is wrong — bail to the user instead of interrogating them.
- **Never auto-overwrite an existing change directory.** Ask first.
