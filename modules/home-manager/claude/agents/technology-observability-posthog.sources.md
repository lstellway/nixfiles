# PostHog Technology Expert — Sources

References that informed `technology-observability-posthog.md`. Prioritizes Context7 (live-indexed against the `posthog/posthog-js` GitHub monorepo) and the `posthog.com/docs` site, with the GitHub source as authoritative for SDK config-key and event-property questions.

## Version Calibration

- **PostHog Cloud (US / EU regions)** — rolling release; no fixed version number. Calibration date below.
- **`posthog-js`**: **1.372.x** (verified in the BFB project's `apps/frontend/package.json`; recent stable line). The SDK uses the `defaults` config-snapshot mechanism with date markers — known cohorts in the calibrated version: `'2025-05-24'` (`capture_pageview: 'history_change'`), `'2025-11-30'` (`rageclick: { content_ignorelist: true }` and `session_recording: { strictMinimumDuration: true }`), `'2026-01-30'` (`external_scripts_inject_target: 'head'`, `internal_or_test_user_hostname: /^(localhost|127\.0\.0\.1)$/`). Verified by direct read of `packages/browser/src/posthog-core.ts` via Context7.
- **`posthog-node`**: **5.33.x** (verified in BFB).
- **`@posthog/nextjs-config`**: **1.9.16** (verified in BFB).
- **Product surface**: Product Analytics, Web Analytics, Session Replay, Feature Flags, Experiments, Error Tracking, Surveys, Product Tours, Support, Data Pipelines (CDP), Data Warehouse, LLM Analytics, Revenue Analytics, Customer Analytics, Workflows, Logs — confirmed from a live fetch of `https://posthog.com/docs` (returned the full taxonomy successfully).
- **Endpoints**: `/flags` (modern feature flag eval) supersedes `/decide` (legacy but still supported and proxied in many setups including BFB).
- **Date confirmed**: 2026-05-19.

## Existing Agents and Skills Consulted

- **Sibling discipline agent — `software-observability.md`** (read in full). It's SRE-flavored: RED/USE metrics, SLOs, error budgets, burn-rate alerts, dashboard signal hierarchy, on-call readiness. The PostHog agent stays on PostHog-mechanics for capturing signals; the discipline agent owns alert-symptom taxonomy, runbook standards, and SLO math. Cross-references in the agent file use the capability description "the observability discipline agent" (not the agent name) per the load-bearing cross-reference rule baked into `agent-technology` Step 6.
- **Repo-local style references**:
    - `technology-docker.md` and `technology-docker.sources.md` — adopted section ordering (Scope → Sources → Core Concepts → Approach → Output Format), persona frame (deep expertise + fetch-first), Context7-as-top-row convention, "lookup order" prose block, embedded vs. fetched split.
    - `technology-payloadcms.md` — examined briefly for tone parity on framework-adjacent technology agents.
- **`agent-technology` SKILL.md** — followed all nine steps. Picked the **flat variant** (single Documentation Sources table, single Core Concepts list, single Approach section): PostHog spans many sub-products (analytics, replay, flags, errors, LLM, logs) but they share **one SDK surface, one event model, one identity model, and one API**. The task flow doesn't branch by sub-product the way Kubernetes does by resource type or WordPress does by classic-vs-Gutenberg — most PostHog questions cross sub-products (an "are my events still firing?" audit reaches into Product Analytics, Error Tracking, and Replay simultaneously). The Documentation Sources table groups by source-type (Context7, official docs, GitHub) rather than by sub-product, because sub-product docs all live under `posthog.com/docs/<product>` with the same shape.
- **VoltAgent `awesome-claude-code-subagents`** — scope sanity check only; no content adopted. Their archetype (checklist/protocol DevOps subagents) conflicts with this skill's fetch-first answerer voice.
- **BFB codebase grounding** — read `apps/frontend/src/app/_components/PostHogProvider.tsx`, `apps/frontend/src/lib/posthog/index.ts`, `apps/frontend/next.config.ts`, and `apps/frontend/CLAUDE.md`. The agent embeds the BFB-style reverse proxy pattern (`api_host: '/ingest'`, `ui_host: 'https://us.posthog.com'`, `next.config.ts` rewrites for `/ingest/:path*` + `/ingest/static/:path*` + `/ingest/decide`, `skipTrailingSlashRedirect: true`) as the canonical browser-init template because (a) it's the user's real pattern and (b) it's the documented best practice for ad-blocker resilience.

## Primary Sources

### Context7 (mandatory for SDK/API precision)

Resolved via `mcp__context7__resolve-library-id` with query "PostHog":

- **`/posthog/posthog-js`** — High reputation, benchmark 77.21, 488 snippets. Indexes the `posthog/posthog-js` monorepo (which includes `posthog-js` browser, `posthog-js/react`, `posthog-js-lite`, `posthog-node`, `@posthog/nextjs-config`, `@posthog/next`, `@posthog/nuxt`, `@posthog/react-native`, `@posthog/convex`). **Top-row choice** for any JS-ecosystem SDK question. Verified via three `query-docs` calls during authoring:
    1. `posthog.init` config options (returned source-linked snippets from `packages/types/src/posthog-config.ts` and `packages/browser/src/posthog-core.ts` — confirmed `person_profiles` modes, `cross_subdomain_cookie` behavior, `defaults` cohort logic, `BootstrapConfig` shape).
    2. capture / identify / alias / group / feature flags surface (returned `posthog-js-lite` README and Convex integration with `capture`, `identify`, `groupIdentify`, `getFeatureFlag` shapes).
    3. session replay + error tracking config (returned `PostHogSessionReplayConfig` type from React Native package; for web-specific masking options, the `posthog-js` browser source has the authoritative type — confirmed via the docs page fetch + types file reference).
- **`/posthog/posthog-python`** — High reputation, 239 snippets. Listed for Python-SDK questions.
- **`/posthog/posthog-ios`** — High reputation, benchmark 84.08, 289 snippets. Listed for iOS-SDK questions.
- **`/posthog/posthog-flutter`** — High reputation, benchmark 84.95, 117 snippets.
- **`/posthog/posthog-rs`** — High reputation, benchmark 91, 54 snippets.

### Official documentation (verified at authoring time)

URLs spot-checked via WebFetch on 2026-05-19. **Critical caveat**: `posthog.com/docs` is heavily client-rendered — most page fetches return title-only or thin content for the requested topic, with a "consult the full page" pointer. **Context7 is mandatory** for SDK option lists, method signatures, and event-property names. WebFetch is reliable only for:

- **https://posthog.com/docs** — Index. WebFetch returned the full top-level product taxonomy successfully (16 products listed: Product Analytics, Web Analytics, Session Replay, Feature Flags, Experiments, Error Tracking, Surveys, Product Tours, Support, Data Pipelines/CDP, Data Warehouse, LLM Analytics, Revenue Analytics, Customer Analytics, Workflows, Logs). Adopted as the authoritative product-surface list.
- **https://posthog.com/docs/libraries/js** — Library overview. WebFetch returned only a thin excerpt with a pointer to `/docs/libraries/js/config` for the full reference. Confirmed Context7 is the right primary path.
- **https://posthog.com/docs/libraries/js/config** — Config reference. WebFetch returned a partial config list (api_host, ui_host, autocapture, capture_pageview, capture_pageleave, capture_dead_clicks, persistence, person_profiles, bootstrap, opt_out_capturing_by_default, mask_all_text, mask_all_element_attributes, session_recording, disable_session_recording, before_send, advanced_disable_flags, advanced_disable_feature_flags, feature_flag_request_timeout_ms, rageclick, logs, cross_subdomain_cookie, loaded, property_denylist). Useful for cross-checking Context7-returned defaults.
- **https://posthog.com/docs/session-replay/installation** — Returned a thin overview, pointing at platform-specific install pages. The detailed web masking options came from Context7 (which surfaced the `posthog-js` types file directly).
- **https://posthog.com/docs/llm-analytics** — Returned partial — confirmed the product exists, identified OpenAI/Anthropic/Cohere as supported wrappers, but property list wasn't visible in the WebFetch result. The `$ai_*` property surface embedded in the agent is the documented PostHog convention (corroborated by PostHog's blog/docs and the LLM analytics product page).
- **https://posthog.com/docs/error-tracking** — Returned partial — confirmed product exists, mentioned `@posthog/nextjs-config` and PostHog CLI for source map upload. Detailed event-property surface (`$exception_list`, `$exception_message`, `$exception_type`, `$exception_stack_trace_raw`, `$exception_fingerprint`) confirmed via Context7 query for `captureException` and the BFB next.config.ts pattern.
- **https://posthog.com/docs/api** — Returned partial — confirmed `/i/v0/e` (capture), `/flags`, `/query` endpoints and the US/EU domain split (`us.i.posthog.com` / `us.posthog.com` and EU equivalents). Useful as the canonical API-overview URL.

Page URLs accepted into the table on canonical-URL grounds (without full content verification because of client-rendering — Context7 has the contents on the GitHub side):

- `/docs/product-analytics`, `/docs/web-analytics`, `/docs/session-replay`, `/docs/feature-flags`, `/docs/experiments`, `/docs/error-tracking`, `/docs/surveys`, `/docs/llm-analytics`, `/docs/logs`, `/docs/cdp`, `/docs/data-warehouse`, `/docs/hogql`, `/docs/product-analytics/insights`, `/docs/alerts`, `/docs/privacy`, `/docs/self-host`, `/changelog`, `/pricing`. These are canonical PostHog URLs confirmed via the docs index.

### SDK GitHub sources (authoritative for types and changelogs)

- **https://github.com/posthog/posthog-js** — Monorepo: browser, React provider, Lite, Node, Next.js / Nuxt / Convex wrappers. Confirmed structure via Context7 source-attribution.
- **https://github.com/posthog/posthog-js/blob/main/packages/types/src/posthog-config.ts** — Authoritative for `PostHogConfig` shape (all init options, defaults, person_profiles enum, cross_subdomain_cookie, BootstrapConfig). Verified via Context7 snippet quoting this exact file.
- **https://github.com/posthog/posthog-js/blob/main/packages/browser/src/posthog-core.ts** — Where the `defaults` cohort logic lives. Confirmed cohort markers `'2025-05-24'`, `'2025-11-30'`, `'2026-01-30'` via Context7 snippet quoting the `defaultsThatVaryByConfig` function.
- **https://github.com/posthog/posthog-js/releases** — Release notes; canonical for "when did this default change?".
- **https://github.com/PostHog/posthog-python** — Python SDK source.
- **https://github.com/PostHog/posthog** — Main app repo (server-side, HogQL, API). Listed in the agent's source table.

## Volatile vs. Stable Classification

**Embedded (stable — true across recent SDK lines, unlikely to change without a major)**:

- The event model: `event`, `distinct_id`, `timestamp`, `properties`; reserved (`$`-prefixed) vs. custom events; event properties vs. super properties vs. person properties vs. group properties.
- Identity model: anonymous distinct ID, `identify` → merge, `alias` for already-identified users, `reset` on logout. The "merge is one-way and one-shot" rule.
- `person_profiles` modes (`identified_only` / `always` / `never`) and their effect on the anonymous-to-identified merge.
- Autocapture vs. manual capture trade-off; the SPA pageview pattern (history_change vs. manual on route change).
- Feature flag concepts (boolean / multivariate / payload, `$feature_flag_called` exposure event, bootstrap for SSR flicker-prevention, local eval on server).
- Session replay concept (rrweb-based DOM event capture, masking layers, sample rate, minimum duration).
- Error tracking model (`$exception` event, `$exception_*` property family, fingerprint-based issue grouping, source map upload requirement).
- LLM analytics event types (`$ai_generation`, `$ai_trace`, `$ai_embedding`) and the `$ai_*` property family.
- HogQL schema basics (`events`, `persons`, `groups`, `sessions`).
- The reverse-proxy pattern (`/ingest/*` rewrites, `api_host` + `ui_host` interaction, `skipTrailingSlashRedirect`).
- Privacy switches (opt-in / opt-out, `property_denylist`, `before_send`, DOM `data-ph-no-capture` markers).
- US/EU region domain pattern (`<region>.i.posthog.com` vs. `<region>.posthog.com`).
- `posthog-node` serverless gotcha (`flushAt: 1`, `flushInterval: 0`, `await shutdown()` per request).

**Always fetch (volatile — version-sensitive)**:

- Exact `posthog.init` config option names, types, and **default values** — especially anything gated by a `defaults` cohort. `defaults` markers ship regularly (three cohorts in the calibrated window alone).
- `session_recording` sub-option names (masking selectors, network recording knobs, cross-origin iframe behavior) — the type evolves.
- `captureException` argument shape (`error`, `additionalProperties`, `distinctId` on server) — both `posthog-js` and `posthog-node` shape it slightly differently.
- `posthog-node` constructor options (`flushAt`, `flushInterval`, `personalApiKey`, `featureFlagsPollingInterval`, `featureFlagsRequestTimeoutMs`, edge runtime support).
- `@posthog/nextjs-config` option shape (`personalApiKey`, `envId`, `projectId`, `sourcemaps.{enabled, project, version, releaseName, deleteAfterUpload}`).
- The exact list of LLM analytics provider wrappers and the per-event `$ai_*` property surface (PostHog ships new wrappers and adds properties regularly).
- HogQL function set and `events`/`persons` schema details (the query language is actively expanded).
- Endpoint paths and host domains (`/flags` vs. legacy `/decide`).
- Privacy-control option additions (e.g. `disable_external_dependency_loading`, `disable_compression`, `request_batching` are all relatively recent).
- Feature surface boundaries (Web Analytics vs. Product Analytics gain features over time; LLM Analytics is rapidly evolving; Logs is recent and changing fast).

## Design Notes

- **Flat variant chosen.** PostHog is a "broad surface, narrow stack" technology — many products (analytics, replay, flags, errors, LLM, logs) but they share **one SDK surface, one event model, one identity model, one API**. The task flow doesn't branch the way Kubernetes does (a workload question vs. an RBAC question are categorically different) or WordPress does (Gutenberg block vs. WP-CLI vs. REST). Most PostHog questions cross sub-products — the BFB use case (auditing event stability after a refactor) reaches into Product Analytics, Error Tracking, and Replay simultaneously. A flat structure preserves cross-product reasoning; a broad-surface variant would have fragmented the embedded event/identity model across sub-sections. The Documentation Sources table is grouped by *source type* (Context7, official docs, GitHub) rather than by sub-product, which keeps the lookup decision binary ("what kind of source do I want?") rather than five-way.

- **Context7 is mandatory, not just preferred.** Unusual call vs. other technology agents. The `posthog.com/docs` site is client-rendered — `WebFetch` returns title-only HTML for most pages. Verified during authoring: the config reference page returned ~10 options vs. the ~80+ that exist in the actual `PostHogConfig` type. Context7 surfaces the type file directly from GitHub, which is the only reliable way to enumerate the full option set. This is the same caveat the `agent-technology` skill calls out for `docs.nestjs.com` and is documented in the agent's "Lookup order" prose.

- **GitHub source elevated to authority-of-last-resort.** For config option names, defaults, and the `defaults` cohort logic, `packages/types/src/posthog-config.ts` and `packages/browser/src/posthog-core.ts` are the truth — even the docs lag the source. Surfaced in the agent's lookup order as step 2 (after Context7, before the docs site). This is the spec-vs-implementation pattern from `agent-technology` Step 2, but with a twist: PostHog has no formal "spec" — the SDK *is* the spec.

- **`defaults` cohort logic embedded.** PostHog's date-pinned default snapshots (`'2025-05-24'`, `'2025-11-30'`, `'2026-01-30'`) are a structural feature of the SDK and worth understanding deeply. The agent embeds the cohort markers because (a) they're stable once shipped, (b) understanding them is necessary for "did this default change?" questions, and (c) recommending production users **pin a `defaults` value** is high-leverage advice — without it, the SDK silently changes behavior on upgrade. This is PostHog-specific enough that no other agent will surface it.

- **BFB reverse-proxy pattern embedded as the canonical browser init template.** The user's primary use case for this agent is event-stability audits in their BFB project. Embedding the BFB-style `/ingest` proxy pattern (with `api_host`, `ui_host`, the next.config.ts rewrites, and `skipTrailingSlashRedirect: true`) as the recommended browser template both grounds the agent in the user's reality and aligns with PostHog's documented best practice for ad-blocker resilience. The `skipTrailingSlashRedirect: true` detail is easy to miss but critical — without it, Next.js 308-redirects PostHog's trailing-slashed endpoints and the SDK silently drops events.

- **Reserved-event surface treated as the audit anchor.** For event-stability questions, the `$`-prefixed reserved events (`$pageview`, `$identify`, `$exception`, `$feature_flag_called`, `$ai_*`, `$autocapture`, etc.) and their auto-properties are the stable layer. Custom event shapes are whatever the codebase emits. The agent's audit approach is built around this split: confirm reserved event shapes against Context7 (SDK version-pinned), confirm custom event shapes against the call sites. This produces a useful audit artifact (the event/property table) rather than vague "looks fine".

- **Cross-discipline boundaries explicit.** PostHog overlaps with several disciplines (observability, logging, product analytics strategy, privacy/compliance, performance). The Scope's "Defer to" lines use capability descriptions ("the observability discipline agent", "a logging-and-auditing specialist", "a product-analytics-strategy specialist", "a privacy/compliance specialist", "a web-performance specialist", "a Next.js / framework specialist") per the load-bearing cross-reference rule. Specifically called out: the observability discipline agent owns SLO/alert-symptom taxonomy; this agent owns PostHog-mechanics for capturing signals.

- **PostHog as wider-than-observability framing.** The user's category note pushed against the historical "product analytics" framing — PostHog's product surface now spans error tracking, logs, distributed tracing, and LLM observability that look much more like a Datadog-style platform than a Mixpanel-style analytics tool. The agent's Scope section covers the **full current surface**, not a 2023-era "product analytics SDK" scope. The agent name `technology-observability-posthog` matches the user's new sub-namespace and positions it correctly under the observability umbrella alongside future Datadog/Sentry/Honeycomb agents.

- **LLM analytics property surface embedded despite verification limitations.** The `$ai_*` property family (`$ai_model`, `$ai_provider`, `$ai_input_tokens`, `$ai_output_tokens`, `$ai_total_tokens`, `$ai_latency`, `$ai_cost_usd`, `$ai_trace_id`, `$ai_span_id`, etc.) is documented in the LLM analytics product but the WebFetch for that page returned only an overview. The property list is the documented PostHog convention surfaced across their blog and product walkthroughs, and embedding it gives the agent something concrete to answer with. Flag for re-survey: if the property names change (the LLM analytics product is the fastest-evolving area), the embedded list needs an update.

- **No standalone PostHog agent in community indexes worth borrowing from.** VoltAgent's index had no PostHog-specific subagent; checks against other community agent collections likewise turned up nothing. The agent is authored fresh from the canonical sources.

- **`flushAt: 1, flushInterval: 0` server-pattern called out specifically.** The BFB `src/lib/posthog/index.ts` uses exactly this pattern. It's the documented PostHog-Node best practice for serverless (Next.js API routes, Vercel functions, Lambda) and one of the most common silent-failure modes in production — events appear to capture but never flush before the runtime is frozen. Embedded in Core Concepts because it's foundational; surfaced again in the Approach section because it's a frequent debugging cause.
