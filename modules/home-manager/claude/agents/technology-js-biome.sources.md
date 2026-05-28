# Technology Biome — Sources & Provenance

## Existing agents and skills consulted

Inspected `/Users/logan/.claude/agents/` for sibling patterns. Closely modeled the structure on **`technology-js-tailwindcss.md`** and **`technology-js-tanstack-query.md`** — both use the flat variant (one Documentation Sources table, one Core Concepts, one Approach), open with a major-version-comparison table (v3 vs v4 for Tailwind, v4 vs v5 for TanStack Query), and promote in-band lookup commands (`npm view`, Tailwind Play, devtools panel) to the top of the sources table where they outpace static docs. That structure fits Biome cleanly — Biome is a tightly-coupled single-toolchain like Tailwind or TanStack Query, the v1 vs v2 comparison is the highest-leverage embedded reference, and `biome explain <ruleName>` / `npm view @biomejs/biome version` are genuine in-band shortcuts that should not be buried.

Sibling `Defer to:` references wired in (framed by peer-agent capability, not by what any specific project uses):

- **A TypeScript / build specialist** — for TypeScript compilation, declaration generation, `tsconfig.json` design beyond what Biome reads for path resolution, and full type-checking semantics. The Biome agent owns the type-aware lint rule surface; the TypeScript compiler is the source of truth for type errors and emit. This boundary is named explicitly because v2's type-aware rules without `tsc` create the most likely scope confusion.
- **A testing specialist** — for test runner choice (Vitest, Jest, Node test runner, Mocha), assertion-library style, test strategy. Biome ships `useTestHooksOnTop`, `noIdenticalTestTitle`, and similar test-shaped lint rules, but does not run tests.
- **The relevant bundler / framework specialist** — for Vite, Turbopack, Rollup, esbuild, webpack, Next.js, Astro, Remix, etc. Biome operates on source files; bundler config and build pipelines are theirs.
- **A tooling / DevOps specialist** — for pre-commit hook orchestration (husky, simple-git-hooks, lefthook, lint-staged) and for CI/CD pipeline design beyond the Biome-specific invocation. The Biome agent produces the right `biome ci` invocation and the right pre-commit command; the surrounding hook runner / pipeline is theirs.
- **`software-code-quality.md`** — for code-quality judgment: when a rule is worth its cost, whether to enable `noExplicitAny` globally, whether a refactor improves readability beyond what the rule sees. Biome answers "what does the rule do, how is it configured"; the philosophical "should I" stays with the code-quality reviewer.
- **`software-accessibility.md`** — for general accessibility judgment beyond what Biome's `a11y` rule group catches (WCAG conformance levels, screen-reader behavior, focus management nuance). The `a11y` group is a strong starting point but a static analyzer cannot replace human accessibility review.
- **`technology-js-react.md` / `technology-js-nextjs.md` / `technology-js-astro.md`** (and any future Vue / Svelte / SolidJS agents) — for framework-specific idiom rules beyond Biome's catalog. Biome owns the JSX, Vue SFC, Svelte, and Astro lint surface it implements; framework idioms outside that surface belong to the framework agent.

**ESLint and Prettier are explicitly in scope** for the Biome agent — but only at the migration boundary (`biome migrate eslint`, `biome migrate prettier`, rule-mapping coverage, what doesn't translate). Ongoing ESLint/Prettier authoring after a project decides to keep them belongs to a JavaScript-tooling generalist that doesn't currently exist in this roster; the boundary is "Biome handles the migration; further ESLint/Prettier authoring is outside scope."

**Community scope reference:** did not consult any external community agent index for content. The two JS tooling siblings on disk (Tailwind CSS, TanStack Query) are closer-fitting structural references and were the only ones used.

---

## Version calibration

- **Calibration date:** 2026-05-25.
- **Latest stable Biome at calibration:** `2.4.15` (published 2026-05-09). Confirmed via `npm view @biomejs/biome version` and `npm view @biomejs/biome time --json`.
- **Default version assumed in the agent:** **v2** (any v2.x). The agent answers v2 questions from the v2 surface and treats **v1** as the prior major and the source of upgrade-path questions.
- **v1 coverage:** retained as the previous-major reference. v1 is still widely deployed in pre-2025 projects; the consolidated v1-vs-v2 table in Core Concepts plus a clear "run `biome migrate --write` first" recommendation covers v1-line questions without requiring a separate agent.
- **Release cadence at calibration:** patch releases roughly every 7-10 days (e.g., 2.4.0 on 2026-02-15, 2.4.5 on 2026-03-02, 2.4.10 on 2026-03-30, 2.4.15 on 2026-05-09). Minor releases land on a slower cadence (~2-3 months between 2.3 and 2.4). The rule catalog is the most-frequently-updated surface; default-set membership and the `nursery` → real-group promotion list shift in most minors.

**Important cautionary notes for future re-survey:**

1. Re-verify the v2 line is still current (a v3 cutover would invalidate large parts of Core Concepts — the v1 → v2 reshape was substantial and a v3 might be too).
2. Re-check the v1 → v2 table for additions — additional config-shape changes may have landed in later v2.x minors.
3. Re-check the type-aware rule list — `noFloatingPromises`, `useExplicitType`, `noMisleadingReturnType`, `noConfusingVoidType` were the headline set at calibration; expect this list to grow.
4. Re-check default ruleset membership — rules promoted from `nursery` shift the recommended set. The agent claims "Biome ships ~500 rules"; bump this number to the current count.
5. Re-check the GritQL plugin capability claims — at calibration, plugins do pattern-match-and-diagnose only (no autofix, no programmatic walking). This is expanding release-over-release per the changelog.
6. Confirm the `$schema` URL pattern (`/schemas/<version>/schema.json`) hasn't changed.
7. Confirm the `biomejs/setup-biome` action major version (`@v2` at calibration).
8. Bump the Context7 `/biomejs/biome` version-pinned suffix if the index has been refreshed (currently `_biomejs_biome_2_2_x`).

---

## Documentation sources verified

All URLs fetched and confirmed accessible at authoring time (2026-05-25). Returned substantive HTML — no client-rendering issues; **`WebFetch` works directly against `biomejs.dev` without requiring Context7 as a fallback**. (This is unlike `docs.nestjs.com` and the TanStack docs site, both of which return title-only HTML to non-JS fetchers.)

| URL | Verified content |
|---|---|
| https://biomejs.dev/reference/configuration/ | Top-level `biome.json` keys: `$schema`, `extends`, `root`, `files` (with `includes`, `ignoreUnknown`, `maxSize`, `experimentalScannerIgnores`), `vcs` (`enabled`, `clientKind`, `useIgnoreFile`, `root`, `defaultBranch`), `formatter`, `linter`, `assist`, `javascript`, `json`, `css`, `graphql`, `html`, `overrides`. Glob/negation semantics including `!!` force-ignore confirmed. |
| https://biomejs.dev/linter/ | Rule groups (`a11y`, `complexity`, `correctness`, `nursery`, `performance`, `security`, `style`, `suspicious`), 502 total rules at calibration, severity values, per-language rule indexes, GritQL plugin reference. |
| https://biomejs.dev/linter/javascript/rules/ | Per-language rule index pattern confirmed. Individual rule pages live at `/linter/rules/<kebab-case-name>` regardless of language. |
| https://biomejs.dev/linter/plugins/ | URL exists (confirmed via search after the docs path corrected from a 404 on `/analyzer/plugins/`). GritQL `.grit` file plugin model. |
| https://biomejs.dev/reference/gritql/ | GritQL pattern reference for both `biome search` and plugins. |
| https://biomejs.dev/recipes/gritql-plugins/ | Worked plugin examples — replace-call patterns, sort-imports patterns, JSON transformations. |
| https://biomejs.dev/formatter/ | Formatter options and per-language scope (`javascript.formatter`, `json.formatter`, etc.); Prettier mapping (`printWidth` → `lineWidth`, `useTabs`/`tabWidth` → `indentStyle`/`indentWidth`, `semi` → `semicolons`, `trailingComma` → `trailingCommas`, `bracketSameLine`, `arrowParens` → `arrowParentheses`). Default tabs (not spaces) confirmed. |
| https://biomejs.dev/reference/cli/ | All subcommands: `check`, `lint`, `format`, `ci`, `init`, `migrate`, `migrate eslint`, `migrate prettier`, `search`, `explain`, `lsp-proxy`, `start`/`stop`/`clean`, `rage`. Cross-command flags (`--write`, `--unsafe`, `--staged`, `--changed`, `--since`, `--reporter`, `--error-on-warnings`, `--max-diagnostics`, `--only`/`--skip`, `--stdin-file-path`). |
| https://biomejs.dev/guides/migrate-eslint-prettier/ | `biome migrate eslint` and `biome migrate prettier` capabilities. Flat config support confirmed. Plugin coverage: TypeScript ESLint, JSX A11y, React, Unicorn. `--include-inspired` flag. Known gotchas: behavior mismatch, cyclic refs, format support limits (no YAML/JSON5/TOML config). |
| https://biomejs.dev/guides/big-projects/ | Monorepo support via `extends: "//"` + `root: false`; `node_modules` resolution for shared configs; per-package overrides composing with root; scanner path-hierarchy walking. |
| https://biomejs.dev/recipes/continuous-integration/ | `biome ci` differences from `biome check` (no `--write`, CI-formatter reporters, thread control); reporters `github`/`gitlab`/`junit`/`summary`; `biomejs/setup-biome` action; GitLab Docker image. |
| https://biomejs.dev/internals/architecture/ | Rust single binary; daemon server-client model; CST via fork of rowan (Green/Red tree); error-resilient parser with Bogus nodes; scanner with path-hierarchy intelligence; multi-file analyzer. |
| https://biomejs.dev/blog/biome-v2/ | v2 launch: type-aware rules without TypeScript compiler (~75% recall on `noFloatingPromises`), monorepo support, plugins, import organizer revamp, assist actions, experimental HTML formatter, `biome migrate --write` handles config transforms. |
| https://biomejs.dev/internals/changelog/ | Version history; per-minor and per-patch release notes; v2.4.15 as Latest at calibration. |

**Context7 indexes confirmed:**

- `/biomejs/website` — **5003 snippets, High reputation, benchmark 86.8** (the docs-site repo — the strongest comprehensive index; this is the default for library-wide lookups).
- `/biomejs/biome` — 959 snippets, High, benchmark 29.5 (source-code repo; pins at `_biomejs_biome_2_2_3` / `_biomejs_biome_2_2_4` at calibration — useful for source-pinned retrieval but lags the docs site's freshness).
- `/websites/biomejs_dev` — 10 snippets, High, benchmark 44.7 (the rendered docs site itself; near-empty index, likely the client-rendering issue; **avoid**).
- `/websites/next_biomejs_dev_guides` — 150 snippets, High, benchmark 78.8 (guides only; narrower scope).
- `/websites/v1_biomejs_dev` — 1836 snippets, High, benchmark 84.3 (**pin for v1-line questions** specifically).

**In-band verification tools:**

- `npm view @biomejs/biome version` — version lookup (faster than web fetch).
- `npm view @biomejs/biome time --json` — release dates of every version (used here to disambiguate "is this version recent" without web-scraping release-notes pages).
- `biome explain <ruleName>` — local rule documentation for the *installed* version. Authoritative for what's actually in the user's runtime; the docs site reflects the latest published version, which may differ from what's installed.
- `biome --help` / `biome <subcommand> --help` — local CLI documentation; same authoritativeness argument.
- `biome rage` — diagnostic dump for "Biome isn't seeing my file" debugging; promoted in the Approach section as the canonical debugging-step-one.
- The JSON schema (`https://biomejs.dev/schemas/<version>/schema.json`) — machine-readable; useful for verifying exact option names and types when the prose reference is ambiguous.

---

## Volatile vs. stable classification

**Embedded (stable, foundational, unlikely to change):**

- The unified-toolchain model (formatter / linter / assist / search, one binary, one config, one daemon).
- `biome.json` top-level shape (`$schema`, `extends`, `root`, `files`, `vcs`, `formatter`, `linter`, `assist`, `javascript`/`json`/`css`/`graphql`/`html`, `overrides`, `plugins`).
- Glob and negation semantics (`*`, `**`, `!` prefix, `!!` force-ignore).
- The rule group taxonomy (`a11y` / `complexity` / `correctness` / `nursery` / `performance` / `security` / `style` / `suspicious`) and severity shapes (`"off"` / `"info"` / `"warn"` / `"error"`, object form with `level` / `fix` / `options`, group-level toggle).
- Fix safety classification (safe / unsafe / none) and `--write` / `--unsafe` semantics.
- Recommended-set semantics (`linter.rules.recommended: true`, nursery never in recommended).
- Per-rule URL convention (`/linter/rules/<kebab-case-name>`) — camelCase config key → kebab-case URL slug.
- v1 → v2 migration table (organize-imports → assist, monorepo support, type-aware rules, plugins, GritQL search, HTML formatter, `files.include` → `files.includes`, ignore-array consolidation, `biome migrate --write` is the canonical first step).
- Prettier → Biome formatter mapping table (the most-asked migration surface).
- Monorepo pattern (root + nested with `extends: "//"`, `node_modules` shared configs).
- Type-aware-rule mechanism (no `tsc` invocation, `tsconfig.json` for path resolution only, precision over recall).
- CLI subcommand surface and the four primary commands (`check` / `lint` / `format` / `ci`).
- Cross-command flag surface (`--write`, `--unsafe`, `--staged`, `--changed`, `--since`, `--reporter`, `--error-on-warnings`).
- Daemon and CST model (Bogus nodes for error recovery, trivia preservation, daemon warm-cache).
- GritQL pattern syntax basics (backticks, `$_` / `$identifier` holes, `register_diagnostic`).
- Editor integration patterns (VS Code per-language `editor.defaultFormatter`, `editor.codeActionsOnSave` block).
- CI patterns (`biomejs/setup-biome` action, `biome ci .`, reporter selection for GitHub Annotations / GitLab Code Quality / JUnit).
- Pre-commit pattern (`biome check --staged --write`).

**Always fetch (volatile or precision-critical):**

- Exact rule names — when there's any doubt that a rule exists or what it's called (the catalog has ~500 rules and adds in every minor; `biome explain <ruleName>` if installed, else the URL).
- Per-rule option schemas — many rules have non-obvious options; always fetch the rule page or use `biome explain`.
- Default ruleset membership (which rules are in `recommended: true`) — shifts as nursery rules graduate.
- The complete `nursery` list — by definition unstable.
- Exact option default values for `biome.json` keys (e.g., the precise default for `formatter.lineWidth`, `javascript.formatter.trailingCommas`) — verify against the reference page or the JSON schema, not memory.
- GritQL plugin capability boundaries — capability surface is expanding release-over-release; check the changelog for any "can plugins do X" question.
- ESLint plugin coverage in `biome migrate eslint` — which plugins translate, which rules within each plugin translate, what `--include-inspired` adds. Changes with each minor.
- Type-aware rule list — which rules currently use type inference. Growing list.
- v1 → v2 migration edge cases for specific config patterns the migrator doesn't handle automatically.
- Anything in a release after the calibration date.

---

## Design Notes

**`biome explain` is the canonical in-band shortcut.** Like `kubectl explain <resource>`, `nix search nixpkgs#<name>`, `helm show values <chart>`, and Tailwind Play, `biome explain <ruleName>` is a genuine in-band lookup that beats any static-doc fetch for rule documentation — it returns the *installed* version's rule definition, options, fix safety, and examples. The agent promotes this to the top of the sources table for rule-lookup queries. Pattern worth carrying to other technology agents: where a CLI ships its own help/explain command for a frequently-asked query class, promote it above web fetches.

**The CLI-key vs URL-slug camelCase ↔ kebab-case convention is high-leverage.** A user asking about `noFloatingPromises` can be answered by direct URL construction (`/linter/rules/no-floating-promises`) without searching. This pattern (config key → URL by mechanical transform) is unusual enough to call out explicitly in Core Concepts so the agent can act on it without re-deriving the rule each time.

**Stale training data on Biome is unusually risky.** v2 is recent enough relative to common training cutoffs that many models still answer v2 questions in v1 idioms (`organizeImports` as a top-level key, `files.include`/`files.ignore` instead of `files.includes`, no type-aware rules, no monorepo `extends: "//"`, no GritQL plugins). The agent's Core Concepts opens with an explicit v1-vs-v2 quick-reference table for exactly this reason — it's load-bearing for both the agent and the user. Same pattern as the Tailwind agent's v3-vs-v4 table.

**Migrator-first recommendation is the right default for every migration question.** `biome migrate --write` (for v1 → v2), `biome migrate eslint --write`, and `biome migrate prettier --write` are mature and conservative. They preserve working configurations and produce a reviewable diff. The agent leans on the migrator as the mechanical first step in every migration approach, then layers the human-judgment "what doesn't translate, what's redesign rather than translation" on top. This is the same pattern the Tailwind agent uses with `@tailwindcss/upgrade` and the TanStack Query agent uses with the v5 codemod — a recurring archetype for tools with first-party migration tooling.

**Release-rate fragility.** Biome ships a patch release roughly every week and a half (15 patches between 2.4.0 on 2026-02-15 and 2.4.15 on 2026-05-09 — about one every six days). The rule catalog is the most-frequently-updated surface, and default-set membership shifts in nearly every minor. The agent should treat the catalog as volatile and fetch (or `biome explain`) when there's any doubt. The Tailwind agent has a similar warning about release-rate but on a slower cadence (minors over weeks); Biome is faster.

**WebFetch works directly against biomejs.dev** — confirmed by fetching the configuration, linter, formatter, CLI, big-projects, recipes/continuous-integration, blog/biome-v2, and internals/architecture pages, all returning substantive markdown-converted HTML. Context7 is faster for broad library-wide lookups, but the direct-fetch fallback is reliable, so the agent isn't gated on Context7 availability the way NestJS or TanStack Query agents are. (One URL did 404 during authoring — `/analyzer/plugins/` — and was corrected to `/linter/plugins/` via WebSearch. Pattern worth noting: when a doc URL guess 404s, a `site:biomejs.dev` search is faster than trying alternative path guesses.)

**Plugin scope honesty.** Biome's GritQL plugin surface is genuinely narrower than ESLint's plugin surface at calibration (pattern-match-and-diagnose only; no programmatic AST walking, no autofix from plugins, no stateful rules). The agent says this plainly rather than overselling plugins, and recommends an ESLint sidecar for anything beyond pattern-match-and-diagnose. This honesty applies even though plugin capabilities are expanding — overpromising a feature that hasn't shipped is the bigger risk than underpromising one that's about to.

**General-purpose framing.** This agent is intended for use from arbitrary projects in `~/.claude/agents/`. The agent and sources file deliberately avoid mentioning any specific consumer codebase, monorepo path, or app-specific stack. `Defer to:` entries describe peer agents by their capability (e.g., "a TypeScript / build specialist", "a tooling / DevOps specialist") rather than by what any specific repo uses. Examples are generic (`packages/api`, `packages/web`, `@my-org/biome-config`) and don't assume a particular framework consumer.
