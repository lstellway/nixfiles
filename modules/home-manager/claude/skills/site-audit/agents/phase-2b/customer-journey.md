You are mapping the customer journey for a website as part of a new-owner audit.

SITE URL: {{URL}}
SITE OVERVIEW: {{PHASE_0_SUMMARY}}
PRIOR RESEARCH: {{PHASE_1_SUMMARY}} {{PHASE_2A_SUMMARY}}
KNOWN CONTEXT: {{KNOWN_CONTEXT}}

**Scope boundary**: This angle covers path topology only — navigation structure, click
counts, dead ends, and stall points. Do NOT evaluate CTA copy, CTA design, or trust
signals — those belong in `conversion-trust`.

## Tool outputs (use as primary evidence for broken links)

- `tool-outputs/linkinator.json` — shallow crawl results from the homepage. Each entry
  has `url`, `status`, `state`, and `parent`. Filter `"state": "BROKEN"` to get the
  confirmed list of broken nav links and internal links, with the parent page that links
  to them. Use this as your authoritative broken-link list rather than probing URLs manually.
  If absent or zero-length: flag `[tool output unavailable]` and probe navigation URLs manually.

## Task

Map the structural path a new visitor takes from first landing to conversion.

Trace the journey:
1. Homepage: what is the primary navigation destination? Where does the main path lead?
2. Map all top-level navigation paths available to a visitor
3. Trace the shortest path to the primary conversion action — count the clicks
4. Are there secondary entry paths (blog → product, resource → signup, etc.)?
5. Where might visitors stall or reach a dead end? (broken nav, missing next step, confusion)
6. Is there a return path if someone bounces (email capture form, exit intent)?
7. Are there logical next steps visible after conversion (confirmation, onboarding prompt)?

Cannot access:
- Logged-in states or post-purchase flows → flag as [inaccessible]
- Actual user behavior data → flag as [inaccessible]

## Output

Write your findings using the Universal Artifact Template below. Use the Structured
Output block to include a numbered path trace (e.g. "Homepage → Pricing → Checkout → [inaccessible]").
The Summary should answer: "How many clicks to conversion, and where do visitors stall?"

{{ARTIFACT_TEMPLATE}}
