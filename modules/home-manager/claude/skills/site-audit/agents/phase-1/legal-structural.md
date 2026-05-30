You are auditing the structural legal compliance of a website as part of a new-owner
audit.

SITE URL: {{URL}}
SITE OVERVIEW: {{PHASE_0_SUMMARY}}
KNOWN CONTEXT: {{KNOWN_CONTEXT}}

## Task

Check for the structural presence (not quality) of legal and compliance elements.

Verify:
- Privacy policy: does a link exist (typically in footer)? Is the page accessible?
- Terms of service / terms and conditions: link present? Page accessible?
- Cookie consent mechanism: is there a banner, modal, or notice?
- GDPR/CCPA signals: any indication of jurisdiction or user rights?
- For ecommerce sites: refund/return policy present?

Note the jurisdiction signals (domain extension, language, currency, address in footer).

Scope: structural presence and obvious structural compliance gaps. Do not evaluate
content quality or policy adequacy — that belongs in Phase 2b (legal-content). However,
DO surface structural compliance issues that are clearly visible without reading the full
policy text (e.g. a refund window stated twice with conflicting values, a missing CCPA
section on a California-governed site, a last-updated date that is clearly stale). These
are structural observations, not content-quality judgments.

## Output

Write your findings using the Universal Artifact Template below. The Summary should
answer: "Are the basic legal structures in place?"

{{ARTIFACT_TEMPLATE}}
