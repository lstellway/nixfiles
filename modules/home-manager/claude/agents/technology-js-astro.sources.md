# Astro Technology Expert — Sources

References that informed the content in `technology-astro.md`. First-hand research from authoritative sources (Context7, `docs.astro.build`, `starlight.astro.build`, and `npm view`) was prioritized over pre-existing agent definitions per the skill's instructions.

## Version Calibration

The agent provides full coverage of the Astro 5 → 6 upgrade path, currently the most common in-flight migration, and treats Astro 6 / Starlight 0.39 as the recommended baseline for new work. Earlier majors are summarized for context.

Calibrated against (all `npm view` checks performed on 2026-05-17):

- **Astro `6.3.3`** — current published latest. Astro 6 is the agent's recommended baseline.
- **`@astrojs/starlight` `0.39.2`** — current published latest. Starlight remains pre-1.0; the agent flags this and biases toward fetching for Starlight-specific option questions.
- **`@astrojs/mdx` `5.0.6`** and **`@astrojs/react` `5.0.5`** — adjacent integration versions noted for reference.
- **Tailwind CSS v4** — current major; pairs with `@tailwindcss/vite` via `astro add tailwind` from Astro 5.2+. Tailwind v3 + `@astrojs/tailwind` is documented as the legacy path.

**Calibration date: 2026-05-17.**

## Existing agents and skills consulted

- **`technology-nextjs.md` / `.sources.md`** (in `~/.claude/agents/`) — used as the structural template for this agent (table-driven sources, version landscape, fetch-vs-embed discipline). Patterns adopted: the version-landscape table as a fast triage path; explicit per-task-type strategy section; output-format-by-task-type closer. Patterns *not* adopted: a deep Pages-Router-style "legacy alternate" framing (Astro's legacy paths are limited to the pre-Content-Layer collection config, called out inline rather than given its own section).
- **`technology-react.md`** (in `~/.claude/agents/`) — confirmed it covers React internals; referenced explicitly in the Defer block so island-internals questions route correctly.
- **`technology-tailwindcss.md`** — noted as being authored in parallel (per the task instructions). Referenced in the Defer block and in the "Tailwind in Astro" section: this agent handles **wiring** (Vite plugin via `astro add tailwind`, `customCss` location, single `@import "tailwindcss";`, plus the Tailwind 3 legacy path); Tailwind utility/syntax questions defer.
- **`software-user-experience.md`** and **`software-accessibility.md`** — confirmed scope (information architecture; a11y patterns). Referenced in the Defer block for content-site IA and Starlight override a11y.
- **VoltAgent `awesome-claude-code-subagents`** — surveyed at `https://github.com/VoltAgent/awesome-claude-code-subagents`. No dedicated Astro/Starlight subagent existed in `01-core-development` or `02-language-specialists`; the only closely-related entries (`frontend-developer`, `fullstack-developer`) are generic and use a checklist/protocol persona that conflicts with this skill's fetch-first expert-answerer voice. Nothing adopted; used purely as a scope sanity-check.

## Primary Sources — Context7

Per the skill's instructions, Context7 is the top-priority lookup path.

### Astro core

- **`/websites/astro_build_en`** — 3,628 snippets, **High** source reputation, benchmark **84.77**. Top-pick for documentation lookups against the official `docs.astro.build` content.
- **`/withastro/astro`** — 461 snippets, **High** reputation, benchmark **75.98**. Includes a pinnable version label `astro_6.3.1`. Recommended when the user pins a specific version or asks about source/migration specifics.
- `/llmstxt/astro_build_llms-full_txt` — 3,140 snippets, High reputation, benchmark **86.98**. Alternate full-content index; listed as a fallback in the agent.
- `/llmstxt/astro_build_llms_txt` — 1,361 snippets; partial.
- `/withastro/docs` — 2,781 snippets; redundant with the `_en` website index. Not listed in the agent to avoid noise.

### Starlight

- **`/withastro/starlight`** — 457 snippets, **High** source reputation, benchmark **76.47**. The authoritative Starlight library on Context7; covers config, sidebar, frontmatter, overrides, plugins.
- `/websites/starlight_astro_build_getting-started` — only 8 snippets; too narrow to be useful as the primary index. Not listed.
- `/netlify/astro-documentation-starter` and `/zane-ops/docs` — community Starlight users, not authoritative; not listed.

## Primary Sources — official docs sites (verified accessible)

All URLs below were fetched and read at authoring time (2026-05-17). Both sites return server-rendered Markdown content that `WebFetch` parses cleanly — no client-rendering gotchas, Context7 is preferred for speed but not mandatory.

### Astro

- https://docs.astro.build/ — documentation home; structure confirmed (Tutorial, Guide, Reference, Ecosystem).
- https://docs.astro.build/en/reference/configuration-reference/ — fully read. Confirmed top-level config keys (site, base, trailingSlash, redirects, **output (`'static' | 'server'` only — no `'hybrid'`)**, adapter, integrations, srcDir/publicDir/outDir/cacheDir, compressHTML, scopedStyleStrategy, prerenderConflictBehavior, vite, security; nested: build, server, session, devToolbar, prefetch, image, markdown, i18n, env, fonts).
- https://docs.astro.build/en/reference/directives-reference/ — fully read. Confirmed client (`client:load`, `client:idle`, `client:visible`, `client:media`, `client:only`), template (`class:list`, `set:html`, `set:text`), script/style (`is:global`, `is:inline`, `define:vars`), server (`server:defer`), advanced (`is:raw`).
- https://docs.astro.build/en/reference/cli-reference/ — fully read. Confirmed commands (`dev`, `build`, `preview`, `check`, `sync`, `add`, `docs`, `info`, `preferences`, `telemetry`, `create-key`) and common flags (`--port`, `--host`, `--open`, `--verbose`, `--root`, `--config`).
- https://docs.astro.build/en/reference/api-reference/ — `Astro` global reference (spot-checked existence).
- https://docs.astro.build/en/reference/modules/astro-content/ — `astro:content` virtual module reference (cited in the agent; spot-checked structure).
- https://docs.astro.build/en/guides/content-collections/ — fully read. Confirmed **the content config file is `src/content.config.ts`** in Astro 5+ (not the older `src/content/config.ts`), `loader`-based collections via `glob({pattern, base})` / `file({src})` from `astro/loaders`, `defineLiveCollection` in `src/live.config.ts` for runtime collections.
- https://docs.astro.build/en/reference/modules/astro-assets/ — `astro:assets` reference (cited).
- https://docs.astro.build/en/guides/images/ — fully read. Confirmed `<Image />` and `<Picture />` exported from `astro:assets`, `getImage()` for programmatic use, Sharp as default image service.
- https://docs.astro.build/en/guides/routing/ , https://docs.astro.build/en/reference/routing-reference/ — routing patterns (cited).
- https://docs.astro.build/en/concepts/islands/ — islands architecture (cited).
- https://docs.astro.build/en/guides/server-islands/ — server islands / `server:defer` (cited).
- https://docs.astro.build/en/guides/on-demand-rendering/ — `output` modes and per-page `prerender` (cited; confirmed `'hybrid'` removed in Astro 6).
- https://docs.astro.build/en/guides/deploy/ — adapter index (cited).
- **https://docs.astro.build/en/guides/styling/** — fully read 2026-05-17. Confirmed the current Tailwind guidance: for Astro 5.2+, `astro add tailwind` installs the **`@tailwindcss/vite`** Vite plugin (Tailwind v4). A separate section titled **"Legacy Tailwind 3 support"** documents installing `tailwindcss@3` together with `@astrojs/tailwind`, stating that "Installing these dependencies manually is only used for legacy Tailwind 3 compatibility, and is not required for Tailwind 4." Astro's docs do **not** use the literal word "deprecated" for `@astrojs/tailwind`; they frame it as the **legacy** path for Tailwind 3. The agent mirrors this exact framing rather than imposing a stronger stance.
- **https://tailwindcss.com/docs/installation/framework-guides/astro** — fully read 2026-05-17. Tailwind's own Astro guide recommends `npm install tailwindcss @tailwindcss/vite` and wiring `tailwindcss()` into `vite.plugins` inside `astro.config.mjs`. No mention of `@astrojs/tailwind` on this page; upstream Tailwind has fully moved on to the Vite-plugin path.
- https://docs.astro.build/en/guides/integrations-guide/mdx/ — MDX integration (cited).
- https://docs.astro.build/en/guides/framework-components/ — UI framework integrations (cited).
- https://docs.astro.build/en/guides/integrations-guide/ — integration index (cited).
- https://docs.astro.build/en/guides/upgrade-to/v6/ , https://docs.astro.build/en/guides/upgrade-to/v5/ — migration guides (cited).
- https://docs.astro.build/en/reference/error-reference/ — curated `AstroErrorCode` catalog (cited as the debug source).
- https://github.com/withastro/astro — source/issues (cited).

### Starlight

- https://starlight.astro.build/ — documentation home; structure confirmed (Start Here, Guides, Components, Reference, Resources).
- https://starlight.astro.build/getting-started/ — manual setup (cited).
- https://starlight.astro.build/reference/configuration/ — fully read. Confirmed top-level `starlight({…})` keys (title, description, logo, sidebar, locales, defaultLocale, tableOfContents, customCss, favicon, titleDelimiter, editLink, lastUpdated, pagination, social, components, plugins, expressiveCode, pagefind, head, prerender, markdown, routeMiddleware, disable404Route, credits).
- https://starlight.astro.build/reference/frontmatter/ — fully read. Confirmed frontmatter fields (title required; description, slug, editUrl, head; template `'doc'|'splash'`, hero, banner, tableOfContents; prev, next, lastUpdated; pagefind, draft; sidebar.label/order/hidden/badge/attrs).
- https://starlight.astro.build/reference/overrides/ — overrides reference (cited as the lookup target for component override questions).
- https://starlight.astro.build/guides/overriding-components/ — fully read. Confirmed override config shape (`components: { Name: './path' }`), the slot-forwarding requirement for `PageFrame`/`TwoColumnContent`.
- https://starlight.astro.build/guides/css-and-tailwind/ — Tailwind wiring guide (cited). Aligns with the Astro core stance: Tailwind v4 via `@tailwindcss/vite`; Tailwind 3 via the legacy `@astrojs/tailwind` integration.
- https://starlight.astro.build/guides/i18n/ — i18n guide (cited).
- https://starlight.astro.build/reference/plugins/ — plugin reference (cited).
- https://starlight.astro.build/reference/route-data/ — route data (cited).
- https://starlight.astro.build/components/ — built-in components (cited).
- https://starlight.astro.build/guides/authoring-content/ — page authoring features (cited).
- https://github.com/withastro/starlight — source/issues (cited).

## Volatile vs. Stable Classification

**Stable (embedded directly in the agent):**

- `.astro` component fence and template syntax. (Stable since Astro 1.)
- The `Astro` global's surface (`Astro.props`, `Astro.params`, `Astro.url`, `Astro.cookies`, `Astro.redirect`). (Stable through 4/5/6.)
- Scoped styles and scoped script defaults; `is:global`, `is:inline`, `define:vars`. (Stable.)
- Islands architecture and the client directive set (`client:load`, `client:idle`, `client:visible`, `client:media`, `client:only`). (Stable; `server:defer` for server islands added in 5, stable in 6 — noted as version-specific.)
- The mental model of file-based routing under `src/pages/`, dynamic segments `[slug]` / catch-all `[...path]`, and `getStaticPaths`. (Stable.)
- The two-way distinction `output: 'static' | 'server'` plus per-page `export const prerender`. (Settled in Astro 6 — explicitly noted as a v6 collapse from the prior `'hybrid'` option.)
- The slot model (`<slot />`, named slots, fallback content).
- The Starlight setup pattern (integration in `astro.config`, content in `src/content/docs/`, autogenerated sidebar from directories).
- The Starlight component-override mechanism (the `components` map and the slot-forwarding requirement).
- The customization escalation ladder (custom CSS tokens → overrides → frontmatter head → plugins).
- The Tailwind wiring split: `astro add tailwind` (Vite plugin, Tailwind v4) vs. the legacy `@astrojs/tailwind` integration (Tailwind v3). Framing mirrors upstream Astro docs verbatim — no stronger stance imposed.

**Volatile (always fetch from docs):**

- **All `astro.config` keys, defaults, and nested option shapes** — image, markdown, i18n, security, vite. These evolve across minors.
- **Integration option shapes** (`@astrojs/mdx`, `@astrojs/react`, `@astrojs/node`, `@astrojs/vercel`, etc.) — independent release cadence; never recall from memory.
- **Starlight option set and frontmatter fields** — Starlight is pre-1.0 (`0.39.x`) and adds/changes options frequently. Always confirm the option exists in the user's installed version.
- **Content Layer loader API shape** (`glob`, `file`, custom loader interface) — Astro 5 introduced; refined in 6.
- **Content config file location** (`src/content/config.ts` legacy → `src/content.config.ts` Astro 5+). High-frequency confusion source.
- **`astro:assets` defaults** (image service, format precedence, `image.remotePatterns` shape).
- **`output: 'hybrid'` removal** — explicit gotcha for users migrating from Astro 4.
- **Adapter-specific deploy configuration** — Vercel/Netlify/Cloudflare/Node each have their own option set.
- **Tailwind-in-Astro upstream framing** — whether `@astrojs/tailwind` shifts from "legacy" to outright "deprecated" wording. Re-verify at `https://docs.astro.build/en/guides/styling/#tailwind` and `https://tailwindcss.com/docs/installation/framework-guides/astro` on each survey.
- **Error message catalog** — fetch per-error from `https://docs.astro.build/en/reference/error-reference/`.
- **Latest stable Astro and Starlight versions** — `npm view astro version` / `npm view @astrojs/starlight version` is faster than a web fetch.

## Design Notes

A few patterns emerged that may be useful for future tech-agent authoring (or for re-surveying this agent later):

1. **Partial structural variant fits the "framework + first-class plugin" shape.** Astro core has one authoritative source (docs.astro.build); Starlight has its own (starlight.astro.build). The two have distinct option surfaces, distinct release cadences, and distinct frontmatter schemas — so sub-sectioning the Documentation Sources table and Core Concepts is necessary. But real-world tasks cross both routinely ("add a React island to a Starlight page", "augment the docs schema with custom frontmatter") — so Approach stays flat with a one-paragraph cross-cutting rule. This is the same shape as a hypothetical "Vite + Vitest" or "Next.js + Vercel adapter" agent might take.
2. **The content-config-file rename (`src/content/config.ts` → `src/content.config.ts`) is the single highest-confusion item.** Embedded explicitly in two places (Version landscape table and Content Collections section), plus called out in Approach for content-collections questions. Worth flagging when the user's repo or example uses the old path.
3. **`output: 'hybrid'` removal in v6 is a similar trap.** Embedded in the version table and in the build-mode discussion, with explicit "flag this if the user mentions it" in Approach.
4. **Starlight is pre-1.0 and ships fast.** The agent leans heavier on fetching for Starlight specifics than for Astro core, where most options have settled. Noted in the volatile section.
5. **Tailwind wiring is described, not editorialized.** Both upstream sources (Astro styling guide; Tailwind's Astro install guide) point at `@tailwindcss/vite` for Tailwind v4 and describe `@astrojs/tailwind` as the legacy path for Tailwind v3. The agent reflects that exactly — recommending `astro add tailwind` for new v4 projects while keeping the legacy path available for projects locked on Tailwind v3. The sibling `technology-tailwindcss` agent owns utility/theme questions. This pattern likely generalizes to any "X in Astro" question where X is a separately-versioned ecosystem (Tailwind, MDX-ecosystem markdown plugins, etc.).
6. **Context7 reputation gating worked well here.** Both `/websites/astro_build_en` (High, 84.77) and `/withastro/starlight` (High, 76.47) cleared the bar; lower-quality entries (`/zane-ops/docs`, `/netlify/astro-documentation-starter`) were correctly omitted. The skill's "use Context7 as the top row" guidance held.
7. **No need for a separate "in-system" top row** like Kubernetes/Nix have — Astro's CLI surface for introspection is `astro info`, `astro check`, `astro sync`, but these are workflow tools more than reference lookups. Embedded in the "In-system shortcuts" sub-list inside the sources section rather than promoted to the top of the table.
