You are auditing the visual design and layout of a website as part of a new-owner audit.

SITE URL: {{URL}}
SITE OVERVIEW: {{PHASE_0_SUMMARY}}
PRIOR RESEARCH: {{PHASE_1_SUMMARY}} {{PHASE_2A_SUMMARY}}
KNOWN CONTEXT: {{KNOWN_CONTEXT}}

## Tool outputs (use as primary evidence where available)

- `tool-outputs/screenshot-desktop.png` — full-page desktop screenshot. Read this file
  to directly observe above-the-fold layout, hero presence, CTA placement, and trust signal
  positions without relying on inference. Cite as [observed] (→ screenshot-desktop.png).
- `tool-outputs/screenshot-mobile.png` — full-page mobile screenshot. Use to assess
  mobile layout, navigation, and whether key elements collapse correctly.
  If either file is absent: flag `[tool output unavailable]` and proceed with page-source analysis.

## Task

Audit visual structure using the screenshots as primary evidence. Where screenshots are
available, claims about layout and presence should be [observed], not [inferred].
Do not evaluate CTA copy or messaging — those belong in `conversion-trust` and `content-messaging`.

For the homepage and one other key page, complete this checklist:

**Above-the-fold inventory** (what is visible without scrolling):
- Logo present? [yes/no]
- Headline present? [yes/no] — quote it verbatim
- Sub-headline or supporting copy present? [yes/no]
- Primary CTA button present? [yes/no] — note its position (top-left/center/right)
- Hero image or video present? [yes/no] — does it appear relevant to the offer?
- Navigation menu present? [yes/no]

**Page structure**:
- Estimated word count above the fold: [low <50 / medium 50-150 / high 150+]
- Number of distinct CTA buttons visible on full page scroll: [count]
- Trust signals present on page: [list types — testimonials, logos, numbers, guarantees, or none]
- Trust signal position: [above fold / mid-page / footer / absent]

**Cross-page consistency**:
- Do the homepage and one other page share the same header/navigation? [yes/no]
- Do color and typography appear consistent across pages? [yes/no/inferred]

Cannot reliably assess even with screenshots:
- Exact color contrast ratios (require computed CSS values) → flag as [inferred]
- Font family names and exact sizes → flag as [inferred]
- Precise spacing values → flag as [inferred]

## Output

Write your findings using the Universal Artifact Template below. The Summary should
answer: "Does the design build trust and guide visitors toward conversion?"

{{ARTIFACT_TEMPLATE}}
