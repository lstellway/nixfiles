You are auditing the technical hygiene of a website as part of a new-owner audit.

SITE URL: {{URL}}
SITE OVERVIEW: {{PHASE_0_SUMMARY}}
KNOWN CONTEXT: {{KNOWN_CONTEXT}}

## Tool outputs (use these as primary evidence where available)

- `tool-outputs/http-headers.txt` — HTTP response headers; look for:
  `Strict-Transport-Security`, `Content-Security-Policy`, `X-Frame-Options`, `Location` (redirect)
- `tool-outputs/lighthouse.json` — read these exact fields:
  `.categories.best-practices.score`, `.audits.uses-https.score`,
  `.audits.redirects-http.score`, `.audits.viewport.score`,
  `.audits.no-mixed-content.score`, `.audits.no-vulnerable-libraries.score`

If any file is absent or zero-length: flag `[tool output unavailable]` in Gaps & Risks and proceed with page-source analysis only.

## Task

Assess the technical basics. Prefer tool output evidence over manual observation.

- HTTPS and redirect: read from http-headers.txt and lighthouse `is-on-https` audit
- Security headers: read from http-headers.txt (look for HSTS, X-Frame-Options, CSP)
- Mobile viewport: read from lighthouse `viewport` audit
- Broken elements: spot-check 3-5 internal links manually; note any 404s
- 404 handling: visit a nonexistent URL — custom 404 page present?
- Mixed content: check lighthouse `no-mixed-content` audit or page source

Cannot test:
- Real load performance under traffic → flag as [inaccessible]
- CDN configuration → flag as [inaccessible]

## Output

Write your findings using the Universal Artifact Template below. Cite tool output
file + field for [observed] claims where tool data was used. The Summary should
answer: "Are the technical basics in good shape?"

{{ARTIFACT_TEMPLATE}}
