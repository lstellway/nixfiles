# Technology Tailwind CSS — Sources & Provenance

## Existing agents and skills consulted

Inspected `/Users/logan/.claude/agents/` for sibling patterns. Closely modeled the structure on **`technology-react.md`** and **`technology-nextjs.md`** — both use the flat variant (one Documentation Sources table, one Core Concepts, one Approach) with a version-calibration callout and a per-source-URL table. That structure fits Tailwind cleanly.

Sibling `Defer to:` references wired in (framed by peer-agent capability, not by what any specific project uses):

- **`technology-react.md`** — for class-composition helpers (`clsx`/`cva`/`tailwind-merge`/`classnames`); these are React patterns, not Tailwind primitives, even though they're almost always present in Tailwind+React codebases.
- **Framework-specific build integration agents** (`technology-nextjs.md`, `technology-astro.md`, and any future Remix / SvelteKit / Nuxt / Rails technology agents) — for the framework side of the PostCSS pipeline: global-stylesheet placement, framework CSS ordering, scoped-style interaction with Tailwind, font-loader integration. The Tailwind agent owns the Tailwind side; the framework agent owns the framework side.
- **`software-accessibility.md`** — for the *judgment* on focus rings, color contrast against WCAG 1.4.3 / 1.4.11, screen-reader-only utilities, and `prefers-reduced-motion` policy. The Tailwind agent can name the utilities; the accessibility agent owns whether the choice is sufficient.
- **`software-user-experience.md`** — for design-system tradeoffs (when to abstract a component vs. compose utilities inline, visual hierarchy, scale design).

**Community scope reference:** did not consult any external community agent index for content. The two react/nextjs siblings on disk are a closer fit and were the only structural reference used.

---

## Version calibration

- **Calibration date:** 2026-05-17.
- **Latest stable Tailwind CSS at calibration:** `4.3.0` (published 2026-05-08). Confirmed via `npm view tailwindcss version` and the npm `time` metadata.
- **Default version assumed in the agent:** **v4** (the current major as of the calibration date). The agent answers v4 questions from the v4 surface and treats **v3** as the prior major and the source of upgrade-path questions.
- **v3 coverage:** retained as the previous-major reference. v3 is still widely deployed in pre-2025 projects; the consolidated v3-vs-v4 table in Core Concepts plus a pinned Context7 v3 index covers v3-line questions without requiring a separate agent.
- **PostCSS toolchain at calibration:** v4 ships as `@tailwindcss/postcss` (separate package from `tailwindcss` itself) and `@tailwindcss/vite` (first-party Vite plugin). Autoprefixer is no longer strictly required (Lightning CSS handles vendor prefixing internally), though projects migrated from v3 commonly retain it without harm.

**Important v4 cautionary note for future re-survey:** v4 differs from v3 substantially across the entire configuration surface — `tailwind.config.js` replaced by `@theme` in CSS, `@tailwind` directives replaced by `@import "tailwindcss"`, content-detection automated, JIT-only, many utilities renamed, `!important` moved from prefix to suffix, CSS-variable arbitrary-value syntax changed (`bg-[--x]` → `bg-(--x)`). When re-surveying:

1. Re-verify the v4 line is still current (a v5 cutover would invalidate large parts of Core Concepts).
2. Re-check the renames table in the upgrade guide for additions.
3. Re-check the variant catalog — new attribute and pseudo-class variants land in minor releases (4.1 added `inverted-colors`, container size variants, `noscript`, etc.).
4. Re-confirm the default `--spacing`, `--breakpoint-*`, and color-namespace shapes haven't shifted.
5. Confirm the `@tailwindcss/postcss` and `@tailwindcss/vite` package names haven't been renamed/consolidated.

---

## Documentation sources verified

All URLs fetched and confirmed accessible at authoring time (2026-05-17). Returned substantive HTML — no client-rendering issues; WebFetch works directly without requiring Context7 as a fallback.

| URL | Verified content |
|---|---|
| https://tailwindcss.com/docs/upgrade-guide | v3→v4 breaking changes: CSS-first config, package split, renamed utilities (shadow/blur/rounded scales), `outline-none` → `outline-hidden`, `bg-opacity-*` removed, `!flex` → `flex!`, `bg-[--var]` → `bg-(--var)`, `corePlugins`/`safelist`/`resolveConfig` removed, browser-support requirements |
| https://tailwindcss.com/docs/functions-and-directives | `@import`, `@theme`, `@source`, `@utility`, `@variant`, `@custom-variant`, `@apply`, `@reference`, `@config` (compat), `@plugin` (compat); `--alpha()`, `--spacing()`, `theme()` (deprecated) |
| https://tailwindcss.com/docs/theme | Every `@theme` namespace, `@theme inline`, `@theme static`, `--*: initial` reset patterns, animation keyframes paired with `--animate-*` |
| https://tailwindcss.com/docs/hover-focus-and-other-states | Full variant catalog: state, structural, form, logical (has/not), pseudo-elements, media/feature queries, attribute (aria/data), relationship (group/peer/in-), child (`*`/`**`), arbitrary, custom |
| https://tailwindcss.com/docs/responsive-design | Default breakpoints (sm 40rem → 2xl 96rem), max-* variants, container queries `@container` / `@xs`–`@7xl` / named, customization via `--breakpoint-*` |
| https://tailwindcss.com/docs/dark-mode | Default `prefers-color-scheme`, class-based via `@custom-variant dark (&:where(.dark, .dark *))`, data-attribute variant pattern |
| https://tailwindcss.com/docs/colors | OKLCH P3 palette, opacity modifier `/`, `--alpha()` function, override/disable/reset patterns |
| https://tailwindcss.com/docs/adding-custom-styles | `@utility` vs `@apply` vs `@layer components` vs arbitrary values; the "you probably don't need it" guidance |
| https://tailwindcss.com/docs/detecting-classes-in-source-files | Plain-text scanning, default exclusions (gitignore, binary, CSS, lockfiles), `@source`/`@source not`/`@source inline()`, `source()`/`source(none)` import options, dynamic class-name pitfall |
| https://tailwindcss.com/docs/installation/using-postcss | `npm install tailwindcss @tailwindcss/postcss postcss`, `postcss.config.mjs`, `@import "tailwindcss"`. Confirmed Autoprefixer not required in v4 |
| https://tailwindcss.com/docs | Top-level docs structure for URL-by-topic routing |

**Context7 indexes confirmed:**

- `/websites/tailwindcss` — 2221 code snippets, High reputation, benchmark 78.25 (v4 default).
- `/tailwindlabs/tailwindcss.com` — 1874 snippets, High reputation, 84.91 (source-repo of the docs site itself; useful for snippet retrieval).
- `/websites/v3_tailwindcss` — 1600 snippets — pin this for v3-line questions.

**In-band verification tools:**

- `npm view tailwindcss version` — version lookup (faster than web fetch).
- `npm view tailwindcss time --json` — release dates of every version (used here to disambiguate a WebFetch hallucination that mis-dated v4.2.x and v4.3.0).
- **Tailwind Play** (https://play.tailwindcss.com/) — instant in-band confirmation of utility behavior; promoted in the Approach section as the fastest way to verify a class question without scaffolding a project.

---

## Volatile vs. stable classification

**Embedded (stable, foundational, unlikely to change):**

- The utility-first model and its tradeoffs.
- v4 CSS-first configuration shape (`@import "tailwindcss"`, `@theme`, `@utility`, `@custom-variant`, `@source`, `@plugin`).
- Theme-namespace map (`--color-*`, `--font-*`, `--text-*`, `--spacing`, `--breakpoint-*`, `--container-*`, `--radius-*`, `--shadow-*`, `--animate-*`, etc.).
- The cascade-layer model (`@layer base/components/utilities`) and when to use which.
- `@apply` semantics, `@reference` requirement for non-main CSS files.
- Full variant catalog (state / structural / logical / pseudo-elements / media / feature / attribute / relationship / child / arbitrary / custom).
- Default responsive breakpoints (sm 40rem → 2xl 96rem) and container-query variants.
- Color system mechanics: OKLCH, opacity modifier `/`, `--alpha()`.
- Spacing-scale single-token mechanic (`--spacing` × multiplier).
- Dark-mode strategies (media / class / attribute).
- Source-detection rules and the dynamic-class-name pitfall.
- Preflight behavior changes.
- The v3 → v4 rename/breaking-change table — embedded because it's the highest-volume question category and reads better as one consolidated reference than as repeated fetches.

**Always fetch (volatile or precision-critical):**

- Exact class names for less-common utilities (`mask-*`, `scrollbar-*`, `backdrop-*`, container utilities, scroll-snap, accent colors, etc.).
- Exact default theme values (the precise OKLCH triples for the default palette, exact `--shadow-*` token values).
- Plugin APIs and the official plugin list (changes across minor versions).
- Framework integration specifics (`/docs/installation/framework-guides/*`).
- v3 → v4 migration edge cases for specific config patterns the codemod doesn't handle.
- Anything in a minor-release changelog after the calibration date.

---

## Design Notes

**Verified WebFetch hallucinated release dates.** The first WebFetch against https://github.com/tailwindlabs/tailwindcss/releases returned 2024 dates for v4.2.x and v4.3.0 (the model invented plausible-looking dates from training-data priors). Cross-checked against `npm view tailwindcss time --json`, which returned the real timestamps (v4.2.4 = 2026-04-21, v4.3.0 = 2026-05-08). **Pattern worth noting for the agent archetype:** version + release-date claims should be verified via `npm view <pkg> time --json` (or the equivalent registry probe), not WebFetch summaries of release-notes pages, when the underlying release pages are list-of-many and the model may interpolate.

**Stale training data on Tailwind is unusually risky.** v4 is recent enough relative to common training cutoffs that many models still answer v4 questions in v3 idioms (`tailwind.config.js`, `@tailwind base;`, `darkMode: 'class'`, `!flex`, `bg-[--x]`). The agent's `## Core Concepts` opens with an explicit v3-vs-v4 quick-reference table for exactly this reason — it's load-bearing for both the agent and the user.

**Attribute variants are the highest-value undertaught feature.** Headless component libraries (React Aria Components, Radix UI, Headless UI, shadcn/ui built on Radix, Ark UI) almost universally expose component state through `data-*` attributes. The variant catalog in Core Concepts calls this pattern out explicitly alongside the `data-[state=open]:` syntax. This is framed as a general Tailwind capability (the `data-*` variant family) intersecting with a general industry pattern (headless-primitive libraries), not as advice for any specific project's stack. Future technology agents for CSS-in-JS / styling systems should consider similar callouts where component-library attribute conventions intersect with the styling layer.

**Autoprefixer in v4 is a soft "not required, harmless if present" answer.** The official v4 install docs omit Autoprefixer entirely; v4's Lightning CSS pipeline handles vendor prefixing internally. But many real codebases still carry Autoprefixer in the PostCSS pipeline from v3 days. The agent answers this with "not strictly required in v4, no harm in keeping it" rather than a dogmatic remove-it instruction.

**Tailwind Play is a genuine in-band tool.** Most documentation sites don't have a public live REPL. Tailwind's Play environment runs the current Tailwind version and is the fastest way to disambiguate a utility behavior question. Treated similarly to the "run `kubectl explain`" or "run `nix search`" pattern in other technology agents — a runtime lookup that outpaces any static documentation fetch for the right question class.

**General-purpose framing.** This agent is intended for use from arbitrary projects in `~/.claude/agents/`. The agent and sources file deliberately avoid mentioning any specific consumer codebase, monorepo path, or app-specific stack. `Defer to:` entries describe peer agents by their capability (e.g., "framework-specific build integration") rather than by what any specific repo uses. Examples are generic (a button, a card, a `.prose` container, `@my-org/ui`) and don't assume a particular framework consumer.
