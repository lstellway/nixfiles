# WordPress Technology Expert — Sources

References that informed the content in `technology-wordpress.md`. Authored against **WordPress 6.9** ("Gene Harris"), the current stable release as of May 2026. WordPress 7.0 is the next planned major. Sources prioritize Context7-indexed developer docs and `developer.wordpress.org` first-party reference material; community resources are noted only where they fill gaps the official docs do not cover.

## Version Calibration

- **WordPress core:** 6.9.x (latest stable in the 6.9 line as of authoring; 6.9 introduced no-FSE features beyond ongoing polish to the Site Editor and block bindings)
- **Block editor API:** `block.json` `apiVersion` 3 (introduced 6.3, current default)
- **theme.json schema:** version 3 (introduced 6.6, current default; version 2 still supported)
- **Interactivity API:** stable since WordPress 6.5 (February 2024)
- **Block bindings:** stable since WordPress 6.5
- **Application Passwords:** since WordPress 5.6
- **WP-CLI:** v2.x line, command syntax stable
- **WPGraphQL:** v1.x stable, v2 in development at authoring time
- Confirmed via web search on 2026-05-16: WordPress 6.9.4 released 2026-03-11, WordPress 7.0 targeted for 2026-05-20 with real-time collaboration deferred

## Existing Agents and Skills Consulted

### VoltAgent `awesome-claude-code-subagents`

- **`categories/08-business-product/wordpress-master.md`** — surveyed for sanity check only, per the research strategy directive. The VoltAgent definition is structured as a senior architect persona with phase-based workflow ("Architecture / Development / Excellence") and quantified deliverable targets (page load < 1.5s, security score 100/100). **Not adopted:** the persona-heavy phase workflow is unsuitable for a fetch-first technology expert. The deliverable-target framing implies the agent owns end-to-end project execution, which the Anthropic/this-repo archetype delegates to the user. **Adopted (loosely):** confirmation that a single WordPress agent covering classic + Gutenberg + headless + WooCommerce-adjacent + multisite is a reasonable scope decision (the VoltAgent definition merges these too).
- **`categories/02-language-specialists/php-pro.md`** — noted as the natural peer agent for raw PHP questions outside the WordPress runtime. Not consulted for content.

### Local repo agents (style reference only, per instructions)

- `modules/home-manager/claude/agents/technology-nix.md` and its `.sources.md` — mirrored for section ordering (Scope → Documentation Sources → Core Concepts → Approach → Output Format), tone (direct, reference-quality), and the documentation-sources table as the central artifact. Content is entirely independent.
- `modules/home-manager/claude/skills/agent-technology/SKILL.md` — followed for the nine-step authoring process and frontmatter format.

## Documentation Sources Verified

### Context7 (primary, as directed)

| Library | Context7 ID | Notes |
|---|---|---|
| WordPress Hooks reference | `/websites/developer_wordpress_reference_hooks` | 9,139 snippets, high reputation, benchmark 74.39. Confirmed hook signatures for `wp_enqueue_scripts`, `save_post`, `wp_insert_post`. |
| WordPress Functions reference | `/websites/developer_wordpress_reference_functions` | 13,027 snippets, benchmark 85.85. Authoritative for function signature lookups. |
| WordPress Classes reference | `/websites/developer_wordpress_reference_classes` | 12,829 snippets. Source for `WP_Query`, `WP_Post`, `WP_REST_Server`, `wpdb`. |
| WordPress API Reference (overview) | `/websites/developer_wordpress_reference` | 340 snippets, narrower scope. |
| Gutenberg | `/wordpress/gutenberg` | 12,462 snippets, benchmark 75.35. Confirmed `registerBlockType`, `useBlockProps`, dynamic block `render_callback` patterns. |
| WP-CLI Handbook (GitHub) | `/wp-cli/handbook` | 2,967 snippets, benchmark 91.8. Confirmed `wp search-replace`, custom command authoring, `WP_CLI::add_command` pattern. |
| WP-CLI Handbook (make.wordpress.org mirror) | `/websites/make_wordpress_cli_handbook` | 9,254 snippets, alternate path. |
| WPGraphQL | `/wp-graphql/wp-graphql` | 2,159 snippets, benchmark 82.2. Reference for headless patterns. |
| WPGraphQL Smart Cache | `/wp-graphql/wp-graphql-smart-cache` | 144 snippets. Caching companion. |
| WPGraphQL JWT Authentication | `/wp-graphql/wp-graphql-jwt-authentication` | 18 snippets. Auth companion. |

### developer.wordpress.org (first-party, verified accessible)

| Surface | URL | Verified content |
|---|---|---|
| Template hierarchy | `https://developer.wordpress.org/themes/basics/template-hierarchy/` | Confirmed cascade order and 6.4 attachment-page default-disabled note. |
| Custom REST endpoints | `https://developer.wordpress.org/rest-api/extending-the-rest-api/adding-custom-endpoints/` | Confirmed `register_rest_route` signature and `WP_REST_Server` constants. |
| Security overview | `https://developer.wordpress.org/apis/security/` | Confirmed the principle hierarchy (verify, escape late, never trust); deeper function lookups come from `/reference/`. |
| theme.json global settings | `https://developer.wordpress.org/themes/global-settings-and-styles/` | Confirmed top-level keys (version, settings, styles, customTemplates, templateParts, patterns). |
| theme.json settings keys | `https://developer.wordpress.org/themes/global-settings-and-styles/settings/` | Confirmed color, typography, spacing, layout, useRootPaddingAwareAlignments, custom. |
| Interactivity API | `https://developer.wordpress.org/block-editor/reference-guides/interactivity-api/` | Confirmed 6.5 minimum, `wp-interactive` directive, `viewScriptModule` requirement, `store()` import path. |
| Custom post types | `https://developer.wordpress.org/plugins/post-types/registering-custom-post-types/` | Confirmed `init` hook timing and 20-char slug limit. |
| Transients | `https://developer.wordpress.org/apis/transients/` | Confirmed signatures and the "max time, not min" caveat. |
| Multisite handbook | `https://developer.wordpress.org/advanced-administration/multisite/` | Confirmed path vs subdomain choice and shared-user-table architecture. |
| REST authentication | `https://developer.wordpress.org/rest-api/using-the-rest-api/authentication/` | Confirmed cookie+nonce, `X-WP-Nonce` header, Application Passwords (5.6+). |
| block.json metadata | `https://developer.wordpress.org/block-editor/reference-guides/block-api/block-metadata/` | Confirmed `apiVersion` 3 since 6.3, key list. |

### Web search and ecosystem confirmation

- WordPress release tracker — confirmed 6.9.4 (2026-03-11) as current stable, 7.0 targeted 2026-05-20, real-time collaboration deferred. Sources: `wordpress.org/news/category/releases/`, `endoflife.date/wordpress`, `attowp.com/blog/wordpress-latest-version-stable-releases-tracker/`.

## Volatile vs Stable Classification

**Always fetch** (volatile — version-sensitive, large surface, or both):
- All hook signatures (changes across releases; new hooks added every major)
- All function reference (parameter additions, deprecations)
- `block.json` and `theme.json` schemas (active evolution — version 3 of theme.json introduced in 6.6)
- REST endpoint reference (new endpoints, new query args)
- WP-CLI flag lists (per-command, frequently extended)
- Block components API (`useBlockProps`, `RichText` props, etc.)
- Interactivity API directive list (expanding)

**Embedded** (stable — foundational concepts, conventions, or grammar):
- Template hierarchy cascade order
- The loop pattern
- Action vs filter distinction and `add_action`/`add_filter` grammar
- Plugin file header structure
- The four security pillars (nonces, capabilities, sanitization, escaping) — specific function names always re-verified
- WP-CLI command grammar and global flag conventions (`--format`, `--path`, `--url`)
- Multisite mental model (shared users, isolated content)
- Custom post type registration pattern (the `init` hook timing rule)
- REST custom endpoint structure (`namespace`, `route`, `args`, `permission_callback`)

## Design Notes

**Broad-surface technology as a single agent.** WordPress is unusual in the agent archetype: a single project that spans templating, plugin architecture, a React-based editor, a REST API, a CLI, and a multisite system. Three patterns made this manageable:

1. **Sub-domain the Core Concepts and Sources table** rather than flattening them. A reader looking for theme work should not have to skim past WP-CLI to find it. Horizontal rules and sub-headings inside the documentation table preserve the table-as-central-artifact convention while giving navigation hooks.
2. **Branch the Approach section explicitly by sub-domain.** "Block editor work" and "classic plugin work" diverge enough that a unified decision tree would be wrong for both. The Approach section is one paragraph per sub-domain plus cross-cutting paragraphs for version-sensitivity and debugging.
3. **Defer aggressively and name the peers.** WordPress sits next to React (Gutenberg internals), Next.js (headless frontends), DevOps (hosting), and general security. Explicit deferrals prevent the agent from over-reaching, which is a real risk when the sub-domains are so wide.

**Context7 as primary worked well.** The WordPress reference indexes on Context7 are unusually deep (10k+ snippets across hooks, functions, classes), high-reputation, and high-benchmark — they answer the "what's the signature of `wp_insert_post`?" question with the canonical example from the reference page. For technologies with comparable Context7 coverage, prefer Context7 over WebFetch for signature lookups; reserve WebFetch for narrative documentation (handbooks, tutorials) and recency confirmation.

**Version pins matter more than usual.** WordPress has hard feature floors (Interactivity API: 6.5, Application Passwords: 5.6, `block.json` apiVersion 3: 6.3) that the agent must surface unprompted. The Approach section calls this out explicitly so the agent doesn't recommend a 6.5 feature to a 6.2 user without flagging the gap.

**The VoltAgent definition was not a useful content reference.** Its persona-and-deliverables framing (page-load targets, security scores, phase-based workflow) is a different archetype than the fetch-first technology expert this repo standardizes on. Cross-checking it confirmed the scope decision (one agent for all of WordPress) but contributed no content.
