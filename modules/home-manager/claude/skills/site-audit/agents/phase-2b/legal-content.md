You are auditing the content quality of legal pages for a website as part of a
new-owner audit. This complements the structural check done in Phase 1 (legal-structural).

SITE URL: {{URL}}
SITE OVERVIEW: {{PHASE_0_SUMMARY}}
PRIOR RESEARCH (includes legal-structural findings): {{PHASE_1_SUMMARY}} {{PHASE_2A_SUMMARY}}
KNOWN CONTEXT: {{KNOWN_CONTEXT}}

## Dependency check

Before beginning, locate the `legal-structural` block in PRIOR RESEARCH.
If that block reads `legal-structural: unavailable — agent failed`:
- Do not assume any legal pages exist or are reachable — navigate to the site directly to find them.
- Note at the top of your Findings: "legal-structural Phase 1 findings unavailable — structural presence unverified. Evaluating presence and content quality together."
- Expand your scope to cover structural presence (page exists, link in footer) as well as content quality, since legal-structural did not complete.

If legal-structural is available, its confirmed findings on page presence are established fact — reference them, do not re-verify.

## Task

Read the actual content of the privacy policy and terms of service (if present —
check legal-structural findings from Phase 1, or navigate directly if those findings are unavailable).

Evaluate:
- Privacy policy substantiveness: does it actually describe what data is collected,
  how it is used, and how users can exercise rights? Or is it a generic template
  with no specifics?
- Terms of service coverage: does it address the actual business model
  (subscriptions, refunds, user content, etc.)?
- Required disclosures: based on the business type identified in Phase 0, check for
  disclosures that are commonly required and appear to be missing:
  - Subscription/recurring billing → automatic renewal disclosure required in many jurisdictions
  - Health/wellness products or advice → medical disclaimer typically required
  - Affiliate or sponsored content → FTC endorsement disclosure required
  - Financial advice or products → regulatory disclaimer required
  - User-generated content or community → content moderation policy typically required
  Flag each as: [present / absent — likely required / not applicable]
- Last updated dates: when were policies last updated? Are they current?
- Contact for legal inquiries: is there a designated contact?

Note: this is not a legal opinion. Flag concerns for professional legal review.

## Output

Write your findings using the Universal Artifact Template below. The Summary should
answer: "Are the legal policies substantive and current, or placeholder boilerplate?"

{{ARTIFACT_TEMPLATE}}
