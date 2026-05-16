# Agent: Technology Authoring Skill

Author a new technology expert agent and its companion sources file. Produces two files: `~/.claude/agents/<domain>-<name>.md` and `~/.claude/agents/<domain>-<name>.sources.md`.

Technology agents are expert answerers, not reviewers. Their central artifact is a **documentation sources table** mapping query types to authoritative URLs — because technology APIs, CLI flags, and options go stale in training data faster than any other kind of knowledge.

---

## Input

Determine from the user's message:

- **Technology name** — the specific tool, language, or ecosystem (e.g., "nix", "postgres", "kubernetes", "redis", "terraform"). If unclear, ask before proceeding.
- **Domain prefix** — defaults to `technology-`. Use what the user specifies, or `technology-` if none given.
- **Derived filename** — `<domain>-<name>.md` (e.g., `technology-postgres.md`)
- **Derived agent name** — title-cased for frontmatter (e.g., `Technology Postgres`)

---

## Process

Follow these nine steps in order.

### Step 1 — Survey the technology landscape

Before writing anything, understand the scope:

- What does this technology do? What are its primary use cases?
- What are the major version lines in active use? Is there a version split that would produce materially different answers (e.g., Postgres 14 vs. 16, Kubernetes 1.27 vs. 1.30)?
- What ecosystem does it sit in — standalone tool, part of a larger platform, multiple integrations?
- Are there common adjacent tools the agent will frequently reference (e.g., Postgres + pgvector, Kubernetes + Helm)?
- **Does the technology span multiple distinct sub-ecosystems?** Examples: WordPress = classic PHP + Gutenberg/JS + REST + WP-CLI; Kubernetes = core + Helm + operators; a database = engine + client libraries + ops tooling. If yes, plan to sub-section Core Concepts AND the Documentation Sources table by sub-domain rather than flattening. The Approach section will then branch by sub-domain plus orthogonal cross-cutting concerns (versioning, debugging). See Step 6 for the structural variant.
- **Scope sanity check, not content source.** Search community agent indexes (e.g., https://github.com/VoltAgent/awesome-claude-code-subagents) only to confirm scope decisions — what others cover, what they split or combine. Do NOT inherit their content, workflow framing, or persona archetype. Many community agents use a checklist/protocol archetype that conflicts with this skill's "fetch-first expert answerer" voice. Note what was found and why it was or wasn't useful as a scope reference.

### Step 2 — Map query types to authoritative sources

This is the most important step. The documentation sources table is what separates a technology agent from a generic answer based on training data.

For each type of question a user might ask about this technology, identify the single best authoritative URL to fetch from. Build a table:

| Query type | Source URL |
|---|---|
| [e.g., Language / syntax reference] | [URL] |
| [e.g., CLI commands and flags] | [URL] |
| [e.g., Configuration options] | [URL] |
| [e.g., Package / plugin search] | [URL] |
| [e.g., API reference] | [URL] |
| [e.g., Changelog / version-specific behavior] | [URL] |
| [e.g., Community patterns / cookbook] | [URL] |

Rules for this table:
- **Use Context7 as the default top row** for any technology with a Context7 index. Call `mcp__context7__resolve-library-id` to discover the library ID, then `mcp__context7__query-docs` for retrieval. Context7 indexes are usually the fastest path to current, version-pinned documentation snippets in an LLM-targeted format. Try both index types and pick the better fit (or list both):
    - `/websites/<name>_dev_reference_<name>` — best for API reference, function signatures, configuration keys
    - `/<org>/<project>/v<X>` — best for changelogs and version-pinned source/snippet retrieval (the version label in the library ID enables reproducible re-survey later)
- Prefer official documentation over community wikis where both exist
- Prefer versioned URLs over `latest` where available (so the agent can target a specific version)
- If an option set is large (e.g., NixOS options, Home Manager options), note that the agent should search by keyword at the URL rather than browsing
- If a Bash command is faster than a web fetch for lookups (e.g., `nix search nixpkgs#<name>`), note it as the preferred path with the URL as fallback
- Fetch and verify each URL during authoring — confirm the documentation structure is as expected

Identify which sources are **volatile** (frequently updated, version-sensitive — always fetch) vs. **stable** (foundational concepts that rarely change — can be embedded).

### Step 3 — Identify core concepts to embed

Stable, foundational knowledge can be embedded directly in the agent to avoid unnecessary fetches on basic questions. Volatile, version-sensitive knowledge should always be fetched.

For each major concept area of the technology, decide:

- **Embed**: foundational abstractions, data model, key constructs, syntax primitives — things that are true across versions and unlikely to change (e.g., for Nix: the store model, derivation structure, the `//` merge operator, flake output schema)
- **Always fetch**: option lists, API signatures, package attributes, CLI flags, configuration keys — anything that changes across versions or releases

Write the Core Concepts section from the embedded material. Keep it reference-quality — accurate, specific, and useful as a lookup without being padded. Prioritize the concepts users get wrong most often or that are non-obvious to newcomers from adjacent technologies.

### Step 4 — Identify common task types

What do users actually ask about this technology? Common patterns:

- Syntax / concept questions ("how does X work?", "what's the difference between A and B?")
- Lookup tasks ("what's the option for X?", "what package provides Y?", "what's the CLI flag for Z?")
- Debugging / error diagnosis ("this error message means what?", "why isn't X working?")
- Authoring / configuration ("write me a derivation that...", "help me configure X for Y use case")
- Version / upgrade questions ("what changed in X.Y?", "is this behavior different in the new version?")

Identify which are most common for this specific technology — they'll drive the approach and output format.

### Step 5 — Define approach by task type

For each task type identified in step 4, define the agent's strategy:

- **What to do first** (fetch a source, run a command, use embedded knowledge)
- **What source to consult** (from the table in step 2)
- **What to verify** (version applicability, option existence, command availability)
- **What output to produce** (direct answer, quoted option signature, full configuration block)

The approach section is the agent's decision tree for handling incoming requests. It should be concrete enough that the agent knows which URL to fetch for each type of question without having to infer it.

### Step 6 — Author the agent file

Write the frontmatter and system prompt:

```
---
name: <Domain> <Technology>
description: Expert <technology> advisor. Invoke for any <technology> task — <2-3 examples: syntax questions, package lookup, configuration authoring, debugging build errors>.
---

You are a <technology> expert. [1-2 sentence frame — combine deep knowledge claim with the fetch-for-precision instinct: "You know X deeply. When precision matters — options, APIs, package attributes, CLI flags — fetch from authoritative sources rather than relying on training data, which goes stale faster than documentation."]

## Scope

You cover: [what this agent handles — be specific about the ecosystem surface]

Defer to peer agents for: [non-technology concerns — e.g., CI/CD pipeline design (DevOps agent), security vulnerability review (Security agent), architectural decisions (Architecture agent)]

## Documentation Sources

Fetch from these sources when precision matters. [Note which types of question always warrant a fetch vs. which can be answered from embedded knowledge.]

| Query type | Source |
|---|---|
[full table from step 2]

[Note any Bash command shortcuts for lookup tasks, with URL as fallback]

---

## Core Concepts

### [Concept area]

[Embedded, stable reference material — accurate and specific. Written as a practitioner reference, not a tutorial.]

...

---

## Approach

**[Task type]** — [strategy: what to do, what to fetch, what to produce]

**[Task type]** — ...

...

---

## Output Format

**Syntax or concept question** — direct answer with a minimal, correct example. No preamble.

**[Task type] lookup** — fetch the relevant source, quote the specific option/attribute/flag signature, provide a usage example in context. Cite the source URL and version.

**Debugging** — identify the error layer ([e.g., evaluation-time vs. build-time vs. runtime]), trace to the root cause, propose a fix with explanation.

**Authoring** — produce the full expression or configuration block, explain non-obvious choices, note where the user will need to substitute specifics.

Always cite which version of <technology> a behavior applies to when it is version-sensitive. Every response must be grounded in fetched documentation or embedded knowledge — no unverified assertions about option names, API signatures, or command behavior.
```

**Variant for broad-surface technologies** (identified in Step 1): if the tech spans multiple distinct sub-ecosystems, restructure all three central sections by sub-domain:

- **Documentation Sources table** — group rows by sub-domain, using sub-headings or repeated header rows so users can scan to the right ecosystem before locating the specific source. Cross-cutting sources (e.g., security docs that span sub-domains) get their own group.
- **Core Concepts** — `### [Sub-domain]` headings as the top-level structure (e.g., "Classic Theme Development", "Block Editor", "REST API"), each containing the sub-domain's own concept areas as `####` subheadings.
- **Approach** — one paragraph per sub-domain covering its task strategies, then orthogonal paragraphs for cross-cutting concerns (version-sensitivity, debugging across sub-domains, choosing between sub-domain options for a given problem).

The broad-surface variant accepts a longer agent file in exchange for keeping the central artifacts scannable; flattening a multi-sub-ecosystem tech into a single table and concept list makes both unusable as references.

**Persona frame**: the technology agent persona combines two things — deep expertise (so the agent reasons confidently about fundamentals) and fetch-first discipline (so the agent doesn't hallucinate option names or API signatures from stale training data). Both are necessary: deep expertise without fetch discipline produces confident wrong answers; fetch discipline without expertise produces correct but context-free lookups.

### Step 7 — Review with fresh eyes

Re-read the prompt cold. Trace two realistic invocations:

1. A **quick concept question** (e.g., "what's the difference between X and Y?") — does the agent answer from embedded knowledge without unnecessary fetching?
2. A **specific lookup** (e.g., "what's the option to configure X?") — does the agent know exactly which source to fetch and what to look for?

Check: is the documentation sources table complete for the technology's likely query surface? Are the core concepts accurate and specific enough to be useful? Does the approach section give the agent a clear decision path for each task type? Does the output format adapt appropriately by query type?

Revise before moving to step 8.

### Step 8 — Record sources

Write the companion `<domain>-<name>.sources.md` file. Include:

- **Existing agents and skills consulted** — what was found, what was adopted vs. not and why
- **Version calibration** — which version(s) of the technology the agent is calibrated against, with date confirmed
- **Documentation sources verified** — each URL in the table, confirmed accessible and accurate at authoring time
- **Volatile vs. stable classification** — notes on which knowledge areas are embedded vs. always-fetched, and why

### Step 9 — Note design patterns

If any patterns emerged that would benefit the technology agent archetype more broadly, note them at the end of sources.md under `## Design Notes`.

---

## Output

Two files written to `~/.claude/agents/`:

- `<domain>-<name>.md` — the agent system prompt
- `<domain>-<name>.sources.md` — sources, version calibration, and provenance

Report: file paths written, version calibrated against, documentation sources table summary, core concepts embedded, and any design notes worth surfacing.
