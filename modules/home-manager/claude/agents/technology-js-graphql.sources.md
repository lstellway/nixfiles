# GraphQL Technology Expert — Sources

References that informed the content in `technology-graphql.md`. First-hand research from authoritative sources (spec.graphql.org, the-guild.dev, wpgraphql.com, and Context7) was prioritized; existing peer agents were consulted only for "Defer to" boundary calibration.

## Version Calibration

**Calibrated 2026-05-17.** This agent is general-purpose and reusable across projects. Versions noted here describe the current stable lines the agent's embedded examples and recommendations target — not the version any specific project pins.

- **GraphQL specification**: latest dated edition is **September 2025** (continuous-publication model, replacing the long-stable October 2021 edition as the de facto reference). Working draft tracks `main` of `graphql/graphql-spec`. Both editions are cited from the agent — September 2025 as the default and October 2021 as the long-stable fallback because many production servers still target it.
- **graphql-codegen**: `@graphql-codegen/cli` v6 is the current major line (per the v5→v6 migration docs); v5 is still common in older projects and surfaces in migration contexts. The `client` preset is on the same v6 cadence.
- **graphql (npm) — reference implementation**: v16 is the current major line of `graphql-js` and has been the stable reference for several years. Cite v16 behavior by default; earlier majors are unlikely to be encountered.
- **WPGraphQL**: `/wp-graphql/wp-graphql` on Context7 (Source Reputation: High, Benchmark Score: 82.2, 2,159 snippets). Plugin's own version cadence runs on the WordPress.org plugin directory; the API surface in the schema is stable, the PHP plugin internals are the volatile axis (handled by `technology-wordpress.md`).
- **Framework-embedded GraphQL surfaces** (PayloadCMS, Hasura, PostGraphile, Strapi, etc.) — version-specific schema mapping and access control defer to the framework's own agent.

Exact "latest" for any tool is best verified via `npm view <pkg> version` (or the equivalent) at the point of use; embedded version numbers in the agent are deliberately scoped to current major lines, not patch versions.

## Existing Agents / Skills Consulted

Peer agents reviewed for tone and "Defer to" reference (no content adopted):

- **`technology-nextjs.md`** — structural template (frontmatter, Scope/Sources/Concepts/Approach/Output sections, version landscape table, fetch-first instinct, table-driven sources). The version-landscape pattern was adapted into the "Spec edition landscape" table.
- **`technology-payloadcms.md`** — confirmed the "Defer to" block formatting and the practice of pointing users to specific peer agents by name with explicit hand-off rules. Used to write the framework-embedded GraphQL defer rules.
- **`technology-wordpress.md`** — confirmed the WordPress agent owns PHP-side `register_graphql_*` calls; used to set the WPGraphQL boundary cleanly (the GraphQL surface stays here; the PHP plugin internals defer there).
- **`software-api-design.md`** — confirmed it owns REST-vs-GraphQL tradeoffs, mutation-return-shape review, breaking-change classification; used to write the API-design defer rule.
- **`software-performance.md`** — confirmed it owns N+1 detection and DataLoader implementation specifics with measurement; used to keep this agent's DataLoader section conceptual.
- **`software-security.md`** — confirmed it owns auth on fields, depth/cost limit thresholds, threat modeling; used to write the security defer rule.

**Community indexes**: not consulted for this agent. VoltAgent `awesome-claude-code-subagents` was noted as a sanity-check source by the skill but the existing in-repo peer agents gave a stronger structural reference than any community persona would.

## Documentation Sources Verified

### Verified accessible

- **Context7 `/graphql/graphql-spec`** — resolved, High reputation, 1,053 snippets. (`mcp__context7__resolve-library-id`)
- **Context7 `/graphql/graphql.github.io`** — resolved, High reputation, 730 snippets.
- **Context7 `/graphql/graphql-js`** — resolved, High reputation, Benchmark 84.95, 777 snippets.
- **Context7 `/dotansimha/graphql-code-generator`** — resolved, High reputation, Benchmark 78.8, 738 snippets. Queried for `codegen.ts` config — confirmed both the canonical `client` preset shape and the classic `typescript` + `typescript-operations` + `typed-document-node` trio example.
- **Context7 `/websites/the-guild_dev_graphql_codegen`** — resolved, High reputation, Benchmark 82.75, 2,614 snippets (broader index). Listed as fallback when the `/dotansimha/...` index doesn't surface a topic.
- **Context7 `/wp-graphql/wp-graphql`** — resolved, High reputation, Benchmark 82.2, 2,159 snippets. Queried for "connections edges nodes pagination MediaItem custom post types" — confirmed the `nodes` vs `edges` distinction and connection conventions used in Core Concepts.
- **`https://github.com/graphql/graphql-spec`** (via WebFetch) — confirmed September 2025 is the most recent dated edition under the new continuous-publication model; working draft URL is `https://spec.graphql.org/draft/`; spec section list is Type System, Query Language, Validation, Execution, Introspection, Response Format.
- **`https://www.wpgraphql.com/docs/introduction`** (via WebFetch) — confirmed the public docs structure: Getting Started, Beginner Guides, Using WPGraphQL (Posts/Pages/CPT, Categories/Tags/Custom Taxonomies, Media, Users/Comments/Menus), Advanced Topics (Connections, Default Types, Custom Resolvers, Auth, Performance, Security, Hierarchical Data), Developer Reference (Actions, Filters, Functions).
- **`https://the-guild.dev/graphql/codegen/docs/getting-started`** (via WebFetch) — confirmed canonical `codegen.ts` config shape and existence of v5→v6 migration guides.

### Returned 403 to WebFetch (use Context7 or alternate)

- `https://spec.graphql.org/` — returned 403 to WebFetch. The dated permalinks (e.g., `/October2021/`, `/September2025/`) also returned 403 in testing. The spec content is reliably accessible via Context7 (`/graphql/graphql-spec`) and the canonical text is also in the `graphql/graphql-spec` GitHub repo at `/spec`. **Marked in the agent's Documentation Sources table that Context7 is the preferred path for spec text retrieval.**
- `https://graphql.org/learn/` and `/learn/queries/` — returned 403 to WebFetch. The graphql.org site appears to gate non-JS clients. Context7 (`/graphql/graphql.github.io`) is the working alternative; URLs are still in the table for human reference.
- `https://www.wpgraphql.com/` (root) — 403 to WebFetch, but `/docs/introduction` worked. Doc subpages appear navigable individually.

**Authoring takeaway**: for any future re-survey, expect to hit the spec and graphql.org through Context7 rather than WebFetch. The agent prompt does not need to call this out (the table already lists Context7 as the primary spec source); the sources file records it so a re-survey doesn't burn cycles on dead WebFetches.

## Volatile vs. Stable Classification

**Stable (embedded directly in the agent):**

- **SDL syntax fundamentals**: scalar / type / interface / union / input / enum / directive definitions, list and non-null modifiers, schema extension via `extend type`. Stable across all spec editions back to the original 2015 working draft.
- **Query language fundamentals**: operations, fragments (named and inline), variables with `$name: Type` syntax, aliases, the built-in `@include` / `@skip` / `@deprecated` directives. Stable.
- **Resolver signature**: `(parent, args, context, info)`. Stable; cross-implementation universal.
- **Mutations serial / queries parallel** execution rule. Stable; spec-mandated.
- **Errors as a sibling array, partial data legal, `extensions` on error objects**. Stable.
- **Relay-style connection shape**: `edges { cursor node { … } } pageInfo { hasNextPage endCursor … }`. Stable convention; WPGraphQL and many other servers use it verbatim.
- **N+1 problem and DataLoader concept**. Pattern is stable; implementation defers to the runtime.
- **WPGraphQL `nodes` vs `edges` access pattern**. Stable WPGraphQL convention.
- **The client preset codegen config shape**. Stable enough to embed as the canonical reference example.
- **The classic trio codegen config shape** (`typescript` + `typescript-operations` + `typed-document-node`). Stable; embedded as the legacy/still-supported alternative.

**Volatile (always fetch from docs):**

- **Specific spec edition behavior** — September 2025 vs October 2021 vs working draft. Cite the edition for any behavior question. `@defer` / `@stream` are not in the September 2025 edition; do not assume they are.
- **graphql-codegen plugin options** — `preResolveTypes`, `flattenGeneratedTypes`, `onlyOperationTypes`, `exportFragmentSpreadSubTypes`, etc. — change across plugin versions. Always fetch the plugin's `the-guild.dev` page or Context7 entry.
- **graphql-codegen client preset internals** — what files it emits, fragment masking on/off toggle, preset config keys — verify per-version.
- **WPGraphQL connection `where` argument shapes** — per-connection, generated from the WordPress data model + any installed plugin extensions. Always introspect or fetch.
- **WPGraphQL schema content** — what types/fields exist at all is gated by which CPTs/plugins are registered with `show_in_graphql`; the PHP-side answer defers to `technology-wordpress.md`.
- **Framework-embedded GraphQL schema mapping** — defers to the framework's agent (e.g., `technology-payloadcms.md`) for which field types produce which GraphQL types.
- **Latest tool versions** — verify via `npm view <pkg> version` (e.g., `npm view graphql version`, `npm view @graphql-codegen/cli version`).

## Structural Variant Choice

**Partial variant chosen.**

Justification:

- The technology spans clearly distinct sub-sources: the **spec** (spec.graphql.org), the **canonical reference implementation** (graphql-js), the **canonical codegen tool** (graphql-codegen at the-guild.dev), **WPGraphQL** (a major industry GraphQL surface for WordPress headless work), and **framework-embedded GraphQL surfaces** (PayloadCMS, Hasura, PostGraphile, Strapi). The Documentation Sources table is sub-sectioned to reflect that.
- Core Concepts is sub-sectioned correspondingly: spec edition landscape, SDL, query language, connections, resolver model, N+1/DataLoader, codegen (client preset and classic trio), WPGraphQL specifics, framework-embedded surfaces. This grouping helps a reader scan to the right area.
- But Approach stays **flat** — real-world tasks routinely cross sub-domains (a WPGraphQL connection question is also a codegen typing question is also a spec connections question), and a single decision tree generalizes better than four parallel ones.

A **full** variant was considered (split spec / graphql-js / codegen / WPGraphQL into four sub-domains with their own approach paragraphs). Rejected because:

- The most common questions will be tooling questions ("how do I configure codegen for this query", "why does WPGraphQL return null here") that naturally span sub-domains.
- The spec/language fundamentals are short enough to embed in one Core Concepts block; splitting them out into per-sub-domain sections would duplicate them or scatter the canonical SDL/query reference across multiple headings.
- Approach decisions branch by **task type** (lookup, debug, author, version question), not by sub-domain — the partial structure captures this correctly.

A **flat** variant was also considered. Rejected because the sources genuinely are distinct repos and orgs with different conventions; sub-sectioning the table avoids a 30-row flat table that's harder to navigate.

## Design Notes

Patterns worth noting for future technology-agent authoring:

1. **For spec-based technologies under continuous publication, list both the current dated edition and the long-stable previous edition.** GraphQL moved to continuous publication in 2025, but many production servers still target October 2021. Citing only the latest is misleading; an "editions landscape" table (analogous to the Next.js version-landscape table) gives the agent a fast triage path before fetching.
2. **Lead with the maintainer-recommended default; demote the legacy option without omitting it.** For graphql-codegen, the client preset is The Guild's current recommendation for new projects; the classic trio (`typescript` + `typescript-operations` + `typed-document-node`) remains fully supported and common in existing codebases. The agent embeds the client preset as the canonical example and documents the classic trio with explicit guidance on when teams stay on it (existing projects, framework constraints, no fragment masking desired). This framing generalizes for other "modern vs legacy but supported" tooling splits.
3. **For technologies with two canonical surfaces (a spec and an implementation; or a query language and a code generator), the "spec vs implementation" framing the skill mentions for Docker generalizes well.** Here, the spec is canonical for portable behavior, graphql-js is the reference for ambiguous cases, and tooling like codegen lives one layer up. The agent calls this out by listing them as separate primary sources with a clear hierarchy.
4. **When sibling agents own clearly bordered chunks of an ecosystem, link to them by name in the Scope's "Defer to" block AND repeat the link inline in the relevant Core Concepts subsection.** This agent does this for PayloadCMS (Core Concepts mentions "defer to `technology-payloadcms.md`" inside the framework-embedded subsection itself, not just in the Scope block). Makes the boundary visible at the point of use, not just at the top of the file.
5. **403s from doc sites are a real authoring obstacle and worth recording in the sources file**, not just compensated for silently. The next author re-surveying this agent shouldn't have to rediscover that `spec.graphql.org` and `graphql.org/learn/` block WebFetch — they should read it here and route to Context7 immediately.
6. **Keep examples neutral when authoring a general-purpose agent.** Embedded SDL examples use a generic `Post`/`User` schema rather than any product-specific domain. WPGraphQL coverage stays because WPGraphQL is a major industry tool for WordPress headless work, not because of any specific consumer; framework-embedded GraphQL coverage is generalized across PayloadCMS, Hasura, PostGraphile, and Strapi rather than singling out one.
