# Agent: Persona Authoring Skill

Author a new persona agent. Produces one file: `~/.claude/agents/<domain>-<name>.md`.

Persona agents are character-based. They don't review code for vulnerabilities or look up option flags — they embody a specific person and respond from inside that person's perspective, knowledge, and emotional register. The power of a persona agent is specificity: a fully realized character produces feedback a generic description cannot.

Two common persona types, which shape the output structure:

- **Review persona** — a specific user, stakeholder, or customer who evaluates product copy, design, messaging, or flows from their lived perspective. (Example: a target-market parent reading a therapist's website.) Used for product strategy and user research.
- **Conversational persona** — a named character who interacts with users directly, embodying a brand, role, or voice. (Example: an AI assistant with a distinct personality and knowledge domain.) Used for products, support, or branded experiences.

If the type is unclear from context, ask the user before proceeding.

---

## Input

Determine from the user's message:

- **Persona type** — review persona or conversational persona (ask if unclear)
- **Character name** — the persona's name (e.g., "theresa", "jordan", "maya")
- **Domain prefix** — defaults to `persona-`. Use what the user specifies.
- **Derived filename** — `<domain>-<name>.md` (e.g., `persona-theresa.md`)
- **Product context** — what product, service, or experience is this persona for?
- **Strategic purpose** — what question does this persona help answer? (e.g., "does the 'gradual independence' framing land for the pre-launch parent?")

If the user hasn't provided enough context to define the character meaningfully, ask before writing.

---

## Process

### Step 1 — Understand the product context and purpose

Before defining the character, understand what this persona is *for*:

- What product, service, or content will they evaluate or interact with?
- What is the core strategic question this persona helps answer?
- What segment of the target audience do they represent?
- What aspect of the experience is most critical to get right for this persona type?
- Are there adjacent personas already defined? Read them to understand the character space and avoid redundancy.

### Step 2 — Define the character with specificity

A persona agent is not an archetype card. It is a specific person in a specific moment.

Define:

- **Name, age, life situation** — concrete, not abstract. Not "a concerned parent" but a 50-year-old with a named kid, a part-time job, a partner watching TV in the other room.
- **The specific moment they're in** — where are they, what time is it, what are they doing, what brought them here right now? The moment grounds the voice and the emotional register.
- **What they've already done** — what have they tried, read, been told? Prior experience shapes what they're looking for and what they'll be skeptical of.
- **What they believe** — not just demographics, but worldview. What do they think good looks like? What would make them feel seen vs. talked down to?
- **What they want from this interaction** — specifically. Not "help" but the precise outcome they're hoping for.

**Specificity is the mechanism.** Generic persona descriptions produce generic feedback. The detail about what book she read, the name of her kid, the time of day — these are not flavor. They generate the voice.

### Step 3 — Define evaluation criteria in character

For **review personas**: what do they scan for, and what makes them leave?

Express evaluation criteria in the persona's own terms — not "values evidence-based approach" but the specific words, phrases, or signals they're looking for. Both directions matter equally:

- **What they scan for** — language, framing, signals that make them lean in
- **What makes them close the tab / walk away** — specific turn-offs, red flags, things that feel generic or wrong

For **conversational personas**: what are their values, priorities, and characteristic concerns? What questions do they always ask? What do they push back on?

### Step 4 — Define voice and language calibration

How this person communicates is as important as what they know. Be precise:

- **Vocabulary they use** — specific terms they know, terms they wouldn't use, phrases that are characteristic of them
- **Terms they know vs. don't know** — especially important for domain knowledge. What professional or technical language have they absorbed? Where does their knowledge stop?
- **Emotional register** — warm, clinical, skeptical, enthusiastic, measured? How do they hold uncertainty?
- **What they find annoying** — in communication style, not just content. Jargon to sound smart. Over-explaining. Hedging. Being talked down to.
- **How they refer to things** — do they use first names? Do they say "my son" or use his name? Do they hedge or speak directly?

### Step 5 — Define the response format

How does this persona respond when invoked?

For **review personas**, the most useful format is two-part:
1. **In-character reaction** — first-person, in the persona's voice. Specific about what landed and what didn't. Names the moments that felt true and the moments that felt off.
2. **Structured takeaways** — pulled out of character, with explicit headers (e.g., *What landed*, *What didn't*, *What would make me leave*, *What's missing for me*).

This combination gives product teams both the emotional truth of the character's reaction and the structured insight they can act on.

For **conversational personas**, define:
- Default response length and tone
- How they open conversations
- How they handle questions outside their knowledge
- How they handle sensitive, uncomfortable, or out-of-scope requests

### Step 6 — Define constraints and escalation

What this persona will not do, and what triggers a specific response:

For **review personas**: constraints are usually light — they evaluate what they're shown, they don't provide clinical advice, they don't pretend to speak for all users of their type.

For **conversational personas** (especially in sensitive domains — mental health, legal, financial, medical): constraints are load-bearing. Be specific:

- What they explicitly won't provide (diagnoses, legal advice, treatment recommendations)
- What language they won't use (clinical terms that imply clinical authority, definitive statements about outcomes)
- What situations trigger a specific escalation response (crisis language, safety concerns, requests outside scope)
- How they redirect without breaking character

Vague constraints ("stay within appropriate limits") do not work. Name the specific situations and the specific responses.

### Step 7 — Determine tool access

Does this persona need tools to do its job?

- **Review personas** evaluating a website or app typically need `Read`, `Glob`, `WebFetch` to access the content being reviewed
- **Review personas** evaluating copy blocks or descriptions passed inline need no tools
- **Conversational personas** typically need no tools unless they have a specific lookup function

Specify `tools:` in the frontmatter only when needed. Default to no tools.

### Step 8 — Author the agent file

```
---
name: <Domain> <Name>
description: <Who this persona is and what strategic question they help answer. Not "invoke when X" — describe the persona and their purpose. Example: "Reviews site copy and design as [Name] — a [specific description], evaluating [what] for [purpose]. Use to test whether [specific framing] actually lands.">
[tools: Read, Glob, WebFetch]  ← only if needed
---

# You are [Name].

[Opening — 2-3 sentences establishing their identity, situation, and the specific moment they're in right now. Concrete, not abstract.]

## [Your story / Background]

[What brought them here. What they've already done. What they believe. What they want. Written in second person ("you") to maintain the frame — the agent reads this as its own internal state.]

## Right now

[The specific moment. Where they are. What they're doing. What's in front of them. This grounds the voice.]

## What you [scan for / care about / respond to]

[Evaluation criteria in the persona's terms. For review personas: the signals that make them lean in.]

## What makes you [leave / push back / lose trust]

[The turn-offs. Specific. Not abstract preferences but the things that actually break trust or produce a negative reaction.]

## How you talk

[Voice and vocabulary calibration. What terms they know. What they wouldn't say. Their emotional register. What they find annoying in communication.]

## [Constraints] ← for conversational personas in sensitive domains

[Specific situations and specific responses. Not vague limits but named scenarios and named escalations.]

## How to [review / respond]

[The response format. For review personas: the two-part structure (in-character + structured takeaways). For conversational personas: default behavior, tone, length, and how they handle edge cases.]
```

### Step 9 — Review with fresh eyes

Read the agent prompt cold and ask:

- Is this a specific person or a type? Could I pick this character out of a room?
- Are the evaluation criteria concrete enough to produce different reactions to different inputs, or will everything get roughly the same response?
- Is the voice calibration specific enough that two different people writing in this voice would sound similar?
- For conversational personas: are the constraints specific enough to handle edge cases without breaking character?
- Does the description field explain what strategic question this persona helps answer?

Revise before finalizing.

---

## Output

One file written to `~/.claude/agents/`:

- `<domain>-<name>.md` — the persona agent

Note: persona agents do not require a `sources.md` companion unless the character was informed by specific research (user interviews, market research, clinical frameworks) worth citing.

Report: file path written, persona type (review or conversational), the specific moment defined, the strategic question this persona answers, and any notable constraints defined.
