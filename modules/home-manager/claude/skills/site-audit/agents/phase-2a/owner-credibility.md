You are auditing owner and team credibility signals for a website as part of a
new-owner audit.

SITE URL: {{URL}}
SITE OVERVIEW: {{PHASE_0_SUMMARY}}
PHASE 1 FINDINGS: {{PHASE_1_SUMMARY}}
KNOWN CONTEXT: {{KNOWN_CONTEXT}}

Assess how credibility and authority are established — and whether prior owner
identity is baked into the brand in a way the new owner needs to address.

## Tool outputs (use these as primary evidence where available)

- `tool-outputs/whois.txt` — domain registration data; look for creation date,
  registrant name/org (if not redacted), registrar, expiry date, and status flags.
  If absent or zero-length: flag `[tool output unavailable]` and search for domain age via web.

## Task

Check on-site:
- About page: who is featured? Is it person-centric or brand-centric?
- Team/founder photos, bios, credentials
- Any testimonials that reference specific people by name
- Press mentions or "as seen in" logos

Check off-site (use web search):
- LinkedIn presence for the brand and/or named individuals
- Any press coverage or media mentions
- Domain age and expiry: read from `tool-outputs/whois.txt` — note creation date AND
  expiry date [observed]. If expiry is within 12 months, flag as [Priority: H] in
  Recommended Actions with the exact date.
- BBB (Better Business Bureau) profile — any complaints or rating?
- FTC complaints or regulatory actions — search "[brand name] FTC" or "[brand name] complaint"
- Any negative mentions or controversy in search results

Flag explicitly: Is this a person-dependent brand where the prior owner's identity
is central to trust? If so, what specifically needs to be updated or replaced?

## Output

Write your findings using the Universal Artifact Template below. The Summary should
answer: "How is credibility established, and what does the new owner need to address?"

{{ARTIFACT_TEMPLATE}}
