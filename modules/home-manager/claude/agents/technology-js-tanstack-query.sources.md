# TanStack Query Technology Expert — Sources

References that informed the content in `technology-js-tanstack-query.md`. First-hand research from authoritative sources (Context7, tanstack.com/query) took priority. The TanStack docs site is React-router-driven and renders client-side, so Context7's pre-indexed snippet retrieval is the preferred path; `WebFetch` against deep links works for the guide pages used here.

## Documentation Sources Verified

| Source | Used for | Verified |
|---|---|---|
| Context7: `/websites/tanstack_query_v5` (3362 snippets, Benchmark 83.62, High reputation) | Primary library-wide lookup — `useQuery` / `useMutation` quick-start, invalidation patterns, version-pinned v5 snippet coverage | 2026-05-19 |
| Context7: `/tanstack/query` (multiple version pins available: v4.29.19, v5.60.5, v5.71.10, v5.84.1, v5.90.3) | Version-pinned source retrieval; `/tanstack/query/v5.90.3` is the most recent pinned version available at calibration time | 2026-05-19 |
| Context7: `/websites/tanstack_query` (3362 snippets, Benchmark 84.07) | Broader index across all framework adapters (React, Solid, Vue, Svelte, Angular, Preact) | 2026-05-19 |
| [tanstack.com — Query keys guide](https://tanstack.com/query/latest/docs/framework/react/guides/query-keys) | Deterministic hashing rules, object-key-order normalization, `undefined`-property stripping, array-position sensitivity, dependency principle, hierarchy patterns | 2026-05-19 |
| [tanstack.com — Migrating to v5 guide](https://tanstack.com/query/latest/docs/framework/react/guides/migrating-to-v5) | Complete v4 → v5 rename surface, removed APIs (`useQuery` callbacks, `keepPreviousData`, `remove()`, `refetchPage`), behavioral shifts (server retries 3 → 0, `null`-vs-`undefined` in `getNextPageParam`, `initialPageParam` required), single-object signature requirement, codemod availability | 2026-05-19 |
| [tanstack.com — SSR guide](https://tanstack.com/query/latest/docs/framework/react/guides/ssr) | `dehydrate` / `HydrationBoundary` pattern, `useState`-wrapped `QueryClient` instantiation rule, `staleTime > 0` requirement, framework integration outline (Next.js Pages Router, Remix) | 2026-05-19 |
| [tanstack.com — Advanced SSR guide](https://tanstack.com/query/latest/docs/framework/react/guides/advanced-ssr) | Next.js App Router patterns: per-request vs shared-via-`cache()` `QueryClient`, streaming pending queries (v5.40+), `shouldDehydrateQuery` for in-flight queries, `@tanstack/react-query-next-experimental` trade-offs, server-vs-client rendering ownership rule | 2026-05-19 |
| [tanstack.com — Optimistic updates guide](https://tanstack.com/query/latest/docs/framework/react/guides/optimistic-updates) | UI-based pattern (`mutation.variables`, `useMutationState` cross-component), cache-based pattern (`onMutate` → `cancelQueries` → `setQueryData` → snapshot → `onError` rollback → `onSettled` `invalidateQueries`), guidance on when to use which | 2026-05-19 |
| [tanstack.com — Suspense guide](https://tanstack.com/query/latest/docs/framework/react/guides/suspense) | `useSuspenseQuery` / `useSuspenseInfiniteQuery` / `useSuspenseQueries`, restrictions (no `enabled`, no `placeholderData`), default `throwOnError` predicate logic, `QueryErrorResetBoundary` reset pattern | 2026-05-19 |
| [tanstack.com — Query invalidation guide](https://tanstack.com/query/latest/docs/framework/react/guides/query-invalidation) | `invalidateQueries` filter shapes (prefix vs `exact`, `predicate`), invalidation behavior (marks stale, overrides `staleTime`, refetches active queries) | 2026-05-19 |
| [tanstack.com — Important defaults guide](https://tanstack.com/query/latest/docs/framework/react/guides/important-defaults) | Defaults table: `retry: 3`, exponential `retryDelay`, `staleTime: 0`, `gcTime: 5min`, `refetchOnMount`/`refetchOnWindowFocus`/`refetchOnReconnect` enabled for stale queries, `structuralSharing: true` | 2026-05-19 |
| [tanstack.com — QueryClient reference](https://tanstack.com/query/latest/docs/reference/QueryClient) | Complete method enumeration: `fetchQuery`, `prefetchQuery`, `ensureQueryData`, `getQueryData`, `getQueriesData`, `setQueryData`, `setQueriesData`, `invalidateQueries`, `refetchQueries`, `cancelQueries`, `removeQueries`, `resetQueries`, `clear`, `isFetching`, `isMutating`, `setDefaultOptions`, `setQueryDefaults`, `getQueryCache`, `getMutationCache` | 2026-05-19 |
| [GitHub: TanStack/query releases](https://github.com/tanstack/query/releases) | v5 release cadence verification — confirmed no v6; v5 line continues shipping (lit adapter, devtools, infinite-query refinements through 2026-05) | 2026-05-19 |
| [TanStack Blog — Announcing v5](https://tanstack.com/blog/announcing-tanstack-query-v5) | v5 framing — 20% smaller than v4, callbacks removed from `useQuery`, `cacheTime` → `gcTime`, status renames | 2026-05-19 (via WebSearch result summary) |

## Version Calibration

Calibrated against **TanStack Query v5.x** (any v5 minor). No v6 exists as of the calibration date.

- v5.0.0 was released after extensive RC cycle (91 alphas, 35 betas, 16 RCs).
- Most recent Context7-pinned version: **v5.90.3**.
- Release cadence as of 2026-05: weekly minor/patch releases (e.g. release-2026-05-08-1426, release-2026-05-03-1449, release-2026-04-25-1120). Notable recent additions on the v5 line: Lit adapter (`@tanstack/lit-query` 0.2.0, 2026-05-08), Angular devtools theme option (2026-05-03), `retryOnMount` callback support (2026-04-23).
- The agent assumes v5 by default and explicitly flags v4 differences when answering migration questions. v4 (`@tanstack/react-query@4.x`) is still common in older codebases; the rename table in Core Concepts is the recovery surface.
- Minimum runtime requirements (v5): React 18+, TypeScript 4.7+.

## Existing Agents and Skills Consulted

- **`technology-react.md` / `technology-react.sources.md` (in-repo)** — used as the **style and structure template**. Adopted: section ordering (Scope → Documentation Sources → Core Concepts → Approach → Output Format), the documentation-sources table as the central artifact, the "deep expertise + fetch-first discipline" persona frame, the version-citation rule at the end of Output Format, the practice of including a default-version assumption in the source table block. Not adopted: any React-specific content; the Compiler-status-first approach (not applicable to a runtime library).
- **`technology-nextjs.md` (in-repo)** — referenced for the App Router boundary language. The Defer-to peer-agent line for "Next.js fetch caching / RSC streaming / Server Actions" is intentionally complementary: that agent owns Next.js's data-fetching primitives; this agent owns Query's behavior when layered on top, including the Next.js-specific SSR integration patterns.
- **`skills/agent-technology/SKILL.md` (in-repo)** — followed steps 1-9 of the 9-step process. Applied the Step 6 capability-reference rule (cross-references describe peer agents by role, never by name).

## Volatile vs. Stable Classification

**Stable, embedded in agent:**
- The cache-state model (`pending` / `success` / `error` × `idle` / `fetching` / `paused`) — semantics haven't changed since the v5 status rename.
- Query-key hashing rules (object-key-order normalization, array-position significance, `undefined`-property stripping, JSON-serializable constraint). These are the foundation of cache identity and won't change without a major.
- The mutation lifecycle (`onMutate` → `onError` / `onSuccess` → `onSettled`) and the cache-snapshot optimistic-update pattern.
- The `staleTime` vs `gcTime` distinction (freshness vs retention).
- Query filter shape (`queryKey`, `exact`, `predicate`, `type`, `stale`, `fetchStatus`).
- The three-phase SSR pattern (prefetch → dehydrate → hydrate) and the `useState`-wrapped `QueryClient` rule.
- The Suspense-hook restrictions (no `enabled`, no `placeholderData`, default `throwOnError` predicate).
- The v4 → v5 rename table — once v5 shipped these renames are historical fact; embedded as a reference.
- The `mutate` vs `mutateAsync` error-handling distinction (one of the most common foot-guns).
- The query-key-shape-stability discipline for data-source migrations (BFB-specific load-bearing concept per the authoring directive).

**Volatile, always fetch:**
- Exact default values (`retry: 3`, `gcTime: 5min`, etc.) — fetch the Important Defaults page if the user pins behavior on a default.
- Exact hook return shapes and option lists — fetch the per-hook reference page for any "what fields are on the return?" question.
- `QueryClient` method signatures and option overloads — fetch the QueryClient reference page for exact parameter types.
- Anything related to streaming SSR / RSC integration — moves fast (v5.40+ shipped pending-query dehydration; `@tanstack/react-query-next-experimental` is still experimental).
- Persistence plugins (`@tanstack/query-persist-client-core`, etc.) — sub-package API surface; fetch the relevant guide.
- Devtools options (`buttonPosition`, `initialIsOpen`, theme support) — additions on the v5 line.
- ESLint plugin rule names (`@tanstack/eslint-plugin-query`) — adds rules over time.
- Codemod invocations for v4 → v5 migration — verify the current command before recommending.
- Adapter-specific ergonomics (Solid `createQuery`, Vue `useQuery` composition, Svelte `createQuery` stores, Angular `injectQuery`) — defer to the per-adapter docs.

## Design Notes

Patterns surfaced while authoring this agent that may benefit future technology agents in this repo:

1. **Query-key shape stability deserves its own subsection for any cache-keyed library.** TanStack Query's hash-equality model is the load-bearing concept for cache identity, and the rules are subtle (object-key-order normalized, array-position significant, `undefined` stripped, type drift breaks matches). Anything else with deterministic-hash cache identity (SWR keys, Apollo cache-id functions, React Cache memoization) likely warrants the same treatment — embed the rules in Core Concepts, then dedicate an Approach branch to "audit this key shape" tasks. The user's BFB data-source migration use case made this load-bearing per the authoring directive.

2. **The v4 → v5 rename table is a high-leverage embedded artifact.** TanStack Query's v5 release renamed enough APIs that any LLM trained on pre-v5 content will produce stale answers by default. Embedding the rename table directly in Core Concepts (as a Markdown table, not prose) made it scannable and gave the Approach section a place to point users for "upgrade this code" questions. Recommend the same pattern for any technology with a recent major-version rename: `cacheTime` → `gcTime`, `isLoading` → `isPending`, `<Hydrate>` → `<HydrationBoundary>`, callback removal, single-object signature. Pre-emptive rename tables reduce time-to-correct-answer dramatically.

3. **Two-axis status (`status` × `fetchStatus`) is a recurring source of "but I thought it was loading" confusion.** Embedded the explicit cross-product (success + fetching = background refetch; pending + fetching = first load; success + idle = fresh-from-cache no refetch). Any library with orthogonal state machines (Apollo's `loading` / `networkStatus`, Redux Toolkit Query's `isLoading` / `isFetching`) likely benefits from the same explicit cross-product table.

4. **"Defer to a framework specialist" boundary is genuinely tricky for libraries that layer on top of frameworks.** TanStack Query sits on top of React, Next.js, Solid, Vue, Svelte, Angular, Lit. The Scope section explicitly distinguishes "Query's behavior" from "the framework's primitives that compete or compose" — e.g. Next.js `fetch` caching vs Query, Remix `loader` vs Query prefetch. Recommend the same explicit-boundary approach for any library agent (state libs, form libs, animation libs) where the framework integration surface is the most common confusion.

5. **Context7's two-tier indexing (`/websites/<name>_v5` for guide content, `/tanstack/query/v5.90.3` for source-pinned)** mirrors the React pattern from this repo's earlier agents. Confirmed it works the same way here — listed both in the sources table with explicit "use this one for X" guidance.

6. **The TanStack docs site renders client-side via React Router.** Direct `WebFetch` against deep links *did* return substantive content for the guide pages used here (query-keys, migrating-to-v5, ssr, optimistic-updates, suspense, important-defaults), but the `/docs/reference/QueryClient` URL returned `{"isNotFound":true}` — likely a routing edge case. Future re-surveys should prefer Context7 as primary and fall back to WebFetch only for specific guide URLs.
