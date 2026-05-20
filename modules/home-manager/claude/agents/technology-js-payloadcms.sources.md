# Payload CMS Technology Expert — Sources

References that informed `technology-payloadcms.md`. Prioritizes Context7 (live-indexed against the GitHub docs source at a pinned version) and the official `payloadcms.com/docs` site over community material.

## Version Calibration

- **Payload version pinned**: **v3.84.x** (Context7 indexed at `/payloadcms/payload/v3.84.0`; npm latest reported as `3.84.1` as of confirmation).
- **Date confirmed**: 2026-05-16.
- **Major-version line**: v3 (Next.js-native architecture). v2 (Express + Webpack) is legacy; v2 → v3 migration is covered in scope but the agent's primary calibration is v3.
- **Database adapter packages** confirmed at the same version: `@payloadcms/db-mongodb`, `@payloadcms/db-postgres`, `@payloadcms/db-sqlite`.
- **Lexical editor** package: `@payloadcms/richtext-lexical` (default v3 rich text editor; Slate is legacy).

## Existing Agents and Skills Consulted

- **VoltAgent `awesome-claude-code-subagents`** (https://github.com/VoltAgent/awesome-claude-code-subagents) — cross-checked for prior Payload art. **Result: no Payload-specific subagent exists** in the collection (131+ agents across 10 categories; the closest CMS adjacency is `wordpress-master`). Nothing adopted; nothing to deconflict.
- **Repo-local style reference**: `technology-nix.md` and `technology-nix.sources.md` in the same agents directory. Adopted only for tone, section ordering (Scope → Sources → Core Concepts → Approach → Output Format), and the persona frame (deep expertise + fetch-first discipline). Content is independently authored from primary sources.
- **Payload's own `tools/claude-plugin/skills/payload/`** in the GitHub source tree — Payload ships its own Claude plugin/skill set (under `tools/claude-plugin/skills/payload/reference/{HOOKS,FIELDS,ACCESS-CONTROL-ADVANCED,ADAPTERS,ADVANCED,PLUGIN-DEVELOPMENT,COLLECTIONS}.md`). Surfaced via Context7 search; treated as primary first-party reference material rather than community content, and cross-checked against the canonical docs.

## Primary Sources

### Context7 (primary lookup channel)

- **`/payloadcms/payload`** — High source reputation, benchmark 82.1, 2,279 code snippets, versioned (`v2.12.1` through `v3.84.0` available). Indexes both `docs/` and `tools/claude-plugin/skills/payload/reference/` from the GitHub source tree. **The agent's preferred runtime lookup path**: `mcp__context7__query-docs` with `libraryId: /payloadcms/payload/v3.84.0`.
- Alternative IDs noted but not preferred: `/llmstxt/payloadcms_llms-full_txt` (no version pinning), `/payloadcms/website` (marketing site), `/websites/payloadcms` (lower benchmark).

### Official Documentation (verified at v3.84.0)

URL structure confirmed by enumerating `https://api.github.com/repos/payloadcms/payload/contents/docs?ref=v3.84.0`. Top-level sections present: `access-control`, `admin`, `authentication`, `configuration`, `custom-components`, `database`, `ecommerce`, `email`, `examples`, `fields`, `folders`, `getting-started`, `graphql`, `hooks`, `integrations`, `jobs-queue`, `live-preview`, `local-api`, `migration-guide`, `performance`, `plugins`, `production`, `queries`, `query-presets`, `rest-api`, `rich-text`, `trash`, `troubleshooting`, `typescript`, `upload`, `versions`.

The corresponding live docs map to `https://payloadcms.com/docs/<section>/<page>`. Note: the live site rate-limits aggressive scraping (returned 429 during authoring); the GitHub `docs/` source is the same content and is the better fallback for automated fetching.

- [Payload Docs — Getting Started / Installation](https://payloadcms.com/docs/getting-started/installation) (GitHub mirror: `docs/getting-started/installation.mdx`) — Next.js app structure, `withPayload` wrapping, app router route groups.
- [Configuration Overview](https://payloadcms.com/docs/configuration/overview) — `buildConfig` shape, top-level keys.
- [Collections](https://payloadcms.com/docs/configuration/collections), [Globals](https://payloadcms.com/docs/configuration/globals), [Localization](https://payloadcms.com/docs/configuration/localization).
- [Fields — Overview](https://payloadcms.com/docs/fields/overview) and per-type pages (`/fields/text`, `/fields/relationship`, `/fields/blocks`, `/fields/array`, `/fields/upload`, `/fields/group`, `/fields/tabs`, `/fields/row`, `/fields/collapsible`, `/fields/ui`, `/fields/join`, `/fields/code`, `/fields/json`, `/fields/point`, `/fields/select`, `/fields/radio`, `/fields/date`, `/fields/checkbox`, `/fields/number`, `/fields/email`, `/fields/textarea`, `/fields/richtext`).
- [Hooks Overview](https://payloadcms.com/docs/hooks/overview) — collection, global, field, and auth hooks. Lifecycle ordering for change/read/delete operations.
- [Access Control Overview](https://payloadcms.com/docs/access-control/overview) — argument shape `{ req, id?, data? }`, per-operation functions, `Where`-return filtered reads.
- [Authentication Overview](https://payloadcms.com/docs/authentication/overview) and `/authentication/operations`, `/authentication/jwt`, `/authentication/cookies`, `/authentication/strategies`.
- [Local API](https://payloadcms.com/docs/local-api/overview), [REST API](https://payloadcms.com/docs/rest-api/overview), [GraphQL](https://payloadcms.com/docs/graphql/overview).
- [Custom Components](https://payloadcms.com/docs/custom-components/overview), [Admin Overview](https://payloadcms.com/docs/admin/overview) — slot tree, `admin.components.*`, RSC vs client component contracts, `admin.dependencies` import map.
- [Database Overview](https://payloadcms.com/docs/database/overview) and adapter sub-pages for MongoDB/Postgres/SQLite. Migrations: `/database/migrations`.
- [Upload Overview](https://payloadcms.com/docs/upload/overview), [Storage Adapters](https://payloadcms.com/docs/upload/storage-adapters).
- [Versions Overview](https://payloadcms.com/docs/versions/overview), `/versions/autosave`, `/versions/drafts`.
- [Live Preview Overview](https://payloadcms.com/docs/live-preview/overview).
- [Jobs Queue Overview](https://payloadcms.com/docs/jobs-queue/overview), `/jobs-queue/tasks`, `/jobs-queue/queues`, `/jobs-queue/quick-start-example`.
- [Plugins Overview](https://payloadcms.com/docs/plugins/overview) and per-plugin sub-pages (seo, redirects, form-builder, search, nested-docs, multi-tenant, sentry, stripe, import-export).
- [Rich Text Overview (Lexical)](https://payloadcms.com/docs/rich-text/overview), `/rich-text/blocks`, `/rich-text/converting-html`, `/rich-text/converting-jsx`, `/rich-text/converting-markdown`.
- [Migration Guide](https://payloadcms.com/docs/migration-guide/overview) — v2 → v3.
- [TypeScript](https://payloadcms.com/docs/typescript/overview) — `payload-types.ts` generation.
- [Trash](https://payloadcms.com/docs/trash/overview) — stable as of late 3.x, includes trash-aware delete access control.
- [Production / Deployment](https://payloadcms.com/docs/production/deployment).
- [Queries Overview](https://payloadcms.com/docs/queries/overview) — `where` operators, pagination, sort.

### Source and Release Channels

- [payloadcms/payload GitHub repository](https://github.com/payloadcms/payload) — pnpm monorepo. Useful packages to read for source-level questions: `packages/payload/src` (core), `packages/db-mongodb`, `packages/db-postgres`, `packages/db-sqlite`, `packages/richtext-lexical`, `packages/next`, `packages/ui`, `packages/plugin-*`. Repo-root `CLAUDE.md` confirms the v3 architecture: "Payload 3.x is designed as a Next.js native CMS, integrating directly into the `/app` folder. Its UI is built using React Server Components (RSC), and database adapters leverage Drizzle ORM."
- [Releases page](https://github.com/payloadcms/payload/releases) — canonical changelog. Used to confirm 3.84.1 as latest stable at time of authoring.
- [npm — payload](https://www.npmjs.com/package/payload) — version verification.
- [Payload Release Notes blog](https://payloadcms.com/posts/releases) — narrative release notes.

### Community / Secondary

- [Payload Discord and Community Help](https://payloadcms.com/community-help) — referenced for community-discovered patterns where official docs are thin.
- [Payload Cloud](https://payloadcms.com/cloud) — first-party hosting; relevant to deployment but defers to DevOps for infra concerns.

## Volatile vs. Stable Classification

**Embedded (stable across v3.x — unlikely to change without a major)**:

- The v3 paradigm (Next.js-native, RSC admin, `withPayload`).
- High-level config shape (`buildConfig` top-level keys; the existence of collections/globals/admin/db/plugins/jobs).
- The collection lifecycle ordering (beforeOperation → beforeValidate → beforeChange → afterChange → afterOperation).
- Access control function shape (`{ req, id?, data? }` → boolean | Where).
- Database adapter trade-offs (Mongo schemaless vs Drizzle relational + migrations).
- The three-API model (Local > REST/GraphQL).
- Field type catalog at the *category* level (text/select/relationship/upload/array/blocks/group/tabs/row/collapsible/ui/join/richText).
- The Lexical-by-default decision; the existence of `convertLexicalTo{HTML,JSX,Markdown}` converters.
- v2 → v3 breaking change categories (bundler gone, Express gone, Slate→Lexical, imports moved).

**Always fetch (volatile — version-sensitive)**:

- Specific field option names and types (e.g. exact `admin.condition` signature, exact `imageSizes` properties).
- Exact hook handler destructured arg shape per hook (varies; e.g. `beforeChange` differs from `beforeRead` differs from `afterOperation`).
- Plugin option APIs (these move between plugin minor versions).
- Lexical feature names and signatures (`BlocksFeature`, `LinkFeature`, `UploadFeature`, converter shapes — known to evolve).
- `admin.components.*` slot tree (slot keys added regularly).
- CLI flags for `pnpm payload <command>`.
- Storage adapter option shapes (S3, Vercel Blob, etc.).
- Migration CLI semantics (`migrate:fresh` vs `migrate:refresh` vs `migrate:down`).
- Jobs queue API (relatively new; surface still maturing — `schedule`, `autoRun`, `--handle-schedules` flag).
- Auth strategy interface for custom strategies.

## Design Notes

- **Lead with the paradigm shift.** Payload v3's distinguishing feature versus v2 (and versus most CMS competitors) is that it *is* a Next.js app, not a separate backend. This deserves first billing in Core Concepts because nearly every other v3 design choice (RSC admin, route groups, `withPayload`, the death of the bundler/Express layers, `getPayload({ config })` instead of starting a server) flows from it. Burying this would mislead users coming from v2 mental models.
- **First-party "Claude plugin" skills as a resource.** Payload ships `tools/claude-plugin/skills/payload/reference/` in the source tree (HOOKS, FIELDS, ACCESS-CONTROL-ADVANCED, ADAPTERS, PLUGIN-DEVELOPMENT, COLLECTIONS, ADVANCED). Context7 indexes these and they're a high-quality reference written specifically for LLM consumption — better than scraping rendered docs in many cases. Worth treating as first-party material.
- **Three-API hierarchy is decision-relevant.** Users new to Payload often default to REST out of habit. The agent should actively steer server-side code toward the Local API (no HTTP overhead, in-process, hooks/access still honored). This recommendation is embedded in the Approach section.
- **Adapter divergence matters.** Mongo and the Drizzle (Postgres/SQLite) adapters expose the same Payload API but have materially different operational characteristics (schemaless vs migrations-required, embedded arrays vs join tables). Answers to questions like "how do I add a field?" or "why is this query slow?" depend on the adapter; the agent should always pin the answer to one.
- **Context7 versioning is a real advantage.** Because Context7 exposes per-version libraryIds (e.g. `/payloadcms/payload/v3.79.1`), the agent can give version-correct answers when the user states their version. This is meaningfully better than scraping `payloadcms.com/docs` (which serves only the latest). The agent's Documentation Sources section makes Context7 the top row deliberately, with the URL list as the human-narrative fallback.
- **Defer-to-Next.js boundary needs to be policed.** Many "Payload" questions are really Next.js questions (caching, RSC vs client rules, middleware, deployment). The Scope section names this explicitly and the Approach section names a defer trigger so the agent doesn't drift into Next.js territory it shouldn't own.
