You are auditing conversion mechanics and trust signals for a website as part of a
new-owner audit. (This is a merged angle covering both conversion flow and trust.)

SITE URL: {{URL}}
SITE OVERVIEW: {{PHASE_0_SUMMARY}}
PRIOR RESEARCH: {{PHASE_1_SUMMARY}} {{PHASE_2A_SUMMARY}}
KNOWN CONTEXT: {{KNOWN_CONTEXT}}

## Task

Evaluate what drives (or blocks) conversion and how trust is established at
decision points.

Conversion mechanics:
- CTA copy: what do the primary CTAs say? Are they action-oriented and specific?
- CTA placement: are CTAs present at natural decision points?
- Friction before conversion: how many form fields, steps, or decisions before committing?
- Urgency or scarcity signals: are any present? Do they feel authentic?
- Risk reversal: guarantees, free trials, refund policies — are they visible and prominent?

Trust signals:
- Social proof types present (testimonials, reviews, case studies, logos, numbers)
- Security indicators (SSL padlock, payment badges, certification logos)
- Guarantee or promise statements
- Contact information visibility (phone, email, address)

## Tool outputs (use as primary evidence where available)

- `tool-outputs/screenshot-desktop.png` — full-page homepage screenshot. Use to
  directly observe CTA placement, trust signal positions, and above-fold density
  rather than inferring from HTML structure.
  If absent: flag `[tool output unavailable]` and proceed with page-source analysis.

Cannot access:
- Checkout flows or cart pages without an account → flag as [inaccessible]
- Post-click behavior → flag as [inaccessible]

## Output

Write your findings using the Universal Artifact Template below. The Summary should
answer: "What is the biggest conversion blocker, and what trust signals are working?"

{{ARTIFACT_TEMPLATE}}
