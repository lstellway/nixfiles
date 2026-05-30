---
name: site-audit
description: Comprehensive website audit for new owners. Covers 20 research angles across experience, offer/market, business infrastructure, risk/compliance, content/brand, and technical dimensions. Parallel agents per phase produce individual markdown artifacts; a synthesis agent delivers a quick wins grid, top risks, and a 90-day roadmap. Use when assessing a newly acquired or inherited website.
tools: Agent, Read, Write, Bash, WebFetch, WebSearch
metadata:
  author: logan
  version: "1.0"
---

## Overview

This skill audits a website from the perspective of an owner who wants to understand current state and identify opportunities. It runs multiple research agents in parallel across four phases, producing one markdown artifact per angle and a synthesized deliverable.

**When to use**: When you want a structured current-state assessment of a website and a competitive analysis of the domain.

**What it produces**: 20 individual research artifacts + a `synthesis.md` with executive summary, quick wins grid, top risks, and 90-day roadmap.

---

## Inputs

**Required**:
- `URL` — the website to audit (e.g. `https://www.example.com`)

---

## Output Structure

All artifacts are written to `research/<site-slug>/` in the current working directory:

```
research/<site-slug>/
  phase-0-summary.md        ← prose overview + embedded JSON scope gate
  phase-1-summary.md        ← structured per-agent blocks
  phase-2a-summary.md       ← structured per-agent blocks
  artifacts/
    phase-1/
      persona-research.md
      competitive-landscape.md
      analytics-instrumentation.md
      legal-structural.md
      technical-hygiene.md
      accessibility.md
      seo-technical.md
    phase-2a/
      owner-credibility.md
      customer-reviews.md
    phase-2b/
      customer-journey.md
      content-messaging.md
      visual-design.md
      conversion-trust.md
      pricing-value.md
      revenue-model.md
      marketing-infrastructure.md
      content-inventory.md
      brand-audit.md
      legal-content.md
      seo-content.md
  synthesis.md
```

Derive `<site-slug>` from the domain (e.g. `howwelove` from `www.howwelove.com`).

Tool outputs (when available) are saved to `research/<site-slug>/tool-outputs/`:
- `lighthouse.json` — performance, accessibility, SEO, best-practices scores → technical-hygiene, accessibility, seo-technical
- `axe.json` — element-level accessibility violations (fallback if pa11y unavailable) → accessibility
- `pa11y.json` — primary accessibility source; wraps axe + HTML_CodeSniffer → accessibility
- `wappalyzer.json` — technology fingerprint (analytics tags, CMS, ESP, CRM, plugins) → analytics-instrumentation, marketing-infrastructure
- `screenshot-desktop.png` — full-page desktop render → visual-design, conversion-trust
- `screenshot-mobile.png` — full-page mobile render → visual-design, accessibility
- `http-headers.txt` — HTTP response headers → technical-hygiene
- `robots.txt` / `sitemap.xml` — crawl directives and declared URL set → seo-technical
- `whois.txt` — domain registration and expiry → owner-credibility
- `lychee.json` — sitemap URL integrity (declared URLs → HTTP status) → seo-technical
- `linkinator.json` — crawled link integrity (linked URLs from HTML → HTTP status) → customer-journey

---

## Pre-flight Tooling

Before Phase 0, run the following commands to collect objective data. Run all in
parallel where possible. Each command is optional — if it fails or the tool is
unavailable, note the failure and continue. Do not block on tool errors.

By this point `SITE_SLUG` has already been derived from the URL (step 2 of Execution Flow).
Derive `{{BASE_URL}}` as scheme + domain (e.g. `https://www.howwelove.com`).
Derive `{{DOMAIN}}` as the bare domain (e.g. `howwelove.com`).

```bash
# Lighthouse — performance, accessibility, SEO, best practices
npx --yes lighthouse {{BASE_URL}} \
  --output json \
  --output-path research/{{SITE_SLUG}}/tool-outputs/lighthouse.json \
  --chrome-flags="--headless --no-sandbox" \
  --quiet 2>/dev/null

# axe — accessibility violations with element-level specificity
npx --yes @axe-core/cli {{BASE_URL}} \
  --reporter json \
  > research/{{SITE_SLUG}}/tool-outputs/axe.json 2>/dev/null

# HTTP response headers — HTTPS, redirects, security headers
curl -sI --max-time 15 --location "{{BASE_URL}}" \
  > research/{{SITE_SLUG}}/tool-outputs/http-headers.txt 2>/dev/null

# robots.txt
curl -s --max-time 10 "{{BASE_URL}}/robots.txt" \
  > research/{{SITE_SLUG}}/tool-outputs/robots.txt 2>/dev/null

# sitemap
curl -s --max-time 10 "{{BASE_URL}}/sitemap.xml" \
  > research/{{SITE_SLUG}}/tool-outputs/sitemap.xml 2>/dev/null

# whois — domain age and registration info
whois "{{DOMAIN}}" \
  > research/{{SITE_SLUG}}/tool-outputs/whois.txt 2>/dev/null

# lychee — sitemap integrity: checks every URL declared in the sitemap and reports HTTP status.
# Catches URLs the site declares exist but actually 404. Requires lychee installed as a system
# binary (brew install lychee). Reads sitemap.xml recursively including child sitemaps.
lychee --format json \
  --output research/{{SITE_SLUG}}/tool-outputs/lychee.json \
  --timeout 10 \
  --max-concurrency 8 \
  --no-progress \
  "{{BASE_URL}}/sitemap.xml" 2>/dev/null

# linkinator — crawl integrity: shallow-crawls from the homepage and checks every linked URL.
# Catches broken nav links and internal links that are not declared in the sitemap.
# Complements lychee: lychee covers declared URLs, linkinator covers linked URLs.
npx --yes linkinator "{{BASE_URL}}" \
  --recurse \
  --format JSON \
  --concurrency 5 \
  --timeout 10000 \
  --skip "mailto:" \
  2>/dev/null > research/{{SITE_SLUG}}/tool-outputs/linkinator.json

# Wappalyzer — technology fingerprinting: detects CMS, analytics tags, pixels, ESPs, plugins.
# Catches dynamically injected tags that static HTML inspection misses (GTM-loaded pixels,
# consent-gated scripts). Outputs JSON with detected technologies and confidence scores.
npx --yes wappalyzer "{{BASE_URL}}" \
  > research/{{SITE_SLUG}}/tool-outputs/wappalyzer.json 2>/dev/null

# Pa11y — accessibility violations: wraps axe + HTML_CodeSniffer, runs against live rendered DOM.
# Complements Lighthouse; more resilient than axe-cli alone (which can return zero bytes on some sites).
npx --yes pa11y "{{BASE_URL}}" \
  --reporter json \
  > research/{{SITE_SLUG}}/tool-outputs/pa11y.json 2>/dev/null

# Playwright — full-page screenshots at desktop and mobile viewports.
# Converts [inferred] visual claims to [observed] evidence for visual-design and conversion-trust.
npx --yes playwright screenshot \
  --browser chromium \
  --full-page \
  "{{BASE_URL}}" \
  research/{{SITE_SLUG}}/tool-outputs/screenshot-desktop.png 2>/dev/null
npx --yes playwright screenshot \
  --browser chromium \
  --device "iPhone 13" \
  --full-page \
  "{{BASE_URL}}" \
  research/{{SITE_SLUG}}/tool-outputs/screenshot-mobile.png 2>/dev/null
```

After running, note which tools succeeded and which failed. Pass this status
to Phase 0 as part of the known context block.

**URL integrity outputs:**
- `tool-outputs/lychee.json` — one entry per sitemap URL with `status` and `url` fields. Filter `"status": 404` or `"status": 301` to find declared-but-broken URLs.
- `tool-outputs/linkinator.json` — array of `{url, status, state, parent}` objects. Filter `"state": "BROKEN"` to find broken nav links and internal links.

**Technology and accessibility outputs:**
- `tool-outputs/wappalyzer.json` — detected technologies keyed by category (analytics, CMS, widgets, email). Use for analytics-instrumentation and marketing-infrastructure angles.
- `tool-outputs/pa11y.json` ��� array of accessibility issues with `type`, `code`, `message`, `context`, `selector`. Use for accessibility angle.

**Visual outputs:**
- `tool-outputs/screenshot-desktop.png` — full-page desktop screenshot. Use for visual-design and conversion-trust angles.
- `tool-outputs/screenshot-mobile.png` — full-page mobile screenshot. Use for visual-design and accessibility angles.

---

## Execution Flow

Follow these steps in order. Do not skip or reorder phases.

1. Parse inputs. URL is required — if missing, ask the user before proceeding.
2. **Derive `SITE_SLUG` from the URL immediately** — do not wait for Phase 0. Take the hostname, lowercase it, strip `www.`, replace `.` with `-` (e.g. `www.howwelove.com` → `howwelove`). All output paths and agent prompts use this value.
3. Create the output directory: `research/<site-slug>/artifacts/phase-1/`, `phase-2a/`, `phase-2b/`, `tool-outputs/`.
4. Run pre-flight tooling (see Pre-flight Tooling above). Note successes and failures.
5. **Phase 0** — run single agent (foreground). Wait for completion.
6. Parse the JSON block from Phase 0 output. Validate that `angles_applicable` is present. If missing or malformed, re-prompt Phase 0 once. If still missing, stop and report to user.
7. Apply scope gate: remove pruned angles from the phase lists per the Scope Gate rules below.
8. **Phase 1** — **IN A SINGLE MESSAGE**, dispatch ALL applicable Phase 1 agents as simultaneous Agent tool calls. Do NOT send one agent call, wait for its response, then send the next. If you find yourself writing a second message to dispatch the next Phase 1 agent, stop — combine all remaining calls and send them together. Wait for all to complete.
9. **Write `phase-1-summary.md`** — the coordinator reads each Phase 1 artifact file itself and writes one summary block per angle using the Phase Summary Schema. Do not delegate this to a subagent.
10. **Phase 2a** — **IN A SINGLE MESSAGE**, dispatch both Phase 2a agents as simultaneous Agent tool calls. Each receives `phase-1-summary.md` content injected inline. Wait for all.
11. **Write `phase-2a-summary.md`** — the coordinator reads each Phase 2a artifact file and writes one summary block per angle.
12. **Phase 2b** — **IN A SINGLE MESSAGE**, dispatch ALL applicable Phase 2b agents as simultaneous Agent tool calls. Each receives both `phase-1-summary.md` and `phase-2a-summary.md` injected inline. Wait for all.
13. **Phase 3** — run single synthesis agent (foreground). Pass `SITE_SLUG` explicitly so it can resolve `research/<site-slug>/artifacts/`. Wait for completion.
14. Report to user: output directory path, artifact count, quick wins count, top 3 risks surfaced.

**Context injection rule**: Inject phase summary content as **inline text** in each agent prompt under a clearly labeled section header (e.g. `## Prior Research: Phase 1 Summary`). Pass the full text of the summary file — do not pass a file path and expect the agent to read it. Phase 3 is the only agent that reads artifact files directly.

**Failure handling**: If any Phase 1, 2a, or 2b agent fails or returns output that does not match the artifact template, skip that angle, write a one-line note in the phase summary (`<angle-name>: unavailable — agent failed`), and continue. Do not halt the workflow. Surface all skipped angles in the final report to the user.

---

## Phase 0 — Site Overview

Run a single general-purpose agent with this prompt (fill in `{{URL}}` and `{{KNOWN_CONTEXT}}`):

```
You are conducting a website overview for a new owner audit. Your job is to establish
baseline facts about this site so that downstream research agents can be properly
scoped and informed.

SITE URL: {{URL}}
KNOWN CONTEXT: {{KNOWN_CONTEXT}}

## What to capture

Visit the site. Explore the homepage, navigation, any pricing or product pages,
about page, and footer. If a prominent lead magnet, quiz, or free tool is visible,
note its entry point URL and whether it returns a result or an email capture.
Then answer:

1. What does this business do? (1-2 sentences)
2. What is the primary conversion action? (buy, signup, book, contact, subscribe, etc.)
3. What are the price points, if any? (list tiers/products and prices)
4. What is the apparent target audience?
5. What tech stack is visible? (CMS, ecommerce platform, page builder, chat widget, etc.)
6. Are there any customer reviews or social proof visible on the site?
7. Does the brand appear to be person-dependent (founder's name/face central to identity)?
8. Roughly how many pages does the site have? (small = <10, medium = 10-50, large = 50+)

## Prose summary

Write a prose paragraph (200 words max) followed by a key-facts bullet list (unlimited).
The 200-word limit applies to the prose paragraph only. Lead with what the business is.

## Scope gate JSON

Then output a JSON block (fenced with ```json) using EXACTLY this schema — no extra fields:

{
  "site_type": "<ecom|saas|content|service|marketplace|other>",
  "person_dependent_brand": <true|false>,
  "has_ecommerce": <true|false>,
  "has_reviews_present": <true|false>,
  "has_analytics_tag": <true|false|"unverifiable">,
  "primary_conversion_action": "<string>",
  "page_count_estimate": "<small|medium|large>",
  "angles_applicable": ["<angle-id>", ...],
  "angles_pruned": {"<angle-id>": "<reason>", ...}
}

Note: `site_slug` is derived by the coordinator before Phase 0 runs — do NOT include it.
For `has_analytics_tag`: use `true` if a tag is confirmed in page source, `false` if clearly absent,
  `"unverifiable"` if tags may be lazy-loaded via GTM or consent-gated (common on mature sites).
For `angles_pruned`: use `{}` if no angles are pruned (not null, not omitted — empty object).
For angles_applicable: start with the full list below, then remove any that are pruned.
For angles_pruned: apply the pruning rules below and record the reason.

Full angle list:
persona-research, competitive-landscape, analytics-instrumentation, legal-structural,
technical-hygiene, accessibility, seo-technical, owner-credibility, customer-reviews,
customer-journey, content-messaging, visual-design, conversion-trust, pricing-value,
revenue-model, marketing-infrastructure, content-inventory, brand-audit,
legal-content, seo-content

Pruning rules:
- No price points AND no ecommerce → prune: pricing-value, revenue-model
- Static brochure site (no conversion action) → prune: conversion-trust, marketing-infrastructure
- No reviews visible AND no review platform links → prune: customer-reviews (note in angles_pruned)
- page_count_estimate = small → prune: content-inventory (collapse to spot-check note in owner-credibility)

Write the JSON block after the prose summary. Nothing else after the JSON.
```

Write the agent output to `research/<site-slug>/phase-0-summary.md`.

---

## Phase 1 — Foundational Research

Fan out the following agents in parallel. Each agent writes its artifact to the path shown.

For each agent, inject:
- `{{URL}}` — the site URL
- `{{KNOWN_CONTEXT}}` — the user's known context block
- `{{PHASE_0_SUMMARY}}` — the prose section of `phase-0-summary.md` (not the JSON)
- The Universal Artifact Template (see below)

---

### persona-research → `artifacts/phase-1/persona-research.md`

**Agent type**: general-purpose with web search

**Prompt**:
```
You are researching the target audience for a website as part of a new-owner audit.

SITE URL: {{URL}}
SITE OVERVIEW: {{PHASE_0_SUMMARY}}
KNOWN CONTEXT: {{KNOWN_CONTEXT}}

## Task

Research who buys products or services in this category. Do NOT assume the site's
own claims about its audience are accurate — research externally.

Look for:
- Demographic and psychographic data (age, income, life stage, motivations)
- Forum discussions, Reddit threads, Facebook groups where this audience gathers
- Language patterns — how does this audience describe their problem?
- Purchase triggers — what prompts them to seek this product/service?
- Objections — what holds them back?
- Where they research before buying

Use web search. Cite every source with a URL. If search returns nothing useful,
say so explicitly — do not synthesize from assumptions.

## Output

Write your findings using the Universal Artifact Template below. The Summary should
answer: "Who is the target audience and what do they care most about?"

{{ARTIFACT_TEMPLATE}}
```

---

### competitive-landscape → `artifacts/phase-1/competitive-landscape.md`

**Agent type**: general-purpose with web search

**Prompt**:
```
You are mapping the competitive landscape for a website as part of a new-owner audit.

SITE URL: {{URL}}
SITE OVERVIEW: {{PHASE_0_SUMMARY}}
KNOWN CONTEXT: {{KNOWN_CONTEXT}}

## Task

Identify who else operates in this space. Use web search.

Find:
- 3-5 direct competitors (same product/service, same audience)
- 2-3 adjacent alternatives (different approach, same problem)

For each, capture:
- Name and URL
- Positioning (what they claim to be)
- Price points (if visible)
- Key differentiators vs the audited site
- Notable strengths or weaknesses

Then summarize: where does the audited site appear to sit in the landscape?
What is differentiated? What is undifferentiated?

Source count: list the number of sources consulted. If you cannot find competitors
via search, say so explicitly — do not fabricate.

## Output

Write your findings using the Universal Artifact Template below. The Summary should
answer: "Who are the main competitors and how does this site compare?"

{{ARTIFACT_TEMPLATE}}
```

---

### analytics-instrumentation → `artifacts/phase-1/analytics-instrumentation.md`

**Agent type**: general-purpose with page source access

**Prompt**:
```
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
```

---

### legal-structural → `artifacts/phase-1/legal-structural.md`

**Agent type**: general-purpose with page access

**Prompt**:
```
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
```

---

### technical-hygiene → `artifacts/phase-1/technical-hygiene.md`

**Agent type**: general-purpose with page access

**Prompt**:
```
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
```

---

### accessibility → `artifacts/phase-1/accessibility.md`

**Agent type**: general-purpose with page access

**Prompt**:
```
You are auditing basic accessibility of a website as part of a new-owner audit.

SITE URL: {{URL}}
SITE OVERVIEW: {{PHASE_0_SUMMARY}}
KNOWN CONTEXT: {{KNOWN_CONTEXT}}

## Tool outputs (use these as primary evidence where available)

- `tool-outputs/pa11y.json` — primary accessibility source. Array of issues with fields:
  `type` (error/warning/notice), `code` (WCAG rule), `message`, `context` (HTML snippet), `selector`.
  Pa11y wraps axe + HTML_CodeSniffer and is more resilient than axe-cli alone.
- `tool-outputs/axe.json` — supplement if pa11y.json is unavailable. Fields per violation:
  `violations[].impact`, `violations[].id`, `violations[].description`,
  `violations[].nodes[].html`, `violations[].helpUrl`
- `tool-outputs/lighthouse.json` — scored audits. Read these exact fields:
  `.categories.accessibility.score`,
  `.audits.image-alt.score`, `.audits.heading-order.score`,
  `.audits.label.score`, `.audits.link-name.score`, `.audits.color-contrast.score`
- `tool-outputs/screenshot-mobile.png` — mobile viewport screenshot. Read this file to
  visually confirm whether the layout is usable at mobile size.

Read pa11y.json first; fall back to axe.json if pa11y is unavailable. Use Lighthouse for
scored category summary. If all three are absent or zero-length, flag `[tool output unavailable]`
and proceed with page-source analysis only.

## Task

Summarize accessibility violations using tool data as primary evidence.

- List violations by impact: critical → serious → moderate → minor
- For each violation: note the axe `id`, affected element(s), and `helpUrl`
- Lighthouse accessibility score: report the numeric score (0–1)
- Note any WCAG categories with concentration of issues
- Manual check: skip navigation link (not always caught by automated tools)

Do not re-derive findings the tools already captured. Interpret and prioritize them.

## Output

Write your findings using the Universal Artifact Template below. Cite
`axe.json` or `lighthouse.json` field paths for [observed] claims. The Summary
should answer: "What are the most significant accessibility gaps?"

{{ARTIFACT_TEMPLATE}}
```

---

### seo-technical → `artifacts/phase-1/seo-technical.md`

**Agent type**: general-purpose with page access

**Prompt**:
```
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
```

---

## Phase 2a — Credibility & External Reputation

Fan out the following 2 agents in parallel after Phase 1 completes.

Each agent receives: `{{URL}}`, `{{KNOWN_CONTEXT}}`, `{{PHASE_0_SUMMARY}}`, `{{PHASE_1_SUMMARY}}`, and the Universal Artifact Template.

---

### owner-credibility → `artifacts/phase-2a/owner-credibility.md`

**Agent type**: general-purpose with web search + page access

**Prompt**:
```
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
```

---

### customer-reviews → `artifacts/phase-2a/customer-reviews.md`

**Agent type**: general-purpose with web search

**Prompt**:
```
You are researching customer reviews and external reputation for a website as part of
a new-owner audit.

SITE URL: {{URL}}
SITE OVERVIEW: {{PHASE_0_SUMMARY}}
PHASE 1 FINDINGS: {{PHASE_1_SUMMARY}}
KNOWN CONTEXT: {{KNOWN_CONTEXT}}

## Task

Search for external reviews and reputation signals. Do NOT rely on testimonials
on the site itself — look for independent sources.

Search for reviews on:
- Google Business reviews
- Trustpilot
- Reddit (search: site name + "review" or "experience")
- App stores (if a mobile app exists)
- Industry-specific review platforms (G2, Capterra, Yelp, etc.)
- Any forum or community discussions

For each source found:
- Note the platform and URL
- Summarize the overall sentiment
- List the most common praise themes
- List the most common complaint themes

Source count: record how many sources you found and consulted.

IMPORTANT: Distinguish between book/framework reviews and digital product/course reviews.
These represent different purchase experiences. A 4.7-star book with thousands of reviews
says nothing about the quality of a $149 online course. Report each category separately.

IMPORTANT: If you find no external reviews for the digital products, say so explicitly.
Do not synthesize sentiment from assumptions or the site's own testimonials.
Zero product reviews is a meaningful finding distinct from strong book reviews.

## Output

Write your findings using the Universal Artifact Template below. The Summary should
answer: "What are customers saying externally, and what sentiment patterns exist?"

{{ARTIFACT_TEMPLATE}}
```

---

## Phase 2b — Site Analysis

**IN A SINGLE MESSAGE**, dispatch ALL applicable Phase 2b agents as simultaneous Agent
tool calls after Phase 2a completes.

Each agent receives: `{{URL}}`, `{{KNOWN_CONTEXT}}`, `{{PHASE_0_SUMMARY}}`, `{{PHASE_1_SUMMARY}}`, `{{PHASE_2A_SUMMARY}}`, and the Universal Artifact Template.

**Suppression rule**: Include this instruction in every Phase 2b agent prompt:
> Do not re-document findings already confirmed in prior-phase summaries. If a prior
> finding is relevant to your angle, reference it by angle name (e.g. "see technical-hygiene")
> rather than re-reporting the full finding. Focus your research on new surfaces and
> angle-specific analysis.

---

### customer-journey → `artifacts/phase-2b/customer-journey.md`

**Agent type**: general-purpose with page access

**Prompt**:
```
You are mapping the customer journey for a website as part of a new-owner audit.

SITE URL: {{URL}}
SITE OVERVIEW: {{PHASE_0_SUMMARY}}
PRIOR RESEARCH: {{PHASE_1_SUMMARY}} {{PHASE_2A_SUMMARY}}
KNOWN CONTEXT: {{KNOWN_CONTEXT}}

**Scope boundary**: This angle covers path topology only — navigation structure, click
counts, dead ends, and stall points. Do NOT evaluate CTA copy, CTA design, or trust
signals — those belong in `conversion-trust`.

## Tool outputs (use as primary evidence for broken links)

- `tool-outputs/linkinator.json` — shallow crawl results from the homepage. Each entry
  has `url`, `status`, `state`, and `parent`. Filter `"state": "BROKEN"` to get the
  confirmed list of broken nav links and internal links, with the parent page that links
  to them. Use this as your authoritative broken-link list rather than probing URLs manually.
  If absent or zero-length: flag `[tool output unavailable]` and probe navigation URLs manually.

## Task

Map the structural path a new visitor takes from first landing to conversion.

Trace the journey:
1. Homepage: what is the primary navigation destination? Where does the main path lead?
2. Map all top-level navigation paths available to a visitor
3. Trace the shortest path to the primary conversion action — count the clicks
4. Are there secondary entry paths (blog → product, resource → signup, etc.)?
5. Where might visitors stall or reach a dead end? (broken nav, missing next step, confusion)
6. Is there a return path if someone bounces (email capture form, exit intent)?
7. Are there logical next steps visible after conversion (confirmation, onboarding prompt)?

Cannot access:
- Logged-in states or post-purchase flows → flag as [inaccessible]
- Actual user behavior data → flag as [inaccessible]

## Output

Write your findings using the Universal Artifact Template below. Use the Structured
Output block to include a numbered path trace (e.g. "Homepage → Pricing → Checkout → [inaccessible]").
The Summary should answer: "How many clicks to conversion, and where do visitors stall?"

{{ARTIFACT_TEMPLATE}}
```

---

### content-messaging → `artifacts/phase-2b/content-messaging.md`

**Agent type**: general-purpose with page access

**Prompt**:
```
You are auditing the content and messaging of a website as part of a new-owner audit.

SITE URL: {{URL}}
SITE OVERVIEW: {{PHASE_0_SUMMARY}}
PRIOR RESEARCH: {{PHASE_1_SUMMARY}} {{PHASE_2A_SUMMARY}}
KNOWN CONTEXT: {{KNOWN_CONTEXT}}

## Task

Evaluate the messaging on live pages (homepage, about, product/pricing pages).
Scope: live pages only — structural content inventory is a separate angle.

Assess:
- Value proposition: can you state it in one sentence after reading the homepage?
  If not, why not?
- Headline clarity: do headlines communicate benefit or feature?
- Tone: formal/casual/expert/friendly — is it consistent across pages?
- Target audience signal: does the copy speak to a specific person or everyone?
- Emotional vs rational appeal: what is the balance?
- Social proof integration: is it woven into the copy or bolted on?
- Any messaging that could alienate the target audience (jargon, assumptions, etc.)

Use the persona research from prior phases to evaluate fit:
do the messages land for the likely audience?

## Output

Write your findings using the Universal Artifact Template below. The Summary should
answer: "Is the messaging clear, targeted, and compelling for the right audience?"

{{ARTIFACT_TEMPLATE}}
```

---

### visual-design → `artifacts/phase-2b/visual-design.md`

**Agent type**: general-purpose with page access

**Prompt**:
```
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
```

---

### conversion-trust → `artifacts/phase-2b/conversion-trust.md`

**Agent type**: general-purpose with page access

**Prompt**:
```
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
```

---

### pricing-value → `artifacts/phase-2b/pricing-value.md`

**Agent type**: general-purpose with page access

**Prompt**:
```
You are auditing pricing and value communication for a website as part of a
new-owner audit.

SITE URL: {{URL}}
SITE OVERVIEW: {{PHASE_0_SUMMARY}}
PRIOR RESEARCH: {{PHASE_1_SUMMARY}} {{PHASE_2A_SUMMARY}}
KNOWN CONTEXT: {{KNOWN_CONTEXT}}

## Task

Evaluate how pricing is presented and whether the value is clearly communicated
at each price point.

Assess:
- Pricing page existence: is there a dedicated pricing page? If not, where is pricing shown?
- Tier structure: how many tiers/options? Are they clearly differentiated?
- Value communication: for each tier, is it clear what you get and why it's worth the price?
- Comparison: is there a feature comparison table or equivalent?
- Price anchoring: is there a "most popular" or recommended option?
- FAQ on pricing: are common pricing questions answered?
- Pricing clarity: after reading, can you state what each tier costs and who it's for?
- Value-to-price fit: based on the competitive landscape from prior research,
  does the pricing appear competitive, premium, or budget?

If no pricing page exists: document where pricing information appears (or doesn't)
and what a visitor must do to find it.

## Output

Write your findings using the Universal Artifact Template below. The Summary should
answer: "Is it clear what each tier costs, what you get, and whether it's worth it?"

{{ARTIFACT_TEMPLATE}}
```

---

### revenue-model → `artifacts/phase-2b/revenue-model.md`

**Agent type**: general-purpose with page access

**Prompt**:
```
You are mapping the revenue model for a website as part of a new-owner audit.

SITE URL: {{URL}}
SITE OVERVIEW: {{PHASE_0_SUMMARY}}
PRIOR RESEARCH: {{PHASE_1_SUMMARY}} {{PHASE_2A_SUMMARY}}
KNOWN CONTEXT: {{KNOWN_CONTEXT}}

## Task

This is a structured extraction task — NOT a strategic analysis. Be exhaustive
and literal. Do not interpret business intent.

List every monetization surface visible on the site:
- Every product or service with a price or "buy" action
- Every subscription or recurring billing option
- Every lead generation form that precedes a sale
- Every upsell, cross-sell, or bundle visible on the site
- Any affiliate links or partner offers
- Any content gated behind payment or email capture

For each surface, note:
- What it is (product name, type)
- The price (if shown) or the commitment required
- The CTA that leads to it
- Any friction point before the transaction

Do not comment on strategy. Do not recommend changes. Just list what exists.

## Output

Write your findings using the Universal Artifact Template. Use the Findings section
as a structured list of monetization surfaces. The Summary should answer:
"How many revenue surfaces are visible, and what types are they?"

{{ARTIFACT_TEMPLATE}}
```

---

### marketing-infrastructure → `artifacts/phase-2b/marketing-infrastructure.md`

**Agent type**: general-purpose with page access + source inspection

**Prompt**:
```
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
```

---

### content-inventory → `artifacts/phase-2b/content-inventory.md`

**Agent type**: general-purpose with page access

**Prompt**:
```
You are conducting a content inventory for a website as part of a new-owner audit.

SITE URL: {{URL}}
SITE OVERVIEW: {{PHASE_0_SUMMARY}}
PRIOR RESEARCH: {{PHASE_1_SUMMARY}} {{PHASE_2A_SUMMARY}}
KNOWN CONTEXT: {{KNOWN_CONTEXT}}

## Task

Map the structural content inventory. Scope: structure and presence, not quality.

Assess:
- Navigation structure: list all top-level nav items and their sub-items
- Page count estimate: use the sitemap (found in seo-technical) if available;
  otherwise estimate from navigation and visible links
- Content types present: blog posts, case studies, testimonials, resources,
  documentation, FAQs, landing pages, etc.
- Content freshness: note any visible dates — are there obviously dated posts
  (2+ years old) or content that references outdated context?
- Content gaps: based on the persona research and competitive landscape,
  what content types does the site appear to be missing?
- Orphaned or hard-to-find content: any content that appears buried or
  unreachable from the main navigation?

## Output

Write your findings using the Universal Artifact Template below. The Summary should
answer: "What content exists, how fresh is it, and what is missing?"

{{ARTIFACT_TEMPLATE}}
```

---

### brand-audit → `artifacts/phase-2b/brand-audit.md`

**Agent type**: general-purpose with page access

**Prompt**:
```
You are auditing the brand identity of a website as part of a new-owner audit.

SITE URL: {{URL}}
SITE OVERVIEW: {{PHASE_0_SUMMARY}}
PRIOR RESEARCH: {{PHASE_1_SUMMARY}} {{PHASE_2A_SUMMARY}}
KNOWN CONTEXT: {{KNOWN_CONTEXT}}

## Task

Evaluate brand identity coherence and the quality of brand assets.

Complete this extractable checklist across the homepage, about page, and one product/pricing page:

**Logo**:
- Present in header on all sampled pages? [yes/no/inconsistent]
- Appears as: [SVG icon / image file / text-only / placeholder/generic clip art]
- Same logo used on all sampled pages? [yes/no]

**Color system** (inspect CSS or visible elements):
- Approximate number of distinct background colors used across pages: [1 / 2 / 3+]
- Do primary button colors appear consistent across pages? [yes/no/inferred]
- Describe the dominant palette in plain terms (e.g. "dark navy + white + orange accent") [inferred]

**Typography**:
- Approximate number of distinct font families visible: [1 / 2 / 3+] [inferred]
- Do heading and body font styles appear consistent across pages? [yes/no/inferred]

**Brand identity risks for new owner**:
- Does the brand name appear in the domain? [yes/no]
- Does the site prominently feature the prior owner's personal name or face? [yes/no — specify location]
- Are there taglines, testimonials, or copy that reference the prior owner by name? [yes/no — quote if found]
- Any brand assets (logo, mascot, slogan) that appear person-specific? [yes/no — describe]

Rendering-dependent claims (exact color hex values, font names, precise sizes)
must be flagged as [inferred].

## Output

Write your findings using the Universal Artifact Template below. The Summary should
answer: "Is the brand identity coherent and professionally presented?"

{{ARTIFACT_TEMPLATE}}
```

---

### legal-content → `artifacts/phase-2b/legal-content.md`

**Agent type**: general-purpose with page access

**Prompt**:
```
You are auditing the content quality of legal pages for a website as part of a
new-owner audit. This complements the structural check done in Phase 1 (legal-structural).

SITE URL: {{URL}}
SITE OVERVIEW: {{PHASE_0_SUMMARY}}
PRIOR RESEARCH (includes legal-structural findings): {{PHASE_1_SUMMARY}} {{PHASE_2A_SUMMARY}}
KNOWN CONTEXT: {{KNOWN_CONTEXT}}

## Task

Read the actual content of the privacy policy and terms of service (if present —
check legal-structural findings from Phase 1).

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
```

---

### seo-content → `artifacts/phase-2b/seo-content.md`

**Agent type**: general-purpose with page access

**Prompt**:
```
You are auditing content SEO for a website as part of a new-owner audit.
This complements the technical SEO check done in Phase 1 (seo-technical).

SITE URL: {{URL}}
SITE OVERVIEW: {{PHASE_0_SUMMARY}}
PRIOR RESEARCH (includes seo-technical findings): {{PHASE_1_SUMMARY}} {{PHASE_2A_SUMMARY}}
KNOWN CONTEXT: {{KNOWN_CONTEXT}}

**Scope boundary**: Assume crawlability, indexability, robots.txt, sitemap, and canonical
tags are covered by `seo-technical`. Evaluate quality and intent alignment only — not presence.

## Task

Evaluate content-level SEO quality on key pages.

Assess (homepage + 2-3 key pages):
- Title tag quality: are titles descriptive, keyword-informed, and unique?
  (presence confirmed by seo-technical — evaluate quality here)
- Meta description quality: do they accurately describe the page and encourage clicks?
- H1/H2 structure: do headings reflect search intent and keyword themes?
- Content depth: is there enough substantive content on key pages to rank?
- Internal linking: do pages link to each other in a logical way?
- Keyword alignment: based on the apparent category and audience, are the right
  terms being used? (use competitive landscape from prior research for reference)
- Thin pages: any pages with very little content that serve no clear purpose?

## Output

Write your findings using the Universal Artifact Template below. The Summary should
answer: "Is the content optimized to attract the right search traffic?"

{{ARTIFACT_TEMPLATE}}
```

---

## Universal Artifact Template

Every research agent must write its artifact using this exact structure. Include this
template verbatim in each agent prompt as `{{ARTIFACT_TEMPLATE}}`:

```
---

## Universal Artifact Template

Write your output using these sections in order:

### Summary
3 sentences maximum. Lead with the single most important finding for the new owner.

### Raw Evidence
A list of everything you actually retrieved: exact URLs visited, copy snippets quoted
verbatim, HTML elements observed, search results found. Label each item:
- [URL] https://...
- [quote] "exact text from the page"
- [element] <tag attribute="...">
- [search result] "result title" — https://...
- [inaccessible] description of what could not be accessed and why

This section is the evidence base. Every claim in Findings must trace back here.
If you cannot populate this section, your findings are entirely [inferred].

### Structured Output *(optional — include only when the angle produces a list, table, or path trace)*
Use for: numbered path traces (customer-journey), monetization surface tables (revenue-model),
navigation inventories (content-inventory), competitor comparison tables (competitive-landscape).
Format appropriate to the content. Do not duplicate content that belongs in Findings.

### Findings
Bulleted observations. Each bullet must follow this format:
- Observation. [observed] (→ Raw Evidence item) OR [inferred] (→ basis for inference)

Use [observed] only when the claim is directly supported by Raw Evidence.
Use [inferred] when you are reasoning from indirect signals.

### Gaps & Risks
What is absent, broken, inconsistent, or could not be accessed. Be specific.
For each gap: note whether it is a quick fix or a deeper issue.

### Recommended Actions
Prioritized list. Max 7 items. Use this format exactly:
[Priority: H/M/L] [Effort: S/M/L] — Action description (specific, not generic)

Priority: H = address within 30 days, M = within 90 days, L = longer term
Effort: S = hours, M = days, L = weeks or requires outside help
```

---

## Phase Summary Schema

After each phase completes, write a `phase-N-summary.md` with one block per angle.
Phase summaries are injected into downstream agents — keep them capped and structured.

**Template for each angle block** (enforce these limits strictly):

```markdown
### <angle-name>

**key_findings**:
- [max 3 bullets — one claim each, no elaboration]

**top_risk**: [one sentence — the single most important risk or gap]

**critical_blockers**: [time-sensitive or acquisition-blocking items that cannot wait for synthesis — omit field if none]
- [e.g. "Domain expires 2026-09-21 with clientRenewProhibited lock — requires immediate action"]

**phase_2_watch_items**:
- [things downstream agents should verify or escalate — max 3]
- [label tool-failure items as [tooling] so they can be routed separately from business-priority items]

**unresolved_questions**:
- [what could not be determined — max 2]
```

Phase summaries must not exceed 100 words per angle block (excluding `critical_blockers`).
If an angle produced no significant findings, write: `No significant findings. Top risk: none identified.`

**Deduplication rule**: If the same finding appears in multiple angle blocks, note it once
in the most relevant block and add `(see also: <angle-name>)` in the other. Do not emit the
same site-wide defect (e.g. a list of broken URLs) redundantly across multiple blocks.

**known_defects block**: After all angle blocks, append a single `### known_defects` block
listing confirmed site-wide issues that all Phase 2b agents should treat as established fact
rather than re-investigating:

```markdown
### known_defects
- [confirmed site-wide issue — e.g. "8 navigation links return 404: /about/, /blog/, /testimonials/, /free-downloads/, /faqs/, /newsletter/, /counseling/, /therapist-directory/"]
- [...]
```

Phase 2b agents that receive this summary must not re-document known_defects findings —
reference by name only.

---

## Scope Gate Pruning Rules

Apply these rules when reading Phase 0 JSON. Remove pruned angles from the
applicable angle list before fanning out agents.

| Phase 0 Signal | Action |
|---|---|
| `has_ecommerce: false` AND no price points | Prune: `pricing-value`, `revenue-model` |
| `primary_conversion_action` is null or "none" | Prune: `conversion-trust`, `marketing-infrastructure` |
| `has_reviews_present: false` (and no review platform links found) | Collapse `customer-reviews` to a note: agent should search and report explicitly if nothing found |
| `page_count_estimate: "small"` | Collapse `content-inventory`: agent scopes to navigation spot-check only |
| `person_dependent_brand: false` | Do not prune `owner-credibility` — flag as lower priority in the brief |

The scope gate is a floor, not a ceiling. If Phase 0 reveals something unexpected
(e.g. a subscription community hidden behind a login), add angles rather than pruning.

---

## Phase 3 — Synthesis

Run a single general-purpose agent with this prompt. This agent receives read access
to ALL artifact files — this is the only agent that reads full reports.

```
You are synthesizing a website audit for a new owner. You have access to 20 research
artifacts produced by specialist agents across four research phases.

SITE URL: {{URL}}
SITE SLUG: {{SITE_SLUG}}
SITE OVERVIEW: {{PHASE_0_SUMMARY}}
KNOWN CONTEXT: {{KNOWN_CONTEXT}}

## Artifacts to read

Read all files in `research/{{SITE_SLUG}}/artifacts/` — all phases (phase-1/, phase-2a/, phase-2b/).
Do not summarize each artifact. Extract and synthesize across them.

## What to produce

Write research/{{SITE_SLUG}}/synthesis.md with these sections:

### Executive Summary
1 page maximum. What is the overall state of this site for the new owner?
Lead with the 3-5 most important things they need to know.
Write for a non-technical owner making decisions, not a developer.

### Quick Wins
A table of high-priority, low-effort actions:

| Action | Effort | Expected Impact | Source |
|--------|--------|-----------------|--------|
| ...    | S      | ...             | angle-name |

Include ONLY items that appear as [Priority: H] [Effort: S] across the artifacts.
Be specific — "Add phone number to header" not "Improve contact information."
Maximum 10 rows.

### Top 3 Risks
The three issues requiring the most urgent attention — regardless of effort.
For each:
- **Risk**: what it is
- **Why it matters**: consequence if unaddressed
- **Suggested first step**: the single most useful next action

### 90-Day Priority Roadmap
A phased action list grouped by timeframe:

**Month 1 — Foundations** (critical fixes and quick wins)
- ...

**Month 2-3 — Growth** (meaningful improvements)
- ...

**Ongoing** (monitoring and iteration)
- ...

Keep the roadmap to 15 items maximum. Do not include every finding — prioritize.

### Research Confidence
(Appendix — not part of the main deliverable)

List angles where research confidence was limited:
- Angle name: reason (e.g. "login wall", "no external reviews found", "bot detection")

Also list any [inaccessible] surfaces that the owner should verify manually.

## Rules

- Do not recite findings from individual artifacts verbatim — synthesize
- Quick wins must be specific and actionable, not generic
- **Effort label conflicts**: when two artifacts assign different effort ratings to the
  same item, use the higher (more conservative) estimate and note the disagreement in
  the Source column (e.g. "Source: legal-structural [S], analytics [M] — using M")
- **Risk ordering**: rank risks by severity tier — legal/structural exposure first,
  then operational gaps, then growth/strategic gaps. Within a tier, rank by urgency.
- **Recurring revenue gap**: if the site has no subscription or recurring revenue model
  and the competitive set does, treat this as a strategic risk worth surfacing — either
  as a top-3 risk or as a roadmap item, depending on relative severity.
- **Executive summary count**: use 3-5 most important things. Do not pad to fill a number;
  do not exceed 5. Each item must be first-week-critical to qualify.
- Risks must be addressed by severity and urgency, not by phase order
- The owner should be able to act on this document without reading the individual artifacts
- Do not surface confidence caveats in the executive summary — keep them in the appendix
```

---

## Guardrails

- **CRITICAL — Parallel dispatch required.** Phases 1, 2a, and 2b must each be dispatched as a **single message** with all Agent calls in parallel. Sequential dispatch (one call per message, wait, then the next) is a protocol violation that defeats the entire phased architecture. See Steps 8, 10, 12.
- **Never skip Phase 0.** All phases depend on its scope gate and context.
- **Inject only phase summaries to agents** — never full artifact reports. Phase 3 only gets full access.
- **Phase summaries are capped.** Enforce 3-bullet / 1-sentence / 100-word limits per block.
- **Every finding must cite Raw Evidence.** Claims without citations must be tagged [inferred].
- **Flag inaccessible surfaces explicitly.** Never hallucinate content behind auth walls, SPAs, or bot-blocked pages — use [inaccessible].
- **Source count required** for competitive-landscape and customer-reviews. Zero sources = say so explicitly, do not synthesize.
- **Quick wins are a Phase 3 output.** Do not flag quick wins in Phases 1–2b.
- **If Phase 0 JSON is missing or malformed**, re-prompt once. If still absent, stop and report to user before proceeding.
- **Scope gate is a floor, not a ceiling.** Phase 0 may add angles; it may only prune based on the defined rules.
- **Phase 3 reads full reports** — this is correct and intentional. Do not summarize before passing to synthesis.
