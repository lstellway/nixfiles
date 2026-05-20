# Next.js Technology Expert — Sources

References that informed the content in `technology-nextjs.md`. First-hand research from authoritative sources (Context7 and nextjs.org) was prioritized over pre-existing agent definitions per author instructions.

## Version Calibration

Calibrated against **Next.js 16.2** (16.2.6 was the latest patch confirmed via `https://nextjs.org/docs/app/getting-started/caching` and `…/version-16` upgrade guide, both stamped `lastUpdated: 2026-05-13`). Context7 carries `/vercel/next.js/v16.2.2` as the latest pinnable label at authoring time. Date confirmed: 2026-05-16.

Coverage spans the App Router as primary, the Pages Router as the still-supported legacy path, and explicit notes on behavioral shifts across v13 (App Router introduction), v14 (Server Actions stable), v15 (async request APIs, fetch caching default flipped to uncached), and v16 (`middleware` → `proxy`, Cache Components / `use cache` opt-in model, async sync-compat removed, `cacheLife`/`cacheTag` stable, `revalidateTag` signature change, Turbopack default, React 19.2, several removals).

## Primary Sources — Context7

Per author instructions, Context7 is the top-priority source for documentation lookups.

- **`/vercel/next.js`** (and `/vercel/next.js/v16.2.2`) — Vercel's official Next.js library on Context7. Source Reputation: High; Benchmark Score: 89.38; 2,178 code snippets. Versions surveyed include `v16.2.2`, `v16.1.x`, `v15.4.0-canary.82`, `v14.3.0-canary.87`, `v13.5.11`, `v12.3.7`. Used as the primary documentation backbone for caching, `use cache`, `cacheTag`, `cacheLife`, `cacheComponents`, fetch caching, route handler revalidation, and migration guidance.
- `/llmstxt/nextjs_llms-full_txt` — alternate, larger snippet index of nextjs.org (40,721 snippets). Noted as a fallback when `/vercel/next.js` doesn't surface a specific topic.

## Primary Sources — nextjs.org (verified accessible)

All pages below were fetched and read at authoring time. The `.md` suffix variant works on every `nextjs.org/docs/...` URL and returns frontmatter (including `version` and `lastUpdated`) plus raw markdown — used to confirm version stamps.

### Documentation indices
- https://nextjs.org/docs/llms.txt — full documentation index.
- https://nextjs.org/docs/llms-full.txt — full content export.

### Getting started / overview
- https://nextjs.org/docs/app — App Router root.
- https://nextjs.org/docs/app/getting-started/server-and-client-components — confirmed the `"use client"` module-graph boundary semantics and the `children`-as-server-RSC pattern.
- https://nextjs.org/docs/app/getting-started/caching — Cache Components / `use cache` model (the **new** v16 caching guide), `cacheLife`, `cacheTag`, streaming uncached data via Suspense, runtime API patterns (`cookies()`, `headers()`, etc.), non-deterministic ops via `connection()`.
- https://nextjs.org/docs/app/guides/caching-without-cache-components — the **previous** caching model still relevant for projects not on Cache Components.
- https://nextjs.org/docs/app/getting-started/mutating-data — Server Functions / Actions, security warning that they are public POST endpoints, `revalidatePath`/`revalidateTag`/`updateTag`/`refresh`/`redirect`/`cookies()` interactions.
- https://nextjs.org/docs/app/getting-started/metadata-and-og-images — static and `generateMetadata` exports, file-based metadata, OG image generation via `ImageResponse` from `next/og`, the React `cache()` memoization pattern.

### File conventions
- https://nextjs.org/docs/app/api-reference/file-conventions — directory index confirming current files: `default`, `error`, `forbidden`, `instrumentation`, `instrumentation-client`, `layout`, `loading`, `mdx-components`, `not-found`, `page`, `proxy` (v16, replacing `middleware`), `route`, `unauthorized`, `template` (referenced under templates), Dynamic Routes, Parallel Routes, Intercepting Routes, Route Groups, Metadata Files, Route Segment Config, `public`, `src`.
- https://nextjs.org/docs/app/api-reference/file-conventions/proxy — v16 proxy file.
- https://nextjs.org/docs/app/api-reference/file-conventions/route-segment-config — `dynamic`, `revalidate`, `fetchCache`, `runtime`, `dynamicParams`.

### API reference (cited in the agent's source table; spot-checked structure)
- https://nextjs.org/docs/app/api-reference/functions/fetch — confirmed `cache: 'auto' | 'no-store' | 'force-cache'`, `next.revalidate`, `next.tags`, `signal` to opt out of memoization.
- https://nextjs.org/docs/app/api-reference/functions/revalidateTag — v16 signature requires `cacheLife` profile as second arg.
- https://nextjs.org/docs/app/api-reference/functions/updateTag — new in v16; Server Actions only; read-your-writes.
- https://nextjs.org/docs/app/api-reference/functions/refresh — new in v16; client-router refresh from Server Actions.
- https://nextjs.org/docs/app/api-reference/functions/cacheLife , `/cacheTag` — stable in v16 (no `unstable_` prefix).
- https://nextjs.org/docs/app/api-reference/config/next-config-js/cacheComponents — enables Cache Components / PPR.
- https://nextjs.org/docs/app/api-reference/directives/use-cache — directive reference (data-level vs UI-level, cache key serialization rules).
- https://nextjs.org/docs/app/api-reference/directives/use-client — directive reference.
- https://nextjs.org/docs/app/api-reference/components/{image,font,script,link} — built-in component reference (spot-checked existence; specific options/defaults to be fetched per-question due to v16 default changes).
- https://nextjs.org/docs/app/api-reference/config/next-config-js — config index.
- https://nextjs.org/docs/app/api-reference/config/next-config-js/turbopack — top-level in v16 (was `experimental.turbopack` in v15).

### Upgrade guides
- https://nextjs.org/docs/app/guides/upgrading/version-16 — fully read. Source of authoritative v15→v16 change list: Turbopack default, async APIs removal of sync compat, `middleware` → `proxy`, PPR moved under `cacheComponents`, `revalidateTag` second-arg requirement, `cacheLife`/`cacheTag` stabilization, `next/image` default changes (`minimumCacheTTL` 60s → 4h, `qualities` → `[75]`, `imageSizes` drops 16, `dangerouslyAllowLocalIP`, `maximumRedirects` cap), Parallel route `default.js` requirement, removals (AMP, `next lint`, `serverRuntimeConfig`/`publicRuntimeConfig`, `experimental.dynamicIO`, `experimental.useCache`, `unstable_rootParams`), React 19.2 baseline, React Compiler stable (opt-in), Node 20.9+ requirement, TS 5.1+ requirement, ESLint flat config default. Codemod entry point: `npx @next/codemod@canary upgrade latest`.
- https://nextjs.org/docs/app/guides/upgrading/version-15 — async request APIs origin (v15 introduced them with sync compat).
- https://nextjs.org/docs/app/guides/migrating/app-router-migration — Pages → App migration, including `fetch`-based replacements for `getStaticProps` / `getServerSideProps`.
- https://nextjs.org/docs/app/guides/upgrading/codemods — codemod catalog.

### Reference / community
- https://nextjs.org/docs/messages — curated error-message pages (one URL per error).
- https://nextjs.org/blog — release announcements (used to verify the v16.2 release narrative: "use cache", Turbopack defaults, proxy rename).
- https://github.com/vercel/next.js — source and issues.

## Community / Cross-check

- **VoltAgent `awesome-claude-code-subagents`** — surveyed at `https://github.com/VoltAgent/awesome-claude-code-subagents` (top-level categories: `01-core-development`, `02-language-specialists`, …, `10-research-analysis`). The closest existing entries are generic — `frontend-developer.md`, `fullstack-developer.md` — with **no dedicated Next.js subagent** found in `01-core-development`. Used purely as a final sanity-check that no upstream Next.js-specific persona existed worth borrowing structural ideas from; nothing was adopted from this repo.
- **Web articles** (used only to triangulate version timeline, not as authoritative content): nandann.com guide to 16.2 (`use cache`, Turbopack, proxy); descope.com 15-vs-16 comparison; medium / u11d posts on the `middleware` → `proxy` rename; abhs.in confirming 15.2.4 was the prior stable line before 16.x.

## Volatile vs. Stable Classification

**Stable (embedded directly in the agent):**
- The Server vs Client Components mental model and the `"use client"` boundary semantics. (Stable since v13.)
- The `"use server"` directive's two placements and the security model (public POST endpoint, authorize inside). (Stable since v14.)
- App Router file-convention names and roles (`page`, `layout`, `loading`, `error`, `not-found`, `template`, `default`, `route`). The set has grown (`forbidden`, `unauthorized`) but existing names are stable.
- Route group `(group)`, parallel slot `@slot`, intercepting route `(.)(..)(...)` notation. (Stable since v13.)
- The conceptual existence of the four cache layers (Request Memoization, Data Cache, Full Route Cache, Router Cache).
- High-level distinction between App Router and Pages Router.

**Volatile (always fetch from docs):**
- **Caching defaults at every layer** — flipped in v15 (`fetch` default uncached) and reorganized in v16 (`cacheComponents` opt-in model with `"use cache"` as the primary surface). Embedding a stale default is the single largest risk for this agent.
- All `next.config.js` keys, their experimental status, and Turbopack option shape (moved from `experimental.turbopack` to top-level `turbopack` in v16).
- `next/image` defaults — `minimumCacheTTL`, `qualities`, `imageSizes`, `localPatterns.search`, `dangerouslyAllowLocalIP`, `maximumRedirects` — all changed in v16. `images.domains` deprecated.
- `revalidateTag` signature — added a required second arg in v16.
- The full Route Segment Config option matrix and accepted values.
- Async request API shape — `cookies()`, `headers()`, `draftMode()`, `params`, `searchParams` are async-only in v16; sync compat removed.
- Error-message text — fetch per-error from `/docs/messages/<slug>`.
- Latest stable version itself — `npm view next version` is the fastest verification.

## Design Notes

A few patterns emerged that may be useful for future tech-agent authoring:

1. **For frameworks with high churn, version-stamp the agent in the calibration section and pin Context7 to a specific version label** (`/vercel/next.js/v16.2.2`). This gives reproducibility — if the agent is consulted six months later, the calibration paragraph plus the pinned Context7 ID make it obvious whether a re-survey is needed.
2. **For Next.js specifically, caching defaults are the single highest-risk volatile area.** The agent's caching section explicitly tells the agent never to answer caching defaults from memory and to always establish (version, Cache Components on/off, App vs Pages) before answering. This pattern likely generalizes to any framework where defaults have shifted majors recently (e.g., React 19 form state defaults, Tailwind v4 config changes).
3. **The "Defer to peer agents" section benefits from being unusually specific for framework agents that sit at a layered ecosystem boundary.** Next.js touches React, WordPress (as a data source), Payload, deployment, and architecture — calling out each by name and stating *what stays here vs. what defers* prevents both turf wars and gaps.
4. **The `.md` suffix trick on nextjs.org URLs** — appending `.md` to any docs URL returns the raw markdown plus frontmatter (`version`, `lastUpdated`). Worth noting in the agent prompt itself because it materially speeds up fetches, and it's a Next.js-specific convenience that the agent should leverage.
5. **Recording version-by-version "what changed" as a table inside Core Concepts** (the version landscape table) gives the agent a fast triage path when the user mentions a version, before any fetch happens. Worth replicating for any framework with > 2 active major lines.
