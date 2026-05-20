# Agent: Discipline Authoring Skill

Author a new discipline advisor agent and its companion sources file. Produces two files: `~/.claude/agents/<domain>-<discipline>.md` and `~/.claude/agents/<domain>-<discipline>.sources.md`.

---

## Input

Determine from the user's message:

- **Discipline name** — the area of expertise (e.g., "security", "data privacy", "accessibility"). If unclear, ask before proceeding.
- **Domain prefix** — defaults to `software-`. Use the prefix the user specifies, or `software-` if none given.
- **Derived filename** — `<domain>-<discipline>.md` (e.g., `software-security.md`)
- **Derived agent name** — title-cased for frontmatter (e.g., `Software Security`)

---

## Process

Follow these nine steps in order. Do not skip steps — the quality of the agent depends on research done before writing.

### Step 1 — Search existing agents and skills

Search for reference implementations covering this discipline:

- Check https://github.com/VoltAgent/awesome-claude-code-subagents for relevant agents
- Check any existing agents in `~/.claude/agents/` that overlap with this discipline
- Note what was found AND what was reviewed but not adopted, and why — this goes in sources.md

### Step 2 — Survey major frameworks and standards

Identify the key frameworks, methodologies, and standards for this discipline. Survey broadly — there will be multiple.

For **versioned standards** (OWASP, NIST, ISO, WCAG, ASVS, etc.): verify the current edition before mapping categories. Model training data frequently references outdated releases. Fetch the authoritative source to confirm.

Record a version pinning table in sources.md:

| Framework / Standard | Version | Date confirmed | Notes |
|---|---|---|---|

For **regulatory disciplines** (privacy, compliance, accessibility): identify which regimes apply (GDPR, CCPA, HIPAA; SOC 2, ISO 27001, PCI DSS; WCAG 2.2, Section 508) — rules differ materially by jurisdiction and regime.

### Step 3 — Distill core heuristics

Extract the questions, anti-patterns, and checks that recur across frameworks. These become the substance of the agent's "What to Assess" sections.

**Specificity test**: for each heuristic, ask — can the model actually run this check from what it's likely to receive (code, diff, config, schema, spec)? If not, reframe it as a question to surface rather than a check to run. Concept labels ("check naming", "review auth") are not heuristics.

**Catalog names**: for disciplines with established catalogs (OWASP Top 10, CWE classes, STRIDE, Nygard stability patterns, test smell taxonomies, Nielsen heuristics), embed the canonical names directly in the agent. They are more actionable than paraphrases and make findings traceable to source.

**Evidence-gating**: for findings that require external evidence to confirm (profiling output, query plans, metrics), note what evidence is required to escalate severity, and cap the finding at `[Info]` without it. This prevents speculative findings the developer cannot act on.

### Step 4 — Define scope boundaries

Identify which adjacent agents handle overlapping concerns.

State boundaries **bidirectionally** — for any overlapping concern, describe both what stays in this agent and what defers to the peer: "stay here for X; defer Y to a [capability/role] specialist." One-directional deferrals leave users caught between agents.

**Cross-reference rule** — refer to peer agents by **capability or role description**, never by agent name. Write "a security specialist," "the observability discipline agent," "a fraud-pattern detection specialist" — not `software-security`, `software-observability`, `marketplace-trust-safety`. Name-based cross-references rot when the roster is renamed, reorganized, or replaced; capability descriptions stay accurate because the orchestrator matches them against the current roster at call time. This applies to every cross-reference the agent makes.

For concerns that are relevant to raise but whose remediation belongs to a peer agent, use the **surface-then-defer pattern**: flag the issue here, then explicitly direct the user to the appropriate peer agent (by capability). Do not silently ignore cross-cutting concerns, and do not overreach into territory that requires the peer's depth.

### Step 5 — Define task modes

Identify the primary ways this agent will be invoked. For each mode, trace the full invocation:

- What does the agent receive?
- What must it produce?
- What is likely missing?

Define the output format from that scenario, not in the abstract. Ground each mode in a real invocation scenario.

**Every agent must include a PR / change review mode.** This is the most common invocation. Additional modes depend on the discipline (design assistance, audit, threat model, schema review, etc.).

### Step 6 — Author the agent file

Write the frontmatter and system prompt. Follow this structure:

```
---
name: <Domain> <Discipline>
description: Expert <discipline> advisor. Invoke for any <discipline> task — <2-3 examples>. <One sentence clarifying scope boundary with the most adjacent/confusable agent, if one exists.>
---

[Persona — one or two sentences. Decision-making frame, not an expertise claim.]

[Optional second instruction paragraph if the discipline has a primary evaluation criterion worth stating separately.]

## Scope

You cover: [sub-topics list]

Defer to peer agents for depth on:
- **[Peer capability/role — e.g., "a security specialist", "the observability discipline agent"]**: [what defers there] — stay here for [what stays here]
- ...

(Cross-references must be capability/role descriptions, never agent names. See Step 4.)

## Context

Useful context: [what helps]. If not provided, state your assumptions and proceed — note where missing context would materially change a finding rather than blocking on it.

[## Step 1: [Detection Step] — include this section for disciplines where rules vary by input type]

[For protocol/format detection: REST vs. GraphQL vs. gRPC]
[For regulatory regime detection: GDPR vs. CCPA vs. HIPAA vs. SOC 2 vs. ISO 27001]
[State assumptions when unclear, apply only relevant sections, skip inapplicable ones.]

---

## What to Assess

### [Sub-topic]

[Specific, executable checks — not concept labels]

...

---

## Output Format

Adapt output to the task. Calibrate depth to scope.

**PR / change review**

First, assess whether this change touches [domain]. If it clearly does not, state that explicitly and stop.

1. **Intent** — what is this change trying to accomplish?
2. [Domain-specific section if warranted]
3. **Findings** — each tagged `[Critical / High / Medium / Info]`, citing the specific file, function, call site, or pattern; why it matters; cost of fixing vs. ignoring
4. **What's Working** — [domain] decisions in the diff worth preserving; omit if none apply
5. **Questions** — context gaps as specific questions, not blockers

**[Additional mode]**
...

Every response must cite specific [files / endpoints / fields / components] — no ungrounded assertions.
```

**Persona guidance**: write around a decision-making frame, not an expertise claim. "You treat every dependency as a trust decision" shapes how the model prioritizes. "You are an expert in X" adds nothing. The frame should encode the primary evaluation criterion for the discipline.

**Context detection**: include an explicit Step 1 detection section (before "What to Assess") for disciplines where rules vary by input type:
- *Protocol/format* — REST vs. GraphQL vs. gRPC: detect first, apply only the relevant protocol rules
- *Regulatory regime* — GDPR vs. CCPA vs. HIPAA, or SOC 2 vs. ISO 27001 vs. PCI DSS: identify applicable regimes, note assumptions when jurisdiction or framework is unclear

### Step 7 — Review with fresh eyes

Re-read the prompt as if receiving it cold. Trace a realistic invocation:

- What does the agent receive in the most common case?
- How does each section get applied?
- What output does it produce?

Check: are heuristics specific enough to act on without additional context? Does the persona frame actually shape prioritization? Are scope deferrals unambiguous and bidirectional? Does the PR review mode have a no-findings gate? Is there a "What's Working" section?

Revise before moving to step 8.

### Step 8 — Record sources

Write the companion `<domain>-<discipline>.sources.md` file. Include:

- **Existing agents and skills consulted** — including sources that were reviewed but not adopted, with a note on why
- **Frameworks and standards surveyed** — version pinning table (Framework | Version | Date confirmed | Notes)
- **Articles and checklists** that informed specific heuristics, with URLs

### Step 9 — Note design patterns

If any patterns emerged during authoring that would benefit future agents or the authoring process, note them at the end of sources.md under `## Design Notes`. If a pattern is broadly applicable, flag it explicitly so it can be considered for the design documentation.

---

## Output

Two files written to `~/.claude/agents/`:

- `<domain>-<discipline>.md` — the agent system prompt
- `<domain>-<discipline>.sources.md` — references and provenance

Report: file paths written, key decisions made (persona frame chosen, scope boundaries set, modes defined), and any design notes worth surfacing.
