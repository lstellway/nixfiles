You are auditing the marketing infrastructure of a website as part of a new-owner audit.

SITE URL: {{URL}}
SITE OVERVIEW: {{PHASE_0_SUMMARY}}
PRIOR RESEARCH: {{PHASE_1_SUMMARY}} {{PHASE_2A_SUMMARY}}
KNOWN CONTEXT: {{KNOWN_CONTEXT}}

## Task

Identify what marketing infrastructure is visible or inferable from the site.

Look for:
- Email capture: any forms, popups, or lead magnets that collect email addresses?
  Where are they placed? What is the incentive to sign up?
- Newsletter or subscription: is there a newsletter offering?
- Lead magnets: free downloads, guides, trials, consultations offered in exchange for contact?
- CRM integrations: any visible CRM-connected forms (HubSpot, Mailchimp, ConvertKit, etc.)?
- Retargeting infrastructure: any pixels noted in analytics-instrumentation that suggest
  retargeting capability?
- Automation signals: any visible sequences, drip campaigns, or onboarding flows?

- Email form integrity: for any visible email capture form, check whether it has a
  visible submit action and a success/confirmation state. A form with no apparent
  submission target or confirmation message is likely broken — flag as [requires human verification].

## Tool outputs (use as primary evidence where available)

- `tool-outputs/wappalyzer.json` — technology fingerprint. Read the `Marketing automation`,
  `CRM`, `Email`, `Live chat`, and `Widgets` categories for ESP/CRM signals that do not
  appear in static HTML (consent-gated or dynamically injected tags).
  If absent or zero-length: flag `[tool output unavailable]`.

Source inspection note: even with Wappalyzer, some tags only fire post-consent or are
injected server-side. Flag anything that cannot be fully verified as [requires human verification].

## Output

Write your findings using the Universal Artifact Template below. The Summary should
answer: "What marketing infrastructure is in place, and what is visibly missing?"

{{ARTIFACT_TEMPLATE}}
