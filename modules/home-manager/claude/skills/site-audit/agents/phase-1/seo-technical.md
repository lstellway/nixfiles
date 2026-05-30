You are auditing the technical SEO of a website as part of a new-owner audit.

SITE URL: {{URL}}
SITE OVERVIEW: {{PHASE_0_SUMMARY}}
KNOWN CONTEXT: {{KNOWN_CONTEXT}}

## Tool outputs (use these as primary evidence where available)

- `tool-outputs/robots.txt` — raw robots.txt content
- `tool-outputs/sitemap.xml` — raw sitemap content (index; child sitemaps may need fetching)
- `tool-outputs/lighthouse.json` — read these exact fields:
  `.categories.seo.score`, `.audits.document-title.score`,
  `.audits.meta-description.score`, `.audits.robots-txt.score`,
  `.audits.canonical.score`, `.audits.structured-data.score`,
  `.audits.is-crawlable.score`, `.audits.link-text.score`
- `tool-outputs/lychee.json` — sitemap integrity results. Each entry has `url` and `status`.
  Filter for non-200 entries: `"status": 404` = declared-but-missing page;
  `"status": 301` = redirect (may indicate stale sitemap entries).
  If file is absent or zero-length, flag `[tool output unavailable]` and note lychee may not be installed.

Read these files before visiting the site. If any file is absent or zero-length:
flag `[tool output unavailable]` in Gaps & Risks and proceed with manual inspection.

**Scope boundary**: Report presence/absence and pass/fail only — do NOT evaluate quality,
keyword alignment, or content depth. Those belong in `seo-content` (Phase 2b).

## Task

Assess the technical SEO foundation using tool data as primary evidence.

- robots.txt: read from tool output — what does it allow/disallow? Any accidental blocks?
- sitemap.xml: read from tool output — does it exist and appear well-formed?
- Lighthouse SEO score: report the numeric score (0–1)
- Canonical tags: check lighthouse `.audits.canonical.score` — pass/fail only
- Title/meta **presence**: check `.audits.document-title.score` and `.audits.meta-description.score` — presence only, not quality
- Schema markup: check `.audits.structured-data.score`
- Indexability: check `.audits.is-crawlable.score`

## Output

Write your findings using the Universal Artifact Template below. Cite tool output
file + field for [observed] claims. The Summary should answer:
"Is the technical SEO foundation solid?"

{{ARTIFACT_TEMPLATE}}
