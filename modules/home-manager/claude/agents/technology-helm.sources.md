# Helm Technology Expert — Sources

References that informed `technology-helm.md`. Prioritizes Context7 (live-indexed against Helm's own docs source at a pinned version), the official `helm.sh/docs` site, and Helm's GitHub releases page over community material.

## Version Calibration

- **Helm version pinned**: **3.21.0** — current stable in the v3 line, released **2026-05-14**.
- **Date confirmed**: 2026-05-17.
- **Major-version context**: Helm **4.0.0** went GA in 2026 (latest at confirmation: **4.1.1**). The user explicitly scoped this agent to Helm 3, so the agent owns v3 and defers v4 questions with a pointer to the v4.0.0 release notes for breaking-change categories.
- **Helm 2**: EOL since November 2020. Tiller is gone since Helm 3.0 (November 2019). The `helm-2to3` plugin was **archived July 2024**. Noted in the agent — the only valid v2 answer is "migrate."
- **Context7 Helm library versions** exposed at authoring time: `v3.19.0`, `v4.0.4`, `v2.0.0`. The agent recommends `/helm/helm/v3.19.0` as the closest 3.x pin for the canonical Helm Go library, with `/helm/helm-www` (3630 snippets) and `/websites/helm_sh` (962 snippets, benchmark 87.22) for documentation-side queries.
- **Sprig**: indexed by Context7 as `/masterminds/sprig` (benchmark 90.4, 402 snippets). The Sprig surface is stable; Helm enables most of it except `env`/`expandenv` (removed for security).
- **Helmfile**: v1.1.x current at authoring (`/websites/helmfile_readthedocs_io_en` benchmark 91.8, 607 snippets; alt `/helmfile/helmfile` benchmark unscored, version `v1.1.3`).

### Helm 3.x notable version landmarks worth knowing

- **3.0** (Nov 2019) — Tiller removed; in-cluster state moves to Secrets in the release namespace.
- **3.7** — preliminary OCI support (experimental).
- **3.8** — **OCI registries GA**. `helm registry login`, `oci://` URLs first-class.
- **3.13** — `--dry-run` gains `client|server|none` modes.
- **3.14** — `--reset-then-reuse-values` (cleaner alternative to `--reuse-values`).
- **3.20.x** — Kubernetes client libraries on v0.35; security patches.
- **3.21.0** — Kubernetes client libraries on v1.36; OCI image-index pulling improvements. Marked as approaching end-of-life.

## Existing Agents and Skills Consulted

- **VoltAgent `awesome-claude-code-subagents`** (https://github.com/VoltAgent/awesome-claude-code-subagents) — surveyed for scope reference. The collection has Kubernetes-adjacent agents but no Helm-specific subagent at authoring time. The closest entries use a checklist/protocol archetype that conflicts with this skill's fetch-first expert voice. **Nothing inherited.**
- **Repo-local style references**:
  - `technology-payloadcms.md` (primary template — most recent and refined; adopted for tone, section ordering, the Context7-as-top-row pattern, the explicit defer table in Scope, the per-task Approach paragraphs, and the version-calibration discipline).
  - `technology-nix.md` (concise reference — adopted only for the lookup-Bash-shortcut idea and the compact source table style).
- **Repo's own peer agents** — the parallel `technology-kubernetes` agent (per the user's task brief) is the explicit defer target for Kubernetes API resource questions. The Helm agent's Scope and Approach both name this split.

## Primary Sources

### Context7 (primary lookup channel)

- **`/helm/helm/v3.19.0`** — versioned Helm core (Go library + CLI). 129 snippets, High reputation. **Closest v3.x pin available.** Agent's preferred runtime path: `mcp__context7__query-docs` with this libraryId. Note: the agent should pin to the user's version when they state one; v3.21.0 is not yet in Context7's version selector but `/helm/helm` indexes recent content too.
- **`/helm/helm-www`** — Helm's `helm.sh` doc site source. **3630 snippets**, High reputation, benchmark 75.53. Best for narrative documentation (chart structure, hook lifecycle, template guide chapters).
- **`/websites/helm_sh`** — alternative web-side index of helm.sh. **962 snippets**, High reputation, benchmark 87.22. Use as a secondary if `/helm/helm-www` returns thin results for a query.
- **`/masterminds/sprig`** — Sprig function library. 402 snippets, Medium reputation, benchmark 90.4. **Primary source for Sprig function signatures**, faster than the rendered Sprig site.
- **`/websites/helmfile_readthedocs_io_en`** — Helmfile docs. 607 snippets, High reputation, benchmark 91.8. Primary for any helmfile-specific question.
- **`/helm-unittest/helm-unittest`** — surfaced during search (62 snippets); embedded as one of the three "plugins worth knowing" in the agent, with the GitHub repo as the primary install/reference path.

### Official Documentation (every URL in the agent's table verified at authoring time)

All URLs confirmed accessible. Notes per URL:

- https://helm.sh/docs/ — Helm 4.1.1 documentation home. Version selector exposes 3.20.0 (3.21 docs not yet promoted) and 2.17.0.
- https://helm.sh/docs/topics/architecture/ — confirms the three-concept model (chart/config/release), the in-cluster Secret-based release storage, and the "no Tiller" client/library split.
- https://helm.sh/docs/intro/quickstart/ — quickstart, demonstrates installing from an OCI registry (signal that OCI is the modern default).
- https://helm.sh/docs/intro/install/ — installation methods.
- https://helm.sh/docs/topics/charts/ — comprehensive chart structure reference. Confirms `crds/` is reserved, never templated, never upgraded. Confirms `values.schema.json` is a top-level optional file applied to the **final merged** `.Values`.
- https://helm.sh/docs/chart_template_guide/ — template guide index. 16 sub-pages enumerated.
- https://helm.sh/docs/chart_template_guide/builtin_objects/ — `.Values`, `.Release`, `.Chart`, `.Files`, `.Capabilities`, `.Template`, `.Subcharts`.
- https://helm.sh/docs/chart_template_guide/values_files/ — **precedence verified**: chart `values.yaml` < parent `values.yaml` < user `-f` files < `--set` (last wins).
- https://helm.sh/docs/chart_template_guide/functions_and_pipelines/ — pipelines, `default`, `quote`, etc.
- https://helm.sh/docs/chart_template_guide/function_list/ — **18 function categories** confirmed (Logic/Flow, String, Type Conversion, Regex, Crypto, Date, Dictionaries, Encoding, Lists, Math, Float Math, Network, File Path, Reflection, SemVer, URLs, UUIDs, Kubernetes/Chart). Includes the Helm-specific `lookup`, `required`, `tpl`, etc.
- https://helm.sh/docs/chart_template_guide/control_structures/ — `if`/`else`/`with`/`range`.
- https://helm.sh/docs/chart_template_guide/variables/ — `$`, `$var`, `$.` for root escape.
- https://helm.sh/docs/chart_template_guide/named_templates/ — `define`/`template`/`include`, `_helpers.tpl` convention.
- https://helm.sh/docs/chart_template_guide/accessing_files/ — `.Files.Get`, `.Files.Glob`, `.Files.AsConfig`, `.Files.AsSecrets`, `.Lines`.
- https://helm.sh/docs/chart_template_guide/notes_files/ — `NOTES.txt`.
- https://helm.sh/docs/chart_template_guide/subcharts_and_globalvalues/ — subchart values override and `.Values.global.*`.
- https://helm.sh/docs/chart_template_guide/debugging/ — `--debug`, `--dry-run`, `helm template`, `helm get manifest`.
- https://helm.sh/docs/topics/charts_hooks/ — **9 hook events** (`pre-install`, `post-install`, `pre-delete`, `post-delete`, `pre-upgrade`, `post-upgrade`, `pre-rollback`, `post-rollback`, `test`), weights are string-typed ints, **3 deletion policies** (`before-hook-creation` default, `hook-succeeded`, `hook-failed`) — all verified.
- https://helm.sh/docs/topics/chart_tests/ — `helm.sh/hook: test` annotation, `helm test` command.
- https://helm.sh/docs/topics/library_charts/ — `type: library`, fails install with "library charts are not installable".
- https://helm.sh/docs/topics/chart_repository/ — **NOTE: correct URL is `chart_repository` (singular), NOT `charts_repositories`** as the task brief proposed. The plural form returns 404. Index.yaml, `helm repo` commands, GitHub Pages/ChartMuseum/Artifactory hosting all documented here.
- https://helm.sh/docs/topics/registries/ — OCI support. Page carries a notice that it has not yet been updated for Helm 4; content is still accurate for Helm 3.
- https://helm.sh/docs/topics/provenance/ — `.prov` files, `--sign`, `--verify`. (Included in table; not explicitly fetched during URL verification but the URL pattern is correct per the docs index.)
- https://helm.sh/docs/howto/charts_tips_and_tricks/ — confirmed coverage: `tpl` function, image-pull secrets pattern, checksum-driven rollouts, `helm.sh/resource-policy: keep`, `_*.tpl` partials convention, `helm upgrade --install` idempotent pattern.
- https://helm.sh/docs/chart_best_practices/ — 8 sections (General Conventions, Values, Templates, Dependencies, Labels and Annotations, Pods and PodTemplates, CRDs, RBAC).
- https://helm.sh/docs/helm/ — CLI command index for Helm 4.1.1 (also serves 3.x via version selector).
- https://helm.sh/docs/helm/helm_install/ — `--set`, `--values`, `--dry-run`, `--debug`, `--wait`, `--timeout`, `--create-namespace`, `--verify`, `--version` confirmed.
- https://helm.sh/docs/helm/helm_upgrade/ — `--values`, `--set`, `--set-file`, `--set-json`, `--set-string`, `--reuse-values`, `--dry-run`, rollback-on-failure flags confirmed.
- https://helm.sh/docs/helm/helm_dependency/ — `helm dependency update` (regenerates `Chart.lock`), `helm dependency build` (uses existing `Chart.lock`), `helm dependency list`.
- https://helm.sh/docs/topics/v2_v3_migration/ — covers the v2→v3 migration. Still present in v3.20.0 docs at confirmation. Notes the `2to3` plugin which is now archived (separate finding below).

### URLs that 404'd

- `https://helm.sh/docs/topics/charts_repositories/` — **404**. The correct URL is the singular `chart_repository/`. Updated in the agent's source table.
- `https://helm.sh/docs/topics/chart_dependencies/` — **404**. Chart dependencies are documented inline at https://helm.sh/docs/topics/charts/#chart-dependencies and via the CLI page https://helm.sh/docs/helm/helm_dependency/. The agent points to both.

### Plugin and Tool Sources

- https://github.com/databus23/helm-diff — `helm-diff` plugin. Active (latest v3.15.7, May 2026). 3.4k stars.
- https://github.com/jkroepke/helm-secrets — `helm-secrets` plugin. Active (latest v4.7.6, April 2026). 2k+ stars. Integrates sops/vals.
- https://github.com/helm-unittest/helm-unittest — `helm-unittest` plugin. Indexed in Context7.
- https://github.com/helm/helm-2to3 — **archived July 17, 2024.** Plugin deprecated. Referenced only for historical context in the v2-is-EOL note.

### Source and Release Channels

- https://github.com/helm/helm — Helm Go source. Relevant packages for source-level questions: `pkg/chart`, `pkg/chartutil`, `pkg/engine` (the template renderer), `pkg/action` (high-level install/upgrade/etc.), `pkg/release`, `cmd/helm` (CLI entry points).
- https://github.com/helm/helm/releases — canonical changelog. Used to confirm 3.21.0 as latest v3 (2026-05-14) and 4.1.1 as latest v4.
- https://github.com/helm/helm/releases/tag/v4.0.0 — v4 breaking-change reference: redesigned (WASM) plugin system, post-renderers as plugins, server-side apply, kstatus-based waits, content-based local caching, slog-based logging, reproducible chart builds, updated SDK API.
- https://github.com/helm/helm/releases/tag/v3.21.0 — confirms feature scope (K8s client to v1.36, OCI image-index pull fix, CVE patches) and EOL warning for the v3 line.

### Community / Secondary

- https://artifacthub.io/ — CNCF chart and artifact discovery. Also queryable as `helm search hub <term>` (mentioned as a Bash shortcut in the agent).
- https://helmfile.readthedocs.io/ — Helmfile reference. v1.1 at authoring; v0.x users should jump straight to v1.x.
- https://masterminds.github.io/sprig/ — Sprig docs site. Listed as web fallback; Context7 `/masterminds/sprig` is the preferred path.

## Volatile vs. Stable Classification

**Embedded (stable across the v3.x line — unlikely to change without a major)**:

- The three concepts (chart / config / release) and the in-cluster Secret-based storage model.
- Chart directory layout: `Chart.yaml`, `values.yaml`, `templates/`, `_*.tpl` partial convention, `charts/`, `crds/` special handling, `templates/tests/`, `.helmignore`.
- `Chart.yaml` core fields (apiVersion, name, version, appVersion, type, kubeVersion, dependencies, annotations).
- Values precedence order (chart values < parent values < `-f` < `--set`).
- The template execution model: Go `text/template` + Sprig + Helm extensions; root `.` context; `$` for root escape; trim markers `{{-` and `-}}`.
- Built-in object catalog (`.Values`, `.Release`, `.Chart`, `.Files`, `.Capabilities`, `.Template`, `.Subcharts`).
- `include` vs `template` distinction (only `include` returns a string for piping).
- `tpl` for double-rendering, `lookup` for cluster queries (and the `helm template` / `--dry-run=client` empty-result caveat).
- Hook lifecycle: 9 events, weighted ordering within a phase, 3 deletion policies.
- Dependency workflow: declaration in `Chart.yaml`, `Chart.lock` as the pin, `helm dependency update` vs `build`.
- Repo modes: HTTP `index.yaml` repos vs OCI registries; the CLI surface difference (`helm repo add` vs `helm registry login`).
- Release lifecycle commands and revision semantics (`install`, `upgrade`, `rollback`, `uninstall`, `history`, `status`, `get manifest`, `get values`).
- The recommended `app.kubernetes.io/*` labels and the canonical `fullname` / `labels` / `selectorLabels` helper pattern from `helm create`.
- CRDs special case (installed once, never upgraded by Helm in the `crds/` directory).
- Library charts (`type: library`).
- Why Helm 2 is dead.

**Always fetch (volatile — version-sensitive)**:

- **Specific function signatures** in the Helm/Sprig function list (argument order matters; `default DEFAULT VALUE` vs `merge` vs `mergeOverwrite` are common bugs).
- **CLI flags per command** — flags are added across minor versions (e.g. `--dry-run=client|server|none` in 3.13; `--reset-then-reuse-values` in 3.14). Always fetch the per-command page.
- **Hook annotation strings** — confirmed against the hooks page rather than memorized.
- **Plugin APIs** — plugin install URLs, command surfaces, and option shapes evolve.
- **Helmfile schema** — moving between v0.x and v1.x is a breaking change; the agent should always pin to v1.x and confirm against the readthedocs reference.
- **Release-channel specifics** — what's in 3.21.0 vs 3.20.x vs upcoming 3.22 needs the GitHub releases page.
- **Anything Helm 4-specific** — the user scoped this agent to Helm 3; v4 specifics should be deferred to a future agent or to the v4 release notes.

## Design Notes

- **Explicit Helm 3 / Helm 4 boundary**. Helm 4 is GA at authoring time, so the agent must immediately disambiguate. The Core Concepts section opens with a "read this first" subsection naming the version split, and the Approach section names a defer trigger for v4 questions. Without this, a user on Helm 4 would get subtly-wrong answers from a v3-calibrated agent.
- **The Kubernetes/Helm split is real and load-bearing.** Many "Helm" questions are actually Kubernetes API questions wrapped in template syntax. The agent's Scope section names this split explicitly and gives a concrete example ("How should this Deployment be configured?" belongs to **Technology Kubernetes**). Without this discipline, the Helm agent would constantly drift into the K8s agent's territory.
- **CRD upgrade trap deserves its own paragraph.** The Helm-3 CRD behavior (install-once, never-upgrade for `crds/` directory) is the single most-misunderstood piece of the chart model. The agent calls out the three workaround options explicitly in the Approach section.
- **Hook deletion policy is a footgun.** Without `helm.sh/hook-delete-policy`, Job hooks accumulate forever in the namespace. The agent's hook-authoring guidance always sets a policy.
- **Selector labels vs annotation labels.** The canonical helper pattern splits `labels` (full set, mutable) from `selectorLabels` (minimal, immutable) because `Deployment.spec.selector` is immutable after creation. The agent embeds the pattern verbatim from `helm create` output so users don't reinvent it badly.
- **OCI is the default now.** OCI registries went GA in 3.8 (2022); ArtifactHub, GHCR, Bitnami, and most major chart authors publish OCI. The agent recommends OCI for new work and treats HTTP repos as legacy-compatible rather than the default. This matches where the ecosystem is heading and where Helm 4 is going.
- **Context7 versioning is partial for Helm.** The Helm core library exposes a few versions (`v3.19.0`, `v4.0.4`, `v2.0.0`) but not the current 3.21.x. The doc-site indexes (`/helm/helm-www`, `/websites/helm_sh`) are unversioned. Note this in the source table so users know that version-pinned doc lookup is approximate, and fall back to `helm.sh/docs` with the version selector for true pinning.
- **`helm template` semantics deserve a table.** The `lookup` / hook / API-call behavior of `helm template` vs `--dry-run=client` vs `--dry-run=server` vs `install` is a frequent source of confusion (especially for GitOps integrations). Embedded as a 4-row table in Core Concepts.
- **URL hygiene matters.** Two of the URLs in the task brief 404'd (`charts_repositories/` and `chart_dependencies/`). Verified during authoring and the source table uses the corrected paths. This reinforces why URL verification is in Step 2 of the skill — even authoritative-looking URLs can be subtly wrong.
