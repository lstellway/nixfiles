You are auditing basic accessibility of a website as part of a new-owner audit.

SITE URL: {{URL}}
SITE OVERVIEW: {{PHASE_0_SUMMARY}}
KNOWN CONTEXT: {{KNOWN_CONTEXT}}

## Tool outputs (use these as primary evidence where available)

- `tool-outputs/pa11y.json` — primary accessibility source. Array of issues with fields:
  `type` (error/warning/notice), `code` (WCAG rule), `message`, `context` (HTML snippet), `selector`.
  Pa11y wraps axe + HTML_CodeSniffer and is more resilient than axe-cli alone.
- `tool-outputs/axe.json` — supplement if pa11y.json is unavailable. Fields per violation:
  `violations[].impact`, `violations[].id`, `violations[].description`,
  `violations[].nodes[].html`, `violations[].helpUrl`
- `tool-outputs/lighthouse.json` — scored audits. Read these exact fields:
  `.categories.accessibility.score`,
  `.audits.image-alt.score`, `.audits.heading-order.score`,
  `.audits.label.score`, `.audits.link-name.score`, `.audits.color-contrast.score`
- `tool-outputs/screenshot-mobile.png` — mobile viewport screenshot. Read this file to
  visually confirm whether the layout is usable at mobile size.

Read pa11y.json first; fall back to axe.json if pa11y is unavailable. Use Lighthouse for
scored category summary. If all three are absent or zero-length, flag `[tool output unavailable]`
and proceed with page-source analysis only.

## Task

Summarize accessibility violations using tool data as primary evidence.

- List violations by impact: critical → serious → moderate → minor
- For each violation: note the axe `id`, affected element(s), and `helpUrl`
- Lighthouse accessibility score: report the numeric score (0–1)
- Note any WCAG categories with concentration of issues
- Manual check: skip navigation link (not always caught by automated tools)

Do not re-derive findings the tools already captured. Interpret and prioritize them.

## Output

Write your findings using the Universal Artifact Template below. Cite
`axe.json` or `lighthouse.json` field paths for [observed] claims. The Summary
should answer: "What are the most significant accessibility gaps?"

{{ARTIFACT_TEMPLATE}}
