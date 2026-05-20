# Software SEO Agent — Sources

## Version / Date Pinning Table

| Framework / Standard | Version / Edition | Status | Date confirmed | Notes |
|---|---|---|---|---|
| Sitemaps XML protocol | 0.9 | Current and only published version | sitemaps.org, verified May 2026 | Namespace `http://www.sitemaps.org/schemas/sitemap/0.9`. 50,000 URLs / 50 MB uncompressed per file. `<changefreq>` and `<priority>` documented as hints; Google ignores both in practice. |
| Schema.org vocabulary | V30.0 | Current release (semver-style versioning) | 2026-03-19 release verified May 2026 | `Vehicle` type inherits from `Product` → `Thing`. Vehicle-specific properties: `vehicleIdentificationNumber`, `vehicleModelDate`, `mileageFromOdometer`, `fuelType`, `vehicleEngine`, `vehicleTransmission`, `seatingCapacity`, `cargoVolume`. |
| Google Search Central — Structured Data Intro | n/a (living docs) | Current normative guidance for Google Rich Results | Last updated 2025-12-10 | JSON-LD recommended; microdata and RDFa equally parsed. Google's per-type required-property lists supersede schema.org's. |
| Google Search Central — Vehicle listing structured data | Deprecated | Removed 2025-09-09 | Confirmed via Google Search Central changelog | The dedicated Vehicle listing rich result was removed September 2025. `Vehicle`/`Car` schema.org markup remains semantically valid; the Google rich result no longer surfaces. |
| Google Search Central — Sitemaps | n/a (living docs) | Current | Verified May 2026 | Explicitly states Google ignores `<priority>` and `<changefreq>`; uses `<lastmod>` only when consistently accurate. Sitemap `ping` endpoint deprecated June 2023. |
| Google Search Central — Canonicalization | n/a (living docs) | Current | Verified May 2026 | `rel="canonical"` is a hint, not directive. Use absolute URLs. Self-referential canonicals recommended. Cross-domain supported. |
| Google Search Central — rel=prev/next | Deprecated for Google indexing | Deprecated 2019 | Confirmed long-standing Google guidance | Google no longer uses `rel="prev"`/`rel="next"` as indexing signals. Bing still uses them. |
| Google Search Central — Robots meta tag and X-Robots-Tag | n/a (living docs) | Current | Verified May 2026 | `noarchive` directive obsolete (cached pages removed as a Google feature). All other directives current: `noindex`, `nofollow`, `none`, `nosnippet`, `max-snippet`, `max-image-preview`, `max-video-preview`, `indexifembedded`, `notranslate`, `noimageindex`, `unavailable_after`. |
| Google Search Central — Hreflang | n/a (living docs) | Current | Verified May 2026 | ISO 639-1 language + ISO 3166-1 Alpha-2 region. Bidirectional reciprocity required. `UK` invalid (use `GB`). |
| Core Web Vitals (web.dev) | LCP / INP / CLS as stable CWV | Stable since March 2024 (INP) | web.dev/articles/vitals, last updated 2024-10-31 | INP replaced FID as a stable CWV in **March 2024**. Thresholds (p75): LCP ≤ 2.5s, INP ≤ 200ms, CLS ≤ 0.1. |
| Open Graph protocol | n/a (community spec, stable) | Current de facto standard | ogp.me, verified May 2026 | Required: `og:title`, `og:type`, `og:image`, `og:url`. Image best practice: 1200×630, min 600×315. |
| Twitter Card markup | n/a (X documentation behind paywall) | Current | Inferred from widely-documented behavior | Card types: `summary`, `summary_large_image`, `app`, `player`. Falls back to `og:*` when `twitter:*` is missing. |
| IndexNow protocol | n/a (community spec) | Active for Bing/Yandex | indexnow.org, verified May 2026 | **Google does not support IndexNow.** Bing and Yandex do. Key-file ownership proof. Up to 10,000 URLs per POST batch. |
| Google Search Central — JavaScript SEO basics | n/a (living docs) | Current | Verified May 2026 | Two-wave indexing (HTML crawl → render queue). Evergreen Chromium for rendering. Dynamic rendering described as a "workaround," not deprecated outright but no longer recommended as long-term. |

---

## Sources Used

### Authoritative Documentation

- **Sitemaps XML Protocol** — https://www.sitemaps.org/protocol.html — Primary normative source for sitemap format, limits, and field semantics.
- **Google Search Central — Introduction to structured data** — https://developers.google.com/search/docs/appearance/structured-data/intro-structured-data — Format recommendation (JSON-LD), required-vs-recommended property guidance, validation tooling references.
- **Google Search Central — Rich Results gallery** — https://developers.google.com/search/docs/appearance/structured-data/search-gallery — List of currently active rich result types as of May 2026.
- **Google Search Central — Vehicle listing structured data (deprecated)** — https://developers.google.com/search/docs/appearance/structured-data/vehicle-listing — Confirms the September 2025 removal of the dedicated Vehicle listing rich result.
- **Google Search Central — Product structured data** — https://developers.google.com/search/docs/appearance/structured-data/product — Product snippet vs. merchant listing distinction; current active rich result for commerce contexts.
- **Google Search Central — Build a sitemap** — https://developers.google.com/search/docs/crawling-indexing/sitemaps/build-sitemap — Confirms Google ignores `<priority>` and `<changefreq>`; describes `<lastmod>` honesty requirement.
- **Google Search Central — Canonicalization** — https://developers.google.com/search/docs/crawling-indexing/canonicalization — High-level canonicalization model; canonical as hint not directive.
- **Google Search Central — Consolidate duplicate URLs** — https://developers.google.com/search/docs/crawling-indexing/consolidate-duplicate-urls — Specific `rel="canonical"` declaration methods (link element, HTTP header, sitemap); cross-domain support; what NOT to do.
- **Google Search Central — Localized versions / hreflang** — https://developers.google.com/search/docs/specialty/international/localized-versions — Language-region code format, `x-default`, bidirectional linking requirement, declaration methods.
- **Google Search Central — Robots.txt intro** — https://developers.google.com/search/docs/crawling-indexing/robots/intro — robots.txt purpose, limitations (cannot enforce, disallowed URLs may still rank).
- **Google Search Central — Robots meta tag, data-nosnippet, X-Robots-Tag** — https://developers.google.com/search/docs/crawling-indexing/robots-meta-tag — Full directive catalog, including deprecated `noarchive`.
- **Google Search Central — JavaScript SEO basics** — https://developers.google.com/search/docs/crawling-indexing/javascript/javascript-seo-basics — Two-wave indexing model, Chromium renderer, dynamic rendering status, soft 404s from CSR.
- **Schema.org Vehicle type** — https://schema.org/Vehicle — Property inventory, type hierarchy, relationship to Product.
- **web.dev — Core Web Vitals** — https://web.dev/articles/vitals — Current Core Web Vitals (LCP / INP / CLS), thresholds, p75 measurement, INP-replaced-FID timeline (March 2024 stable).
- **Open Graph Protocol** — https://ogp.me/ — Required/optional properties, image metadata structure.
- **IndexNow Documentation** — https://www.indexnow.org/documentation — Protocol details, supported engines (Bing, Yandex — not Google), key-file ownership, batch submission, rate limits.

### Existing Agents and Skills Consulted

- **`agent-discipline` skill** — https://file: ~/.claude/skills/agent-discipline/SKILL.md — Followed all 9 steps. Used capability-based cross-reference rule baked in at Step 4.
- **`software-accessibility.md`** — Reference for: Step-1 detection section structure (regulatory regime → analogous SEO surface detection), per-section heuristic format (criterion-anchored checks), bidirectional scope boundary phrasing, surface-then-defer pattern for cross-cutting concerns (here: accessibility ↔ SEO on semantic HTML, alt text, headings).
- **`software-performance.md`** — Reference for: decision hierarchy framing in persona ("measure → identify hotspot → optimize" → analogously, "crawl → index → rank"), Core Web Vitals threshold reuse, bidirectional boundary phrasing template ("Stay here for X; defer Y to a [capability] specialist"), evidence-gating pattern (memory findings without profiling are `[Info]`).
- **`software-observability.md`** — Reference for: scope clause phrasing ("You cover: ...; defer ... to ..."), output format calibration to mode.
- **`software-architecture.md`** — Reference for: lightweight persona that encodes a decision frame ("reason about tradeoffs explicitly").
- **`feedback_agent_cross_references.md`** (user memory) — Applied strictly: all peer-agent references in scope/boundary sections are capability-based ("an accessibility specialist", "a performance specialist", "an observability specialist", "an architecture specialist") rather than agent names.

### VoltAgent Awesome Subagents

- **Repository URL:** https://github.com/VoltAgent/awesome-claude-code-subagents
- **No SEO-specific agent was located in the directory.** The repository's `04-quality-security/` category contains accessibility, security, performance, and code-quality agents but no SEO/structured-data/sitemap agent at the time of this authoring. (The closest adjacent agents are `accessibility-tester` and the performance agents.) Because there was no reference implementation to adopt or reject element-by-element, the agent was authored from authoritative engine documentation and schema.org directly.

---

## What Was Reviewed and Not Adopted

| Element | Decision | Rationale |
|---|---|---|
| `<changefreq>` and `<priority>` as actionable signals | Not adopted as Google checks | Google ignores both. Including them as Google-relevant findings would create noise. Agent notes them for Bing context but does not flag their absence/presence on Google-targeted sites. |
| `noarchive` directive guidance | Mentioned only as obsolete | The directive is harmless but Google's cached-pages feature was removed. Surface as informational, not a finding. |
| `rel="prev"` / `rel="next"` for pagination | Mentioned as deprecated for Google | Google announced in 2019 it no longer uses these. Bing still does. Agent notes both. Does not require their presence; does not flag their use as a regression. |
| Dynamic rendering as recommended | Not adopted | Google's current guidance describes it as a workaround. Agent surfaces existing dynamic rendering as technical debt; flags new dynamic-rendering implementations rather than recommending the pattern. |
| Google Sitemap `ping` endpoint | Not adopted | Deprecated June 2023. Agent explicitly advises against implementing ping workflows. |
| Detailed per-rich-result type required-property lists (Article, FAQ, Job, Event, Recipe, etc.) | Not embedded in agent | These shift over time and are best read from Google's per-type docs at review time. Agent cites the Rich Results Test as the validation gate and Google's per-type docs as the source of truth. Embedding the lists would create staleness. |
| WCAG success criterion numbers | Not embedded | The agent defers WCAG specifics to an accessibility specialist by capability. Surface-then-defer pattern keeps SEO findings actionable without absorbing accessibility scope. |
| Specific RUM provider syntax (PostHog Web Vitals, Datadog RUM, etc.) | Not embedded | Belongs to an observability specialist. Agent describes what to monitor, not how to wire the pipeline. |
| Bing Webmaster Tools per-feature deep dive | Not deeply embedded | Mentioned in Step-1 surface detection; rules largely parallel Google. Deep Bing-specific behavior is out of scope for a default-Google agent unless the user signals multi-engine concerns. |
| Specific page-builder / CMS plugin recommendations (Yoast, Rank Math, etc.) | Not adopted | The agent reasons from emitted HTML, headers, and structured data — not from tooling. Tool selection is implementation, not assessment. |
| Mobile-Friendly Test specifics (now-deprecated as a separate tool) | Mentioned in mobile-first section but not deeply | Google retired the dedicated Mobile-Friendly Test page in December 2023; PageSpeed Insights and URL Inspection now surface mobile usability signals. Agent references the concept, not the deprecated tool. |
| AMP guidance | Not included | AMP is essentially obsolete for SEO purposes since the Page Experience update removed AMP as a Top Stories prerequisite (2021). No active reason to include unless explicitly invoked. |

---

## Articles and Checklists That Informed Specific Heuristics

- **Google Search Central Changelog** — https://developers.google.com/search/updates — Used to verify deprecations (Vehicle listing rich result removal September 2025, ping endpoint deprecation June 2023, INP becoming stable CWV March 2024).
- **Schema.org release notes (V30.0)** — https://schema.org/docs/releases.html — Verified current vocabulary version and Vehicle/Product hierarchy.
- **web.dev Core Web Vitals changelog** — Linked from the main vitals article — Used to verify INP timeline and current thresholds.

---

## Project-Specific Context Considered

The agent was authored with awareness of one user-described project (BFB / Built for Backroads) that has the following SEO-sensitive surfaces:

- A Next.js frontend at `apps/frontend` with `/sitemap.xml` (sitemap index), `/sitemap/products.xml` and `/sitemap/pages.xml` (sitemap segments), and `/robots.ts`.
- A `SeoSchema` component at `apps/frontend/src/lib/components/seo/SeoSchema.tsx` that renders `<script type="application/ld+json">` blocks; this is how Vehicle/Product JSON-LD is emitted on listing pages.
- A planned migration from one data source (WordPress) to another (PayloadCMS) for vehicle data, which carries silent SEO drift risk — JSON-LD values, sitemap byte output, canonical URLs, hreflang declarations, and meta tags can all shift even when shape appears unchanged.

The agent's PR-review mode includes an explicit `[Drift]` tag classification specifically to support detecting this class of migration regression. The structured-data audit mode includes a "migration risk" sub-step listing every property whose value source has changed. The sitemap audit mode includes a "determinism" check for byte-level output stability.

This project context did not narrow the agent's scope (it remains general-purpose) but did inform the emphasis on:

1. JSON-LD content-data parity (Google manual-action vector).
2. Sitemap `lastmod` honesty (Google ignores sitemap-wide when `lastmod` is unreliable).
3. Canonical-hreflang interaction (most common multi-locale failure).
4. SSR vs. CSR for content-critical pages (`<head>` injection by JS is unreliable).
5. The Vehicle listing rich-result deprecation (a vehicle marketplace's structured-data strategy must not assume the dedicated rich result exists).

---

## Design Notes

### Agent-specific design decisions

**Persona as a decision frame, not an expertise claim.** The opening — "You treat every page change as a crawl-and-index event" — encodes the agent's evaluation stance. This produces more targeted findings than "you are an SEO expert" framing, which tends toward broad checklist sweeps rather than judgment about what actually changes in the index when a PR ships.

**Three-step decision hierarchy as the spine.** *Crawl → Index → Rank* is stated explicitly in the second persona paragraph and structures the assessment sections. A change that breaks the crawl step is critical regardless of how good its ranking signals look. This prevents the agent from grading meta-description copy on a page that ships with `noindex` set.

**Step-1 surface detection.** SEO rules vary by engine (Google vs. Bing vs. Yandex) and by surface within Google (web, news, video, Shopping, AI Overviews). Step-1 detection mirrors the regulatory-regime detection pattern in the accessibility agent, applied to engine surfaces instead. Default to Google when not specified; note when a finding is engine-specific.

**`[Drift]` finding tag.** Standard severity tags (`Critical / High / Medium / Info`) plus an orthogonal `[Drift]` tag for migration-induced silent regressions (sitemap byte/content drift, JSON-LD shape drift, canonical change, hreflang regression, robots directive change, meta-tag drift). Severity describes user-impact urgency; `[Drift]` describes detection mode — these are independent dimensions. A `[Drift]` finding can be `[Info]` (a benign timestamp formatting change) or `[Critical]` (a canonical now points to a 404). Calling out drift as a tag rather than a severity prevents the migration-detection use case from inflating severity counts.

**Migration-risk sub-step in structured-data audit.** "List every property whose value source has changed, even if shape is unchanged" is a directly load-bearing instruction. The most insidious migration regressions are not shape changes (which break tests and validators) but value drift — `mileageFromOdometer` going from one data source's units to another's, or `price` shifting cents/dollars representation. Catching this requires explicit attention.

**Determinism check in sitemap audit.** "Is the byte output deterministic for the same input?" — nondeterminism in sitemap generation (unsorted iteration, ISO timestamps for build time, locale-dependent formatting) masks real content drift in CI diffs. This is a CI-pipeline-aware check that any sitemap-generating route should pass.

**Capability-based cross-references throughout.** No peer agent is referenced by name (no `software-accessibility`, no `software-performance`, etc.). Every defer-to clause uses a capability description ("an accessibility specialist", "a performance specialist", "an observability specialist", "an architecture specialist"). This complies with the user's strict cross-reference rule and survives roster reorganizations.

**Vehicle listing rich-result deprecation called out.** This is a load-bearing fact for a vehicle marketplace. The dedicated rich result was removed September 2025; `Vehicle`/`Car` schema.org markup remains valid but no longer surfaces a Google-specific rich result. Without this note, an SEO review might recommend doubling down on Vehicle JSON-LD as a rich-result strategy that no longer exists.

**INP, not FID.** INP replaced FID as a stable CWV in March 2024. This is recent enough that training-data references frequently still cite FID. The agent embeds INP and notes the replacement timeline.

**No automated-tool recommendations as primary outputs.** The agent reasons from code, headers, JSON-LD, and structured data — not from tool dashboards. Rich Results Test and Search Console are mentioned as validation gates and monitoring surfaces, but tool runs are not the agent's primary output. This keeps findings traceable to source code and templates, where the change is actually made.

### Patterns worth surfacing to the authoring process

**Detection-step generalization.** The Step-1 detection pattern (regulatory regime in accessibility; protocol in API design; engine surface in SEO) is a recurring discipline-agent pattern. Disciplines where rules vary by *input type* benefit from making this an explicit first step. The skill already calls this out at Step 6; this agent reinforces the value.

**Orthogonal tagging dimensions.** Severity (`Critical / High / Medium / Info`) and detection mode (`[Drift]`) are independent dimensions. Other disciplines may benefit from similar orthogonal tags — for example, a privacy agent could tag `[PII-Exposure]` orthogonally to severity, where the tag describes the failure mode and severity describes urgency. Worth considering as a generalizable pattern when a discipline has a recurring failure class that crosses severities.

**Capability-only cross-references confirmed across-the-board workable.** Authoring this agent with strict capability-only references (no peer agent named anywhere) produced clear, durable scope boundaries. No clauses felt awkward; the boundary descriptions read naturally. This validates the rule at scale — the constraint produced better writing, not worse.

**Per-discipline "drift detection" framing.** Migration-induced silent regressions are a class of finding that many cross-cutting disciplines share (SEO, observability, accessibility, security). The pattern — "list every property/value whose source has changed, even if shape is unchanged" — could be promoted to a general PR-review sub-step in any discipline where a migration is in flight. Worth considering as a skill-level pattern for cross-cutting disciplines.

**Deprecation surfacing within the agent.** The Vehicle listing rich-result deprecation, the `noarchive` obsolescence, the `rel="prev/next"` deprecation, and the dynamic-rendering posture are all called out within the agent (not just in sources.md) because they materially shape recommendations. Disciplines that move quickly (SEO, frontend platform, ML/AI tooling) benefit from explicit deprecation notes in the agent prose itself rather than only in version tables. Worth surfacing in the skill as a recommended practice for fast-moving disciplines.
