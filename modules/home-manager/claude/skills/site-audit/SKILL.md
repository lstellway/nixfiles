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

**Optional**:
- `KNOWN_CONTEXT` — any additional context about the site (e.g. acquisition price, known issues, business goals, target market). Injected into all agent prompts as background.

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
- `page-source.html` — raw HTML page source for technology fingerprinting (analytics tags, CMS, ESP, CRM) → analytics-instrumentation, marketing-infrastructure
- `screenshot-desktop.png` — full-page desktop render → visual-design, conversion-trust
- `screenshot-mobile.png` — full-page mobile render → visual-design, accessibility
- `http-headers.txt` — HTTP response headers → technical-hygiene
- `robots.txt` / `sitemap.xml` — crawl directives and declared URL set → seo-technical
- `sitemaps/` — all child sitemaps downloaded locally (present when sitemap.xml is a sitemap index) → seo-technical
- `whois.txt` — domain registration and expiry → owner-credibility
- `lychee.json` — sitemap URL integrity (declared URLs → HTTP status) → seo-technical
- `linkinator.json` — crawled link integrity (linked URLs from HTML → HTTP status) → customer-journey

---

## Pre-flight Tooling

Before Phase 0, check for required tools, report any that are missing to the user,
and get confirmation before running any commands.

By this point `SITE_SLUG` has already been derived from the URL (step 2 of Execution Flow).
Derive `{{BASE_URL}}` as scheme + domain (e.g. `https://www.howwelove.com`).
Derive `{{DOMAIN}}` as the bare domain (e.g. `howwelove.com`).

### Step 1 — Dependency Check

Run this first:

```bash
for cmd in curl whois lychee node npx; do
  if command -v "$cmd" &>/dev/null; then echo "  ✓ $cmd"; else echo "  ✗ $cmd — not found"; fi
done
```

For each missing tool, note the affected outputs:

| Missing tool | Outputs skipped | Angles degraded |
|---|---|---|
| `curl` | http-headers.txt, robots.txt, sitemap.xml | technical-hygiene, seo-technical |
| `whois` | whois.txt | owner-credibility (domain age/expiry) |
| `lychee` | lychee.json | seo-technical (sitemap URL integrity) |
| `node` / `npx` | lighthouse.json, axe.json, pa11y.json, page-source.html, linkinator.json, screenshot-*.png | technical-hygiene, accessibility, seo-technical, analytics-instrumentation, marketing-infrastructure, visual-design, conversion-trust |

- If **all tools are present**: report a brief ✓ status and proceed automatically to Step 2.
- If **any tools are missing**: report the missing tools and their impact, then ask:
  > "The tools above are missing. Proceed without them (affected checks will be skipped), or stop to install first?"
  If the user declines, stop. Do not proceed to Phase 0.

### Step 2 — Run Tool Commands

**IN A SINGLE MESSAGE**, dispatch one sub-agent per command below as simultaneous Agent
tool calls. Skip sub-agents for tools that failed the dependency check.
Each sub-agent runs its command, writes the output file to disk, and returns a single
status line: `<tool>: OK` or `<tool>: FAILED`. Do not read the output files in the main
thread — they are consumed by phase agents directly from disk.

After all sub-agents complete, collect their status lines and build a status table to
pass to Phase 0 as part of the known context block.

**Sub-agent prompts** — one per command:

**lighthouse**: Run the following command. Output the single line `lighthouse: OK` if it succeeds, `lighthouse: FAILED` if it does not.
```bash
npx --yes lighthouse {{BASE_URL}} \
  --output json \
  --output-path research/{{SITE_SLUG}}/tool-outputs/lighthouse.json \
  --chrome-flags="--headless --no-sandbox" \
  --quiet 2>/dev/null
```

**axe**: Run the following commands. Output the single line `axe: OK` if it succeeds, `axe: FAILED` if it does not.
```bash
npx browser-driver-manager install chrome 2>/dev/null
CHROME_PATH=$(find "$HOME/.browser-driver-manager/chrome" -name "Google Chrome for Testing" -type f 2>/dev/null | sort | tail -1)
CHROMEDRIVER_PATH=$(find "$HOME/.browser-driver-manager/chromedriver" -name "chromedriver" -type f 2>/dev/null | sort | tail -1)
npx --yes @axe-core/cli {{BASE_URL}} \
  --chrome-path "$CHROME_PATH" \
  --chromedriver-path "$CHROMEDRIVER_PATH" \
  --stdout \
  > research/{{SITE_SLUG}}/tool-outputs/axe.json 2>/dev/null
```

**curl** (http-headers, robots.txt, sitemap.xml, child sitemaps): Run the following commands. Output the single line `curl: OK` if all succeed, `curl: FAILED` if any do not.
```bash
curl -sI --max-time 15 --location "{{BASE_URL}}" \
  > research/{{SITE_SLUG}}/tool-outputs/http-headers.txt 2>/dev/null
curl -s --max-time 10 "{{BASE_URL}}/robots.txt" \
  > research/{{SITE_SLUG}}/tool-outputs/robots.txt 2>/dev/null
curl -s --max-time 10 "{{BASE_URL}}/sitemap.xml" \
  > research/{{SITE_SLUG}}/tool-outputs/sitemap.xml 2>/dev/null
if grep -q '<sitemapindex' research/{{SITE_SLUG}}/tool-outputs/sitemap.xml 2>/dev/null; then
  mkdir -p research/{{SITE_SLUG}}/tool-outputs/sitemaps
  while IFS= read -r url; do
    fname="research/{{SITE_SLUG}}/tool-outputs/sitemaps/$(basename "$url")"
    curl -s --max-time 10 "$url" -o "$fname" 2>/dev/null
  done < <(grep -oE 'https?://[^<]+\.xml' research/{{SITE_SLUG}}/tool-outputs/sitemap.xml)
fi
```

**whois**: Run the following command. Output the single line `whois: OK` if it succeeds, `whois: FAILED` if it does not.
```bash
whois "{{DOMAIN}}" \
  > research/{{SITE_SLUG}}/tool-outputs/whois.txt 2>/dev/null
```

**lychee**: Run the following commands. Output the single line `lychee: OK` if it succeeds, `lychee: FAILED` if it does not.
```bash
if [ -d "research/{{SITE_SLUG}}/tool-outputs/sitemaps" ] && \
   ls research/{{SITE_SLUG}}/tool-outputs/sitemaps/*.xml 1>/dev/null 2>/dev/null; then
  SITEMAP_INPUTS="research/{{SITE_SLUG}}/tool-outputs/sitemaps/*.xml"
else
  SITEMAP_INPUTS="research/{{SITE_SLUG}}/tool-outputs/sitemap.xml"
fi
lychee --format json \
  --output research/{{SITE_SLUG}}/tool-outputs/lychee.json \
  --timeout 10 \
  --max-concurrency 8 \
  --no-progress \
  $SITEMAP_INPUTS 2>/dev/null
```

**linkinator**: Run the following command. Output the single line `linkinator: OK` if it succeeds, `linkinator: FAILED` if it does not.
```bash
npx --yes linkinator "{{BASE_URL}}" \
  --recurse \
  --format JSON \
  --concurrency 5 \
  --timeout 30000 \
  --skip "mailto:" \
  --retry \
  2>/dev/null > research/{{SITE_SLUG}}/tool-outputs/linkinator.json
```

**page-source**: Run the following command. Output the single line `page-source: OK` if it succeeds, `page-source: FAILED` if it does not.
```bash
curl -sL --max-time 15 \
  -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" \
  "{{BASE_URL}}" \
  > research/{{SITE_SLUG}}/tool-outputs/page-source.html 2>/dev/null
```

**pa11y**: Run the following commands. Output the single line `pa11y: OK` if it succeeds, `pa11y: FAILED` if it does not.
```bash
CHROME_PATH=$(find "$HOME/Library/Caches/ms-playwright" -name "Google Chrome for Testing" -type f 2>/dev/null | sort | tail -1)
PUPPETEER_EXECUTABLE_PATH="$CHROME_PATH" npx --yes pa11y "{{BASE_URL}}" \
  --reporter json \
  > research/{{SITE_SLUG}}/tool-outputs/pa11y.json 2>/dev/null
```

**screenshots** (desktop + mobile): Run the following commands. Output the single line `screenshots: OK` if both succeed, `screenshots: FAILED` if either does not.
```bash
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

After all sub-agents complete, collect their status lines and build a status table to
pass to Phase 0 as part of the known context block.

**URL integrity outputs:**
- `tool-outputs/lychee.json` — one entry per sitemap URL with `status` and `url` fields. Filter `"status": 404` or `"status": 301` to find declared-but-broken URLs. Built from local `sitemaps/*.xml` files (or `sitemap.xml` if not an index).
- `tool-outputs/linkinator.json` — array of `{url, status, state, parent}` objects. Filter `"state": "BROKEN"` to find broken nav links and internal links.

**Technology and accessibility outputs:**
- `tool-outputs/page-source.html` — raw HTML page source. Grep for technology signatures: GTM (`googletagmanager`), GA4 (`gtag/js`), WordPress (`wp-content`), Elementor (`elementor`), WooCommerce (`woocommerce`), Stripe (`stripe`), etc. Use for analytics-instrumentation and marketing-infrastructure angles.
- `tool-outputs/pa11y.json` — array of accessibility issues with `type`, `code`, `message`, `context`, `selector`. Use for accessibility angle.

**Visual outputs:**
- `tool-outputs/screenshot-desktop.png` — full-page desktop screenshot. Use for visual-design and conversion-trust angles.
- `tool-outputs/screenshot-mobile.png` — full-page mobile screenshot. Use for visual-design and accessibility angles.

---

## Execution Flow

Follow these steps in order. Do not skip or reorder phases.

1. Parse inputs. URL is required — if missing, ask the user before proceeding.
2. **Derive `SITE_SLUG` from the URL immediately** — do not wait for Phase 0. Take the hostname, lowercase it, strip `www.`, replace `.` with `-` (e.g. `www.howwelove.com` → `howwelove`). All output paths and agent prompts use this value.
3. Create the output directory: `research/<site-slug>/artifacts/phase-1/`, `phase-2a/`, `phase-2b/`, `tool-outputs/`.
4. **Pre-flight** — run the dependency check, report any missing tools with their affected outputs to the user, and ask whether to continue. If the user declines, stop. Then run available tool commands and note successes and failures.
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

**Prompt file convention**: Each agent's prompt is stored in `agents/<phase>/<name>.md` relative to this skill directory. When spawning any agent:
1. Read the prompt file (e.g. `agents/phase-1/persona-research.md`)
2. Substitute `{{ARTIFACT_TEMPLATE}}` with the content of `agents/shared/artifact-template.md`
3. Substitute all other `{{VARIABLE}}` placeholders with the appropriate runtime values
4. Pass the resulting text as the agent's prompt

**Context injection rule**: Inject phase summary content as **inline text** in each agent prompt under a clearly labeled section header (e.g. `## Prior Research: Phase 1 Summary`). Pass the full text of the summary file — do not pass a file path and expect the agent to read it. Phase 3 is the only agent that reads artifact files directly.

**Failure handling**: If any Phase 1, 2a, or 2b agent fails or returns output that does not match the artifact template, skip that angle, write a one-line note in the phase summary (`<angle-name>: unavailable — agent failed`), and continue. Do not halt the workflow. Surface all skipped angles in the final report to the user.

---

## Phase 0 — Site Overview

Run a single general-purpose agent with this prompt (fill in `{{URL}}` and `{{KNOWN_CONTEXT}}`):

**Prompt file**: `agents/phase-0/site-overview.md`

Write the agent output to `research/<site-slug>/phase-0-summary.md`.

---

## Phase 1 — Foundational Research

Fan out the following agents in parallel. Each agent writes its artifact to the path shown.

For each agent, read its prompt file, substitute the following variables, then pass to the Agent tool:
- `{{URL}}` — the site URL
- `{{KNOWN_CONTEXT}}` — the user's known context block
- `{{PHASE_0_SUMMARY}}` — the prose section of `phase-0-summary.md` (not the JSON)
- `{{ARTIFACT_TEMPLATE}}` — the full content of the Universal Artifact Template section in this file

---

### persona-research → `artifacts/phase-1/persona-research.md`

**Agent type**: general-purpose with web search

**Prompt file**: `agents/phase-1/persona-research.md`

---

### competitive-landscape → `artifacts/phase-1/competitive-landscape.md`

**Agent type**: general-purpose with web search

**Prompt file**: `agents/phase-1/competitive-landscape.md`

---

### analytics-instrumentation → `artifacts/phase-1/analytics-instrumentation.md`

**Agent type**: general-purpose with page source access

**Prompt file**: `agents/phase-1/analytics-instrumentation.md`

---

### legal-structural → `artifacts/phase-1/legal-structural.md`

**Agent type**: general-purpose with page access

**Prompt file**: `agents/phase-1/legal-structural.md`

---

### technical-hygiene → `artifacts/phase-1/technical-hygiene.md`

**Agent type**: general-purpose with page access

**Prompt file**: `agents/phase-1/technical-hygiene.md`

---

### accessibility → `artifacts/phase-1/accessibility.md`

**Agent type**: general-purpose with page access

**Prompt file**: `agents/phase-1/accessibility.md`

---

### seo-technical → `artifacts/phase-1/seo-technical.md`

**Agent type**: general-purpose with page access

**Prompt file**: `agents/phase-1/seo-technical.md`

---

## Phase 2a — Credibility & External Reputation

Fan out the following 2 agents in parallel after Phase 1 completes.

Each agent receives: `{{URL}}`, `{{KNOWN_CONTEXT}}`, `{{PHASE_0_SUMMARY}}`, `{{PHASE_1_SUMMARY}}`, `{{ARTIFACT_TEMPLATE}}`. Read each agent's prompt file and substitute these variables before passing to the Agent tool.

---

### owner-credibility → `artifacts/phase-2a/owner-credibility.md`

**Agent type**: general-purpose with web search + page access

**Prompt file**: `agents/phase-2a/owner-credibility.md`

---

### customer-reviews → `artifacts/phase-2a/customer-reviews.md`

**Agent type**: general-purpose with web search

**Prompt file**: `agents/phase-2a/customer-reviews.md`

---

## Phase 2b — Site Analysis

**IN A SINGLE MESSAGE**, dispatch ALL applicable Phase 2b agents as simultaneous Agent
tool calls after Phase 2a completes.

Each agent receives: `{{URL}}`, `{{KNOWN_CONTEXT}}`, `{{PHASE_0_SUMMARY}}`, `{{PHASE_1_SUMMARY}}`, `{{PHASE_2A_SUMMARY}}`, `{{ARTIFACT_TEMPLATE}}`. Read each agent's prompt file and substitute these variables before passing to the Agent tool.

**Suppression rule**: Include this instruction in every Phase 2b agent prompt:
> Do not re-document findings already confirmed in prior-phase summaries. If a prior
> finding is relevant to your angle, reference it by angle name (e.g. "see technical-hygiene")
> rather than re-reporting the full finding. Focus your research on new surfaces and
> angle-specific analysis.

---

### customer-journey → `artifacts/phase-2b/customer-journey.md`

**Agent type**: general-purpose with page access

**Prompt file**: `agents/phase-2b/customer-journey.md`

---

### content-messaging → `artifacts/phase-2b/content-messaging.md`

**Agent type**: general-purpose with page access

**Prompt file**: `agents/phase-2b/content-messaging.md`

---

### visual-design → `artifacts/phase-2b/visual-design.md`

**Agent type**: general-purpose with page access

**Prompt file**: `agents/phase-2b/visual-design.md`

---

### conversion-trust → `artifacts/phase-2b/conversion-trust.md`

**Agent type**: general-purpose with page access

**Prompt file**: `agents/phase-2b/conversion-trust.md`

---

### pricing-value → `artifacts/phase-2b/pricing-value.md`

**Agent type**: general-purpose with page access

**Prompt file**: `agents/phase-2b/pricing-value.md`

---

### revenue-model → `artifacts/phase-2b/revenue-model.md`

**Agent type**: general-purpose with page access

**Prompt file**: `agents/phase-2b/revenue-model.md`

---

### marketing-infrastructure → `artifacts/phase-2b/marketing-infrastructure.md`

**Agent type**: general-purpose with page access + source inspection

**Prompt file**: `agents/phase-2b/marketing-infrastructure.md`

---

### content-inventory → `artifacts/phase-2b/content-inventory.md`

**Agent type**: general-purpose with page access

**Prompt file**: `agents/phase-2b/content-inventory.md`

---

### brand-audit → `artifacts/phase-2b/brand-audit.md`

**Agent type**: general-purpose with page access

**Prompt file**: `agents/phase-2b/brand-audit.md`

---

### legal-content → `artifacts/phase-2b/legal-content.md`

**Agent type**: general-purpose with page access

**Prompt file**: `agents/phase-2b/legal-content.md`

---

### seo-content → `artifacts/phase-2b/seo-content.md`

**Agent type**: general-purpose with page access

**Prompt file**: `agents/phase-2b/seo-content.md`

---

## Universal Artifact Template

The template is stored in `agents/shared/artifact-template.md` and injected into every Phase 1 and 2b agent prompt via `{{ARTIFACT_TEMPLATE}}`. Edit that file to update the template structure across all agents at once.

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

**Prompt file**: `agents/phase-3/synthesis.md`

---

## Guardrails

- **CRITICAL — Parallel dispatch required.** Pre-flight Step 2, Phases 1, 2a, and 2b must each be dispatched as a **single message** with all Agent calls in parallel. Sequential dispatch (one call per message, wait, then the next) is a protocol violation that defeats the entire phased architecture. See Pre-flight Step 2 and Execution Flow Steps 8, 10, 12.
- **Pre-flight output stays out of the main thread.** Tool output files (lighthouse.json, axe.json, etc.) are written to disk by sub-agents and consumed by phase agents directly. The main thread receives only the status table (one `tool: OK/FAILED` line per sub-agent). Do not read or summarize tool output content in the coordinator context.
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
