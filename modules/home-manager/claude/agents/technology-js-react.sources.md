# React Technology Expert — Sources

References that informed the content in `technology-react.md`. Per the authoring directive, first-hand research from authoritative sources (Context7, react.dev) took priority over pre-existing agent definitions; community resources are noted only where they fill gaps not covered officially or were used as a last-resort sanity check.

## Documentation Sources Verified

| Source | Used for | Verified |
|---|---|---|
| Context7: `/websites/react_dev_reference_react` (Benchmark 91.82, 1039 snippets) | Primary library-wide lookup — hook surface, top-level APIs, Suspense, Error Boundary, Portal, `use`, `useOptimistic`, `useActionState` examples | 2026-05-16 |
| Context7: `/facebook/react/v19_2_0` (versioned source + changelog) | React 19 breaking-change list, ref-as-prop source-level confirmation, `useActionState` example, JSX Transform requirement | 2026-05-16 |
| [react.dev — Reference: APIs](https://react.dev/reference/react/apis) | Top-level non-hook/non-component exports: `memo`, `lazy`, `createContext`, `startTransition`, `act`, `use`, `cache` | 2026-05-16 |
| [react.dev — Reference: Hooks](https://react.dev/reference/react/hooks) | Complete built-in hook enumeration by category (State, Context, Ref, Effect, Performance, Other) | 2026-05-16 |
| [react.dev — useActionState](https://react.dev/reference/react/useActionState) | Signature, params, return tuple, relationship to `useFormStatus` / `useOptimistic` / form `action` prop | 2026-05-16 |
| [react.dev — useOptimistic](https://react.dev/reference/react/useOptimistic) | Signature, canonical pending-UI example, exporting package (`react`) | 2026-05-16 |
| [react.dev — useFormStatus](https://react.dev/reference/react-dom/hooks/useFormStatus) | Confirmed export from `react-dom` (not `react`), return object shape, parent-form scoping rule | 2026-05-16 |
| [react.dev — React 19.2 blog post](https://react.dev/blog/2025/10/01/react-19-2) | Release date (Oct 1 2025), `<Activity>`, `useEffectEvent`, `cacheSignal`, SSR Suspense batching, `useId` prefix change `:r:` → `_r_`, Web Streams in Node, Performance Tracks, `eslint-plugin-react-hooks` v6 | 2026-05-16 |
| [react.dev — Learn: React Compiler](https://react.dev/learn/react-compiler) | Compiler role, replaces manual `useMemo`/`useCallback`/`memo`, incremental adoption via `"use memo"` / `"use no memo"` | 2026-05-16 |
| [react.dev — Versions](https://react.dev/versions) | Version history / EOL lookup URL | 2026-05-16 (URL noted, not deep-fetched) |
| [react.dev — Reference: react](https://react.dev/reference/react) | Top-level index of `react` package — sectioning informed the agent's API categorization | 2026-05-16 |
| [facebook/react CHANGELOG (main branch)](https://github.com/facebook/react/blob/main/react/CHANGELOG.md) (via Context7) | React 19 removals: `propTypes`, `defaultProps`, string refs, `contextTypes`, `ReactDOM.render`/`hydrate`, `findDOMNode`, `forwardRef` optionality, JSX Transform requirement, `react-dom/test-utils` removal | 2026-05-16 |

## Version Calibration

Calibrated against **React 19.2.x** — the latest stable line as of authoring.

- React 19.2.0 released **2025-10-01**.
- Latest patch reported as **19.2.6** (released May 2026; per VersionLog / eosl.date).
- The agent assumes React 19 / 19.2 by default and explicitly notes which APIs require which line (`use`, `useActionState`, `useFormStatus`, `useOptimistic`, ref-as-prop, Actions = 19.0; `useEffectEvent`, `<Activity>`, `cacheSignal`, batched SSR Suspense, `_r_` `useId` prefix, eslint-plugin-react-hooks v6 = 19.2).
- React 18.x is still common in the wild — the agent's hook table notes 19/19.2 additions explicitly so a user on 18 can identify which suggestions need a backport or upgrade.
- React 17 and earlier are not in scope; the agent will redirect users to upgrade rather than author against legacy APIs.

## Existing Agents and Skills Consulted

- **`technology-nix.md` / `technology-nix.sources.md` (in-repo)** — used as the **style and structure template only**. Adopted: section ordering (Scope → Documentation Sources → Core Concepts → Approach → Output Format), the documentation-sources table as the central artifact, the "deep expertise + fetch-first discipline" persona frame, the version-citation discipline at the end of Output Format. Not adopted: any Nix-specific content.
- **[VoltAgent/awesome-claude-code-subagents — react-specialist.md](https://github.com/VoltAgent/awesome-claude-code-subagents/blob/main/categories/02-language-specialists/react-specialist.md)** — checked **last** as a sanity pass per the authoring directive. The VoltAgent agent leans heavily on prescriptive workflow phases, checklists, JSON communication protocols, and broad ecosystem catalogs (state management options, SSR frameworks, testing stacks). Not adopted: workflow checklists, JSON communication protocol, ecosystem catalogs that span outside React itself (state libs, build tooling, testing). These categories belong to peer agents (Next.js, framework specialists) per this repo's `Defer to peer agents` convention. Confirmed I had not missed an obvious category — the React-internal hook/concurrent/Suspense/Actions surface is fully covered.
- **`skills/agent-technology/SKILL.md` (in-repo)** — followed steps 1-9 of the 9-step process, with the user's explicit overrides on Step 1 (Context7 promoted to primary, VoltAgent demoted to sanity check).

## Volatile vs. Stable Classification

**Stable, embedded in agent:**
- Rules of Hooks (haven't changed since hooks shipped in 16.8).
- Function-component model, JSX semantics, PascalCase rule, render purity.
- Hook categorization (State / Context / Ref / Effect / Performance / Other / Resource / Actions) — the categorization scheme is stable even when individual hooks are added.
- The `react` vs. `react-dom` boundary — which package owns `useFormStatus`, `createPortal`, `createRoot`, `flushSync`. Historically a common point of confusion.
- Suspense semantics, Error Boundary class-component requirement, Portal event-bubbling behavior, Context provider pitfalls (wide re-renders, default-value-is-fallback).
- Composition patterns (children, slots, render props, compound components, HOCs).
- Concurrent rendering primitives — `useTransition` and `useDeferredValue` semantics stable since 18.

**Volatile, always fetch:**
- Exact hook signatures and parameter types — fetch the per-symbol reference page.
- Anything introduced in React 19 or 19.2 (`use`, `useActionState`, `useOptimistic`, `useFormStatus`, ref-as-prop, Actions, form `action` prop, `useEffectEvent`, `<Activity>`, `cacheSignal`, partial pre-rendering, `useId` prefix).
- React Compiler configuration — fetch https://react.dev/reference/react-compiler/configuration before recommending setup; the plugin / build-tool integration is moving fast.
- `eslint-plugin-react-hooks` configuration — flat-config defaults changed in v6 (19.2).
- `react-dom` server APIs (`renderToReadableStream`, `prerender`, `resume`) — these gained Node Web Streams support in 19.2.
- TypeScript types for ref-as-prop — type ergonomics around `Ref<T>` vs `RefObject<T>` continue to evolve; fetch before authoring complex generic component types.

## Design Notes

Patterns surfaced while authoring this agent that may benefit future technology agents in this repo:

1. **`<library>` vs `<library>-dom` / `<library>-router` package boundaries are a recurring source of "which package does X come from" confusion.** Worth calling out explicitly in the Core Concepts section. Done here as the dedicated "`react-dom` boundary" subsection — recommend the same approach for any technology with multi-package surface area (e.g. Next.js core vs `next/navigation` vs `next/headers`).

2. **Version-introduction tagging is more valuable than version-pinned docs URLs alone.** Because React's hook surface grew through 16.8, 17, 18, 19, and 19.2, every API mention in the agent has an implicit "since version X" semantics. Centralized this in the Output Format section as a hard rule rather than scattering version notes — the agent will cite versions even for embedded answers.

3. **Compiler / auto-memoization changes the "performance" answer surface dramatically.** Pre-compiler React advice ("wrap in `useMemo` / `useCallback` / `memo`") is actively counterproductive in compiler-enabled codebases. The agent's Approach section asks the user about compiler status first — this same "ask about the build-time transform" pattern likely applies to any modern frontend technology (e.g. Solid's compiler, Svelte's compiler, Vue's reactivity transform).

4. **VoltAgent agents are useful for category sanity-checks but their workflow scaffolding (checklists, JSON protocols, multi-phase task plans) is at odds with this repo's "expert answerer, not reviewer" agent style.** Continue to demote them to last-pass review per the user's directive — adopt structural hints (did I miss a category?) only, not prose or protocols.

5. **The Context7 `/websites/<name>_dev_reference_<name>` pattern (high benchmark, focused on API reference) was more useful than the source-repo Context7 entry for embedded knowledge.** The source-repo entry (`/facebook/react/v19_2_0`) was better for changelog, breaking changes, and version-pinned code paths. Recommend trying both for any major OSS library and using them for different question types.
