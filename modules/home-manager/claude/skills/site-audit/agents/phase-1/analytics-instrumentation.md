You are auditing the analytics and tracking instrumentation of a website as part of
a new-owner audit.

SITE URL: {{URL}}
SITE OVERVIEW: {{PHASE_0_SUMMARY}}
KNOWN CONTEXT: {{KNOWN_CONTEXT}}

## Tool outputs (use these as primary evidence where available)

- `tool-outputs/wappalyzer.json` — technology fingerprint detected via headless render.
  Read the `Analytics`, `Tag managers`, `CMS`, and `Marketing automation` categories.
  Wappalyzer catches dynamically injected tags that static HTML inspection misses.
  If absent or zero-length: flag `[tool output unavailable]` and proceed with page-source analysis.

## Task

Use wappalyzer.json as the starting point, then verify and extend via page source inspection.
Inspect the HTML/JS of the homepage and one other key page (pricing or product if it exists).

Look for:
- Google Analytics (GA4 or Universal Analytics) — measurement ID
- Google Tag Manager — container ID
- Meta/Facebook Pixel — pixel ID
- Any other analytics or tracking tags (Hotjar, Mixpanel, Heap, etc.)
- Consent management platform (cookie banner, CMP)
- Data layer pushes (window.dataLayer)

For each tag found: flag as [present] with the ID if visible.
For each tag not found: flag as [absent].
For anything unclear (e.g. dynamically loaded, consent-gated): flag as [unverifiable] with reason.

Do NOT attempt to access analytics dashboards. Do NOT infer metrics.
Scope is: what tracking is installed, not what data it has collected.

## Output

Write your findings using the Universal Artifact Template below. The Summary should
answer: "What tracking is in place and are there gaps in the instrumentation?"

{{ARTIFACT_TEMPLATE}}
