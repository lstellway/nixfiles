# Grafana Stack Technology Expert — Sources

References that informed `technology-observability-grafana.md`. Prioritizes Context7 (live-indexed against the Grafana org's GitHub mirrors and docs site) and `grafana.com/docs`, with the GitHub source as authoritative for config-key defaults, component types, and JSON model shapes. Live-system introspection (`/api/*`, `/runtime_config`, `/-/healthy`, Alloy's `:12345/graph`) is elevated to peer status with Context7 because the running system is the only authoritative answer for "what is actually deployed."

## Version Calibration

- **Grafana**: **13.x** (latest stable line) with **12.4.x** still maintained. The `grafana.com/docs/grafana/latest/whatsnew/` index lists 13.0 and 12.4 as the most-recent feature pages. Patch cadence is monthly with frequent CVE-driven `+security-NN` builds. Github releases page (`https://github.com/grafana/grafana/releases`) is the canonical source for the latest patch.
- **Loki**: **3.7.2** (May 13, 2026 — latest stable). Verified via WebFetch on `https://github.com/grafana/loki/releases`.
- **Mimir**: **3.0.6** (April 20, 2026 — latest stable). 3.1.0-rc.0 in flight (May 8, 2026). Verified via WebFetch on `https://github.com/grafana/mimir/releases`.
- **Tempo**: **2.10.5** (April 23, 2026 — latest 2.x stable). **3.0.0-rc.1** (May 6, 2026 — major migration removing the ingester module, introducing vParquet5 as default, requiring `tempo-cli migrate` for upgrades). Verified via WebFetch on `https://github.com/grafana/tempo/releases`.
- **Alloy**: **1.16.1** (May 5, 2026). Grafana Agent (Static and Flow modes) deprecated and EOL — Alloy is the only supported collector going forward. Verified via WebFetch on `https://github.com/grafana/alloy/releases`.
- **Pyroscope**: 1.x line — calibrated against current docs at `https://grafana.com/docs/pyroscope/latest/`.
- **Grafana Cloud**: rolling release, no fixed version number. Features ship to Cloud first, then OSS/Enterprise.
- **Date confirmed**: 2026-05-19.

**Calibration caveat**: I did not deep-verify the exact Grafana 13.x patch number — the GitHub release page returned data that suggested the 13.0.1 release was a year old, which seems inconsistent with the monthly release cadence. The agent calibrates against "13.x / 12.4.x lines" without overpinning the patch level; the docs site `latest/` route and the GitHub releases page are the authoritative live sources for the current patch.

## Existing Agents and Skills Consulted

- **Sibling discipline agent — `software-observability.md`** (read in full). It's SRE-flavored: RED/USE coverage assessment, SLO mathematics, multi-window multi-burn-rate alerting design, dashboard signal hierarchy as a concept, on-call readiness, runbook standards. The Grafana agent stays on **mechanics**: how to encode signals in Mimir/Loki/Tempo, how to write the alert rule, how to wire the dashboard, how to provision a stack as code. The discipline agent owns **strategy**: what to alert on and why, what the SLO target should be, how to structure the dashboard hierarchy as a concept. The defer-to line in the agent file uses capability description ("an observability discipline specialist") per the load-bearing cross-reference rule baked into `agent-technology` Step 6.
- **Sibling product agent — `technology-observability-posthog.md`** (read in full). Used as the structural template for this agent because the situations are analogous: a broad observability product surface with multiple sub-products that share a tenancy convention and a query/SDK layer, with the same Context7-is-mandatory caveat (client-rendered docs site). Adopted from PostHog:
    - Section ordering (Scope → Sources → Core Concepts → Approach → Output Format).
    - Persona frame (deep expertise + fetch-first instinct in the same opening paragraph).
    - "Lookup order" prose block enumerating fetch precedence.
    - Embedded vs. always-fetch split, with version-sensitive surface always fetched.
    - The cross-reference rule applied to defer-to lines.
    - The "spec vs. implementation" note (PostHog uses GitHub source as spec-of-last-resort; Grafana stack uses Prometheus/OTLP specs for the PromQL/OTLP layers and GitHub source for everything Grafana-specific).
- **Sibling broad-surface agent — `technology-docker.md`** (partial variant). Used as the structural reference for sub-sectioning Documentation Sources and Core Concepts while keeping Approach flat. Docker (Engine + Dockerfile/BuildKit + Compose) is analogous to Grafana (visualization + Loki + Mimir + Tempo + Alloy) — distinct sub-products with separate canonical sources, but real-world tasks routinely cross sub-product boundaries.
- **Repo style references**:
    - `technology-go.md`, `technology-kubernetes.md`, `technology-terraform.md` — quick spot-check for tone parity on technology agents in adjacent infrastructure ecosystems. No specific content adopted.
- **`agent-technology` SKILL.md** — followed all nine steps. Step 1 (variant choice) selected **partial variant** for the reasons in Design Notes below. Step 6 structural variant applied: sub-sectioned Documentation Sources table (by sub-ecosystem within source-type groups) and Core Concepts (by sub-product), flat Approach. Step 6 persona frame combines deep expertise (the LGTM+ stack architecture, query languages, telemetry pipeline) with fetch-first discipline (Context7-mandatory, in-system introspection preferred, GitHub source as authority-of-last-resort). Step 6 cross-reference rule applied to all defer-to lines.

## Primary Sources

### Context7 — resolved IDs

Resolved via `mcp__context7__resolve-library-id` calls during authoring. All have High reputation and benchmark scores acceptable for primary use.

**Grafana (visualization platform)**:

- `/websites/grafana` — Benchmark 71, ≈98,614 snippets. Indexes the whole `grafana.com/docs` surface (Grafana + Loki + Mimir + Tempo + Pyroscope + Alloy + k6 + OnCall + IRM + Synthetic Monitoring + Grafana Cloud). **Top-row choice** for general Grafana questions; broader than the GitHub repo.
- `/grafana/grafana` — Benchmark 69, ≈4,920 snippets, versioned at v11.2.2. Useful for plugin SDK and dashboard JSON model spec — narrower scope but source-attributed to the Go/React codebase.
- `/websites/grafana_grafana` — Benchmark 33, ≈76,274 snippets. Lower benchmark; supplementary.
- `/websites/archive_grafana_grafana_v12_0` — Grafana 12.0 archived docs snapshot. Useful for version-delta questions.
- `/websites/grafana_grafana-cloud` — Benchmark 63, ≈28,492 snippets. Cloud-specific surface (Stack provisioning, Cloud SLO, IRM, Synthetic Monitoring).
- `/grafana/grafana-operator` — Benchmark 62, ≈1,217 snippets. Operator CRD reference.

**Loki**:

- `/grafana/loki` — Benchmark 73.5, ≈5,369 snippets. **Primary** for LogQL, configuration, architecture.
- `/websites/grafana_loki` — Benchmark 44.78, ≈53 snippets. Supplementary; thin coverage.

**Mimir**:

- `/grafana/mimir` — Benchmark 79.78, ≈6,543 snippets. **Primary** for Mimir.

**Tempo**:

- `/grafana/tempo` — Benchmark 76.63, ≈3,359 snippets. **Primary** for Tempo and TraceQL.

**Pyroscope**:

- `/grafana/pyroscope` — Benchmark 33.13, ≈1,050 snippets. Primary (though benchmark is modest — supplement with `grafana.com/docs/pyroscope` for ingestion details).
- `/grafana/pyroscope-rs` — ≈36 snippets, Rust agent.

**Alloy**:

- `/websites/grafana_alloy` — Benchmark 82.47, ≈2,414 snippets. **Preferred** for component reference (docs-attributed).
- `/grafana/alloy` — Benchmark 81, ≈2,166 snippets, branch `main`. Use when new components aren't yet in stable docs.

**k6**:

- `/grafana/k6-docs` — Benchmark 92.62, ≈9,729 snippets. **Preferred** for k6 questions.
- `/grafana/k6` — Benchmark 78.22, ≈2,554 snippets. Source attribution.

Not surfaced (but exist as Context7 IDs for adjacent niche libraries): `/grafana/loki-mcp` (Loki MCP server, irrelevant to general Loki questions), `/grafana/k6-jslib-*` (k6 ecosystem libraries, surfaced only when k6 user asks).

### Official documentation (verified at authoring time)

URLs spot-checked via WebFetch on 2026-05-19. **Critical caveat**: `grafana.com/docs` is heavily client-rendered — most page fetches return overview/title content with pointers to detail pages, and even detail pages often come back thin. **Context7 is mandatory** for query-language function lists, component reference, alert rule field shapes, dashboard JSON schema, and config keys. WebFetch is reliable only for:

- **https://grafana.com/docs/** — Product index. WebFetch returned the full product taxonomy (Grafana, Loki, Mimir, Tempo, Pyroscope, Alloy, Beyla, Faro, k6, Synthetic Monitoring, OnCall, IRM, Alerting, SLO, OpenTelemetry, plus Service Center) — adopted as the agent's product-surface map.
- **https://grafana.com/docs/grafana/latest/** — Section index. Returned the 11 top-level sections (What's new, Introduction, Set up, Data sources, Dashboards, Panels and Visualizations, Explore, Alerting, Administration, Troubleshooting, Upgrade). Useful for the docs-section enumeration.
- **https://grafana.com/docs/grafana/latest/whatsnew/** — Confirmed the latest minor lines (Grafana 13.0 and 12.4).
- **https://grafana.com/docs/grafana/latest/datasources/** — Returned the data source categorization: metrics/time-series (CloudWatch, Azure Monitor, Google Cloud, Graphite, InfluxDB, OpenTSDB, Prometheus), logs (Elasticsearch, Loki), traces (Jaeger, Tempo, Zipkin), profiles (Parca, Pyroscope), SQL (MSSQL, MySQL, PostgreSQL), alerting (Alertmanager), testing (TestData), special (Grafana, Mixed, Dashboard). Adopted as the agent's built-in data source list.
- **https://grafana.com/docs/grafana/latest/alerting/** — Returned thin overview (alert rules, notifications, monitoring/response, advanced) with pointers; the detailed rule shape (Grafana-managed vs data-source-managed, the data DAG, expression types, routing tree) came from embedded knowledge cross-validated against Context7.
- **https://grafana.com/docs/loki/latest/query/** — Returned a useful summary of LogQL: query types (log/metric), label matchers (`=`/`!=`/`=~`/`!~`), line filters (`|=`/`!=`/`|~`/`!~`), parsers (json/logfmt/pattern/regexp/unpack), format expressions (`line_format()`/`label_format()`), with example queries. Adopted directly.
- **https://grafana.com/docs/mimir/latest/references/architecture/components/** — Returned the component list (distributor, ingester, querier, query-frontend, query-scheduler, store-gateway, compactor, ruler, alertmanager) with brief role descriptions and noted monolithic vs microservices modes. Adopted directly.
- **https://grafana.com/docs/tempo/latest/traceql/** — Returned an introduction page only (TraceQL exists, similar to PromQL/LogQL, scopes/operators/metrics referenced as separate pages). Detail came from embedded knowledge cross-validated by Context7 — specifically the scope syntax (`span:`, `resource:`, `trace:`, `event:`, `link:`, `parent:`), the structural operators (`>>`, `<<`, `>`, `<`, `&&`, `||`, `~`), and the TraceQL metrics feature.
- **https://grafana.com/docs/alloy/latest/concepts/** — Returned the component model (typed components, blocks/attributes/expressions syntax, `.alloy` extension, declarative dependency graph) but did not detail migration from Grafana Agent or relationship to OpenTelemetry Collector. Embedded those from the broader docs scope (Alloy is an OTel Collector distribution + Prometheus pipelines; Static/Flow modes are deprecated).
- **https://grafana.com/docs/grafana/latest/dashboards/build-dashboards/best-practices/** — Returned the design heuristics (signal-led storytelling, dual y-axes for differing units, avoid stacking, meaningful color, axis normalization, template variables for dashboard sprawl prevention, refresh rate aligned to data cadence). Adopted as the citation target for dashboard design questions.

Pages accepted into the agent's table on canonical-URL grounds (without full content verification because of client-rendering — Context7 has the underlying contents via the GitHub mirror):

- `/docs/grafana/latest/{panels-visualizations, dashboards/variables, administration/provisioning, explore, administration, setup-grafana, upgrade-guide, developers, developers/http_api}` — confirmed by `/docs/grafana/latest/` navigation.
- `/docs/loki/latest/{get-started/architecture, get-started/deployment-modes, query/log_queries, query/metric_queries, configure, alert, operations/multi-tenancy}` — confirmed by `/docs/loki/latest/` navigation.
- `/docs/mimir/latest/{references/architecture, references/architecture/deployment-modes, configure, references/configuration-parameters, configure/about-runtime-configuration, references/http-api, set-up/migrate/migrate-from-cortex}` — confirmed by `/docs/mimir/latest/` navigation.
- `/docs/tempo/latest/{operations/architecture, traceql/construct-traceql-queries, traceql/metrics-queries, metrics-generator, configuration}` — confirmed by `/docs/tempo/latest/` navigation.
- `/docs/pyroscope/latest/{configure-client, configure-client/trace-span-profiles}` — confirmed by `/docs/pyroscope/latest/` navigation.
- `/docs/alloy/latest/{get-started/configuration-syntax, reference/components, reference/stdlib, reference/cli, set-up/migrate}` — confirmed by `/docs/alloy/latest/` navigation.
- `/docs/{beyla/latest/, k6/latest/, oncall/latest/}` and Grafana-Cloud-specific (`/docs/grafana-cloud/monitor-applications/frontend-observability/`, `/docs/grafana-cloud/alerting-and-irm/irm/`, `/docs/grafana-cloud/alerting-and-irm/slo/`, `/docs/grafana-cloud/testing/synthetic-monitoring/`) — confirmed from the `/docs/` product index.

### GitHub sources (authoritative for types, defaults, mixins)

- **https://github.com/grafana/grafana** — Go server + React UI. Plugin SDK lives here; dashboard JSON model schema lives in `pkg/services/dashboards/`.
- **https://github.com/grafana/loki** — Loki source. `/production/loki-mixin/` for the official Loki dashboards and alert rules.
- **https://github.com/grafana/mimir** — Mimir source. `/operations/mimir-mixin/` for the official Mimir dashboards and alert rules. `/cmd/mimir/help-all.txt` for the exhaustive flag list.
- **https://github.com/grafana/tempo** — Tempo source. `/operations/tempo-mixin/` for dashboards/alerts.
- **https://github.com/grafana/pyroscope** — Pyroscope source.
- **https://github.com/grafana/alloy** — Alloy source. Component definitions under `/internal/component/`.
- **https://github.com/grafana/beyla** — Beyla source (eBPF auto-instrumentation).
- **https://github.com/grafana/faro-web-sdk** — Faro browser SDK.
- **https://github.com/grafana/k6** — k6 source.
- **https://github.com/grafana/oncall** — OnCall source.
- **https://github.com/grafana/grafana-operator** — Operator CRDs (`GrafanaDashboard`, `GrafanaDatasource`, `GrafanaAlertRuleGroup`, `GrafanaFolder`, `GrafanaContactPoint`, `GrafanaNotificationPolicy`).
- **https://github.com/grafana/helm-charts** — All stack Helm charts (`grafana`, `loki`, `loki-distributed`, `mimir-distributed`, `tempo`, `tempo-distributed`, `alloy`, `pyroscope`, plus monitoring-mixins meta-chart).

### Live-system introspection (peer-elevated for runtime authority)

The agent surfaces these because for "is this actually configured?" or "what's the active runtime override?" questions, the live API is the only correct answer:

- Grafana: `/api/health`, `/api/frontend/settings`, `/api/datasources`, `/api/search`, `/api/v1/provisioning/*`, `grafana-cli`.
- Loki: `/config`, `/runtime_config`, `/loki/api/v1/labels`, `/loki/api/v1/rules`, `/ring`, `/services`.
- Mimir: `/config`, `/runtime_config`, `/ingester/ring`, `/store-gateway/ring`, `/ruler/ring`, `/distributor/ring`, `/api/v1/rules`, `/api/v1/alerts`.
- Tempo: `/api/v2/status/buildinfo`, `/status/config`, `/status/runtime_config`, `/ring`.
- Alloy: `:12345/graph` (component graph UI), `/-/healthy`, `/-/ready`, `POST /-/reload`, `/component/<name>/json` (REST debug).

This pattern (in-system introspection as primary lookup) is called out explicitly in `agent-technology` Step 2 ("For live-system technologies, promote in-system lookups to the top of the table") and adopted here aggressively because the Grafana stack is exceptionally introspectable.

### Spec / implementation references

- **PromQL spec (Prometheus)**: https://prometheus.io/docs/prometheus/latest/querying/basics/ — canonical for PromQL semantics. Mimir implements + extends. Where they disagree, Prometheus wins on spec; Mimir wins on extensions (sharding, multi-tenancy, query stats).
- **OTLP spec (OpenTelemetry)**: https://opentelemetry.io/docs/specs/otlp/ — canonical for the protocol Tempo and Mimir accept. The semantic conventions (https://opentelemetry.io/docs/specs/semconv/) govern span/metric attribute names; Tempo's TraceQL queries use the OTel attribute namespace.

## Volatile vs. Stable Classification

**Embedded (stable — true across recent minor lines)**:

- LGTM+ stack data flow (Alloy → backends → Grafana).
- Architecture of each backend (Loki: distributor/ingester/querier/ruler/compactor with read/write/backend SSD split; Mimir: distributor/ingester/store-gateway/compactor with read/write/backend; Tempo: distributor/ingester/compactor/querier with v2 → 3.0 ingester-removal in flight).
- LogQL query model (stream selector → pipeline; line filters, parsers, label filters, formatters; metric queries as range-aggregated + vector-aggregated).
- PromQL operator and function families (instant/range vectors; aggregations; range aggregations; histogram patterns).
- TraceQL scope model (`span:`, `resource:`, `trace:`, `event:`, `link:`, `parent:`); structural operators (`>>`, `<<`, `>`, `<`, `&&`, `||`, `~`).
- Alloy component model (typed components with args/exports, `<namespace>.<type>.<label>` naming, dependency graph, `forward_to` plumbing).
- Multi-tenancy convention (`X-Scope-OrgID` across Loki/Mimir/Tempo/Pyroscope).
- Cross-signal correlation patterns (Loki `derivedFields`, Tempo `tracesToLogs`/`tracesToMetrics`/`tracesToProfiles`, exemplars).
- Grafana alerting model (Grafana-managed vs data-source-managed; query+expression DAG; `condition` refId; `for:`; routing tree of notification policies).
- Provisioning YAML shape for data sources, dashboards, alert rules — these schemas are stable across recent versions, only adding fields.
- Dashboard JSON model fundamentals (`uid`, `schemaVersion`, panel `type`+`gridPos`+`fieldConfig`, variables, transformations).
- Loki label cardinality discipline (low-cardinality labels, high-cardinality in structured metadata or body).
- Deployment shape decision tree (monolithic / SSD / microservices for each backend; Cloud vs Helm vs Operator vs Compose).
- Migration path from Grafana Agent → Alloy (`alloy convert`), Cortex → Mimir (`mimirtool`), Tempo 2.x → 3.0 (`tempo-cli migrate`).

**Always fetch (volatile — version-sensitive)**:

- Exact configuration parameter names, types, defaults, YAML paths for all four backends (Mimir's `configuration-parameters` page is enormous and ships changes per minor; Loki's config keys evolve similarly).
- Alloy component reference — every component's args, exports, behavior. New components ship monthly; existing components gain fields.
- LogQL/PromQL/TraceQL function lists — TraceQL metrics evolves rapidly; LogQL pattern filter `|>` is Loki 3.0+; native histograms in PromQL require Mimir 2.6+ and a specific client version.
- Dashboard JSON `schemaVersion` — bumps per Grafana minor; older `schemaVersion` dashboards auto-migrate on import but the *current* shape changes.
- Plugin SDK API surface — versioned independently of Grafana itself.
- Helm chart `values.yaml` keys — chart versions iterate independently and break shape.
- Grafana Operator CRD fields — operator versions iterate independently.
- Grafana Cloud-specific surface (SLO product, IRM, Synthetic Monitoring, Stack provisioning) — Cloud is rolling-release with no fixed version.
- Faro SDK API and Alloy `faro.receiver` shape — both relatively new and evolving.
- Beyla supported protocols and metric naming — eBPF feature surface is actively expanding.

## Design Notes

- **Partial variant chosen.** The Grafana stack is a classic partial-variant fit per `agent-technology` Step 1's ternary classification:
    - **Sources are clearly distinct** — five separate GitHub repos (`grafana/grafana`, `grafana/loki`, `grafana/mimir`, `grafana/tempo`, `grafana/alloy`), each with its own docs domain (`grafana.com/docs/<product>/`), each with its own Context7 ID, each with its own release cycle. Sub-sectioning Documentation Sources is mandatory or the table becomes unreadable. Sub-sectioning Core Concepts is mandatory because Loki's architecture is different from Mimir's is different from Tempo's is different from Alloy's component model.
    - **Tasks routinely cross sub-product boundaries** — "set up an observability stack" spans Alloy + (Loki + Mimir + Tempo) + Grafana data sources + dashboards + alerts. "Debug data not arriving" reaches into Alloy pipeline + receiving backend + Grafana data source + query path. The Approach section task strategies — quick-concept, query-lookup, config-lookup, debugging, migration, version question — generalize across sub-products. Sub-sectioning Approach would fragment the strategy unnecessarily and force users into the wrong sub-product branch when their question doesn't fit.
    - The Mimir/Loki/Tempo/Pyroscope backends share a **tenancy convention** (`X-Scope-OrgID`), a **provisioning surface** in Grafana, and a **correlation pattern** (derived fields, traces-to-X) — cross-cutting concerns that belong in a single section ("Cross-cutting: the LGTM+ stack as a whole") rather than repeated per sub-product.

- **Context7 is mandatory, not just preferred** — same pattern as the PostHog agent and Nest.js technology agent. `grafana.com/docs` is client-rendered; WebFetch returns overview content with pointers, and the pointers themselves often return thin excerpts. Verified during authoring: the Alerting overview returned thin pointer-only content, the Tempo TraceQL page returned an introduction without operator syntax, the Alloy concepts page returned the syntax shape but not the Grafana Agent migration detail. Context7 surfaces the underlying snippets directly from the GitHub mirror of the docs (and from the source repos for the LGTM+ backends), bypassing the client-render problem. The agent's "Lookup order" prose calls this out explicitly so the agent doesn't burn cycles fetching the docs site for option enumeration.

- **In-system introspection elevated to peer status with Context7.** The Grafana stack is exceptionally introspectable — every backend exposes `/config` (or equivalent), `/runtime_config` for hot overrides, `/api/v1/*` for rules/alerts, and the ring endpoints for cluster health. Alloy has a live component-graph UI at `:12345` that shows args, exports, and debug info per component. For "what is actually deployed?" or "what's the active override?" questions, the docs are *not* the right source — the live system is. The agent puts in-system lookups in their own "In-system introspection" section in the Documentation Sources table and instructs the Approach to prefer them when the user has a running system. This pattern matches `agent-technology` Step 2's "For live-system technologies, promote in-system lookups to the top of the table" guidance.

- **GitHub source elevated to authority-of-last-resort.** For config-key defaults that ship without docs (a new flag added in a minor release that doesn't make it into the next docs build), the `cmd/<binary>/help-all.txt` and `pkg/` source are the truth. Surfaced as lookup-order step 3 (after Context7 and in-system, before docs). Same pattern as PostHog using `packages/types/src/posthog-config.ts` as the truth-source for config keys when docs are ambiguous.

- **Spec vs. implementation note adapted.** PostHog uses GitHub-source as the spec because there is no formal PostHog spec; the Grafana stack has *upstream specs* for its query/protocol layers (PromQL spec at prometheus.io for Mimir; OTLP spec at opentelemetry.io for Tempo, Mimir remote-write, Alloy OTel components; OpenTelemetry semantic conventions for span/metric attribute names). When Mimir disagrees with Prometheus on PromQL semantics, Prometheus wins on spec, Mimir wins on extensions (sharding, multi-tenancy, query stats). This is the spec-vs-implementation pattern from `agent-technology` Step 2.

- **Grafana Agent → Alloy migration framed as a one-way transition.** Static and Flow modes are deprecated and EOL; the agent doesn't recommend new Grafana Agent configs and treats migration to Alloy as the assumed direction for any Grafana Agent question. The `alloy convert` command is the canonical migration tool — surfaced both in the Alloy concepts and in the Approach section's migration sub-bullet.

- **Tempo 2.x → 3.0 architectural shift called out.** Tempo 3.0 removes the ingester module entirely (distributor → object store directly). This is a major operational simplification but breaks the 2.x topology, requires `tempo-cli migrate`, and changes how "trace not found" debugging works. The agent embeds both architectures and flags the migration explicitly.

- **Loki label cardinality discipline embedded as load-bearing knowledge.** The most common Loki failure mode in the wild is labelling high-cardinality dimensions (`path`, `user_id`, `request_id`) and blowing up the index. The agent embeds the three-tier model (stream labels low-cardinality / structured metadata medium-cardinality / log body high-cardinality) because every Loki performance discussion eventually returns to this. Structured metadata (Loki 3.0+) is the answer for queryable-but-not-indexed dimensions and is essential context for "should this be a label?" questions.

- **Mimir runtime overrides surfaced specifically.** The `runtime_config.yaml` hot-reloadable per-tenant overrides (`ingestion_rate`, `max_global_series_per_user`, `max_query_length`, `max_samples_per_query`) are the most common debugging entry-point for "why is Mimir rejecting samples?" or "why is this query timing out?". Embedded in the Mimir Core Concepts section and surfaced again in the Approach section's Mimir debugging bullet.

- **Alloy component graph embedded as the unit of explanation.** Alloy questions are almost always "wire these components together to do X." The agent embeds a complete example component graph (`prometheus.scrape` → `prometheus.relabel` → `prometheus.remote_write`) with all wiring conventions (`forward_to`, `targets`, `receiver`, `<namespace>.<type>.<label>.<export>` reference syntax) so the typical authoring question can be answered by adapting the example without a fetch. Component-reference fetches via Context7 are still required for specific component args, but the *shape* of the answer is settled.

- **Unified Alerting structure embedded.** Grafana 13.x removed the legacy alerting (which was deprecated through 10.x/11.x); the agent assumes Unified Alerting only. The query-DAG model (refIds for queries + expressions, the `condition` refId, the routing tree of notification policies, the contact-point/template/silence triad) is stable enough to embed and is the high-leverage answer for the most-common alerting questions ("how do I write a Grafana-managed alert?"). The line between Grafana-managed and data-source-managed (Mimir/Loki ruler) is critical for performance and is called out in both Core Concepts and Approach.

- **Cross-signal correlation table embedded as a load-bearing concept.** The "logs ↔ traces ↔ metrics ↔ profiles" correlation pattern is the LGTM+ stack's distinguishing capability — the entire reason to adopt the stack vs. point tools. Embedded in the cross-cutting section because no individual sub-product owns it (Loki has `derivedFields`, Tempo has `tracesToLogs`/`tracesToMetrics`/`tracesToProfiles`, all of which interact). A user asking "how do I link a trace from my log?" needs the whole picture.

- **Deployment shape decision tree embedded as the operational answer.** "Should we run microservices or monolithic Mimir?" is the gateway question to most self-hosted Grafana stack discussions. The agent embeds the matrix (Cloud / Helm-SSD / Helm-microservices / Operator / Compose / standalone) with when-to-choose guidance so the question can be answered without a fetch.

- **No standalone Grafana-stack agent in community indexes worth borrowing from.** VoltAgent's `awesome-claude-code-subagents` index and a few other community collections were spot-checked; their observability subagents are either generic ("monitoring-engineer", "observability-specialist") or tied to specific vendors (Datadog, Sentry) — none cover the Grafana stack as a unit. The agent is authored fresh from canonical sources, using the PostHog agent's structural template adapted for the partial-variant shape.

- **k6, Faro, OnCall, IRM, SLO included at surface-area awareness only.** These are real Grafana products and a user could ask about them, but each is deep enough to deserve its own technology agent eventually. The current agent includes them in Scope (so the user knows they're in-bounds) and in Documentation Sources (so the agent knows where to fetch), but Core Concepts treats them as one paragraph each rather than deep embeddings. If the user lands on these frequently, future iterations could split them into separate technology agents.

- **Grafana Cloud vs OSS vs Enterprise distinction surfaced.** Many features (SLO product, IRM, Synthetic Monitoring, recorded queries, fine-grained access control) are Cloud-only or Enterprise-only. The agent's Scope section enumerates the deployment shapes and their feature deltas so the agent doesn't suggest Cloud-only features to OSS users.

- **PromQL embedded rather than deferred.** Mimir is Prometheus-compatible at the query layer, and the user is almost always going to write PromQL when they query Mimir. Embedding PromQL fundamentals (instant vs range vectors, aggregations, range aggregations, histogram patterns) in the Mimir section gives the agent something concrete to answer with. The "Prometheus wins on spec, Mimir wins on extensions" note handles the spec-disagreement case.

- **The dashboard JSON model bits embedded are the ones people touch by hand.** Most users author dashboards via the UI, but those who go to JSON (for provisioning, dashboards-as-code, programmatic generation) need `uid`, `schemaVersion`, panel shape, variables, transformations — embedded as a practitioner reference. The full schema is enormous and version-sensitive; the embedded surface is the stable kernel.

- **Foundation SDK called out as the dashboards-as-code answer.** Grafonnet is well-known but the Foundation SDK is the supported successor and the agent recommends it for new work. Calling this out in the Approach section's dashboard-authoring bullet prevents the agent from defaulting to a deprecated tool.

- **The `uid` discipline called out repeatedly.** Stable `uid` on data sources and dashboards is the difference between portable provisioning and per-environment breakage. Surfaced in Core Concepts (Data sources section) and Approach (provisioning bullet) because it's the most common GitOps trap.

- **Provisioning paths split by lifecycle.** File-provisioning is the simplest, Operator is the GitOps-native answer for K8s, Terraform is the cross-cloud answer, Cloud Stack provisioning is for Cloud-managed shape. The agent's Approach section names all four and gives the trade-off (file is simplest, Operator is most K8s-idiomatic, Terraform is most portable across infra, Cloud Stack is Cloud-only). This matches the user's likely real-world choice of provisioning lane and avoids one-size-fits-all advice.
