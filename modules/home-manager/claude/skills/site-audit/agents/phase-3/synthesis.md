You are synthesizing a website audit for a new owner. You have access to 20 research
artifacts produced by specialist agents across four research phases.

SITE URL: {{URL}}
SITE SLUG: {{SITE_SLUG}}
SITE OVERVIEW: {{PHASE_0_SUMMARY}}
KNOWN CONTEXT: {{KNOWN_CONTEXT}}

## Artifacts to read

Read all files in `research/{{SITE_SLUG}}/artifacts/` — all phases (phase-1/, phase-2a/, phase-2b/).
Do not summarize each artifact. Extract and synthesize across them.

## What to produce

Write research/{{SITE_SLUG}}/synthesis.md with these sections:

### Executive Summary
1 page maximum. What is the overall state of this site for the new owner?
Lead with the 3-5 most important things they need to know.
Write for a non-technical owner making decisions, not a developer.

### Quick Wins
A table of high-priority, low-effort actions:

| Action | Effort | Expected Impact | Source |
|--------|--------|-----------------|--------|
| ...    | S      | ...             | angle-name |

Include ONLY items that appear as [Priority: H] [Effort: S] across the artifacts.
Be specific — "Add phone number to header" not "Improve contact information."
Maximum 10 rows.

### Top 3 Risks
The three issues requiring the most urgent attention — regardless of effort.
For each:
- **Risk**: what it is
- **Why it matters**: consequence if unaddressed
- **Suggested first step**: the single most useful next action

### 90-Day Priority Roadmap
A phased action list grouped by timeframe:

**Month 1 — Foundations** (critical fixes and quick wins)
- ...

**Month 2-3 — Growth** (meaningful improvements)
- ...

**Ongoing** (monitoring and iteration)
- ...

Keep the roadmap to 15 items maximum. Do not include every finding — prioritize.

### Research Confidence
(Appendix — not part of the main deliverable)

List angles where research confidence was limited:
- Angle name: reason (e.g. "login wall", "no external reviews found", "bot detection")

Also list any [inaccessible] surfaces that the owner should verify manually.

## Rules

- Do not recite findings from individual artifacts verbatim — synthesize
- Quick wins must be specific and actionable, not generic
- **Effort label conflicts**: when two artifacts assign different effort ratings to the
  same item, use the higher (more conservative) estimate and note the disagreement in
  the Source column (e.g. "Source: legal-structural [S], analytics [M] — using M")
- **Risk ordering**: rank risks by severity tier — legal/structural exposure first,
  then operational gaps, then growth/strategic gaps. Within a tier, rank by urgency.
- **Recurring revenue gap**: if the site has no subscription or recurring revenue model
  and the competitive set does, treat this as a strategic risk worth surfacing — either
  as a top-3 risk or as a roadmap item, depending on relative severity.
- **Executive summary count**: use 3-5 most important things. Do not pad to fill a number;
  do not exceed 5. Each item must be first-week-critical to qualify.
- Risks must be addressed by severity and urgency, not by phase order
- The owner should be able to act on this document without reading the individual artifacts
- Do not surface confidence caveats in the executive summary — keep them in the appendix
