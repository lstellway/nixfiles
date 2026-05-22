# Sources — Technology OpenTelemetry Agent

## Existing Agents and Skills Consulted

Checked the community agent index at https://github.com/VoltAgent/awesome-claude-code-subagents:
- No existing OTel-specific agents found in 131+ entries. Infrastructure/DevOps entries (sre-engineer, performance-engineer) do not cover OTel specifically. No content inherited from community agents.

Checked existing local agents (`~/.claude/agents/`):
- `technology-observability-grafana.md` — covers Grafana stack (Loki, Mimir, Tempo, Alloy, dashboards). The OTel agent defers to this for Grafana-specific configuration and dashboards.
- `technology-observability-posthog.md` — covers PostHog product analytics. No overlap.
- `technology-kubernetes.md` — covers core K8s workloads, networking, RBAC, storage, kubectl. The OTel agent defers to this for general cluster management; covers only OTel-specific K8s resources (Operator CRDs, Helm chart values).

## Version Calibration

Calibrated against as of 2026-05-21:
- **OTel Specification**: 1.57.0 (fetched from https://opentelemetry.io/docs/specs/otel/)
- **OTLP Specification**: 1.10.0 (fetched from https://opentelemetry.io/docs/specs/otlp/)
- **Collector**: latest stable (contrib tracks independently; no single pinned version — always fetch component READMEs for current options)
- **Semantic Conventions**: versioned independently from spec — always fetch, never embed attribute names

## Documentation Sources Verified

| URL | Status | Notes |
|---|---|---|
| https://opentelemetry.io/docs/ | ✓ Accessible | Main docs hub, hierarchical nav |
| https://opentelemetry.io/docs/specs/otel/ | ✓ Accessible | Spec 1.57.0, organized by API/SDK/Data |
| https://opentelemetry.io/docs/specs/otlp/ | ✓ Accessible | OTLP 1.10.0, confirmed port/path details |
| https://opentelemetry.io/docs/specs/semconv/ | ✓ Accessible | 15 domains, 5 signal types |
| https://opentelemetry.io/docs/collector/ | ✓ Accessible | 5 major sections confirmed |
| https://opentelemetry.io/docs/collector/configuration/ | ✓ Accessible | Full 6-section config model confirmed |
| https://opentelemetry.io/docs/languages/go/ | ✓ Accessible | Traces/metrics stable, logs beta |
| https://opentelemetry.io/docs/languages/js/ | ✓ Accessible | Traces/metrics stable; browser experimental |
| https://opentelemetry.io/docs/kubernetes/ | ✓ Accessible | Operator, Helm charts, getting started |
| https://opentelemetry.io/ecosystem/registry/ | (not fetched) | Registry URL verified from docs |
| https://github.com/open-telemetry/opentelemetry-collector-contrib | (not fetched) | Well-known upstream; source for component READMEs |
| https://github.com/open-telemetry/opentelemetry-helm-charts | (not fetched) | Well-known upstream; values files per chart |

### Context7 Libraries Resolved

- `/open-telemetry/opentelemetry.io` — 8,652 snippets, Source Reputation: High, Score: 84.1. Selected as primary Context7 source for cross-language SDK code patterns.
- `/websites/opentelemetry_io` — 27,650 snippets, Score: 80.3. Higher snippet count but lower benchmark score; the `/open-telemetry/opentelemetry.io` library has higher quality ranking and is the canonical upstream repo.
- Language-specific libraries also available: `/open-telemetry/opentelemetry-python`, `/open-telemetry/opentelemetry-dotnet` (core-1.15.0), `/open-telemetry/opentelemetry-java` (v1.49.0). These can supplement when Context7 queries for a specific language need deeper snippet coverage.

## Structural Variant Decision

**Full broad-surface** selected. Rationale:
- A Collector configuration question and a Go SDK instrumentation question need materially different sources, strategies, and output formats — the task flow branches by sub-domain
- K8s Operator CRD questions are orthogonal to SDK questions
- Approach section is kept partially flat with a cross-cutting "end-to-end debugging" strategy since debugging traces through SDK → Collector → backend spans all sub-domains

## Volatile vs. Stable Classification

| Knowledge area | Classification | Reason |
|---|---|---|
| Signal model (trace/metric/log concepts) | Embedded (stable) | Foundational; stable across spec releases |
| Provider pattern | Embedded (stable) | Architectural invariant |
| Resource concept | Embedded (stable) | Concept unchanged; specific auto-detector options are volatile |
| OTLP ports and paths | Embedded (stable) | Ports 4317/4318 and `/v1/*` paths are long-stable |
| Collector pipeline model | Embedded (stable) | receivers → processors → exporters model is foundational |
| Collector memory_limiter / batch ordering | Embedded (stable) | Documented best practice, unlikely to change |
| Semantic convention attribute names | Always fetch | Renamed frequently (e.g., `http.method` → `http.request.method`) |
| SDK API signatures | Always fetch | Evolve per language SDK release cycle |
| Collector component config options | Always fetch | Each component has its own release cycle |
| K8s Operator CRD fields | Always fetch | Drift frequently between operator releases |
| SDK signal stability levels | Always fetch | Vary by language and change as signals stabilize |

## Design Notes

**The "always fetch semconv" rule is the most important rule in this agent.** OTel semantic convention attribute names are the single highest-probability source of stale training-data errors in LLM-generated OTel code. The `http.method` → `http.request.method` rename is a canonical example — code using the old name still compiles and runs but produces non-compliant telemetry. The agent should never cite an attribute name without fetching.

**The shutdown/flush pattern is the most common SDK omission.** Language SDKs buffer telemetry and flush on shutdown. Forgetting to call `TracerProvider.Shutdown()` (or equivalent) causes silent data loss at process exit. Always include this in SDK instrumentation output.

**Collector component distribution awareness.** The split between core and contrib components trips up many users — `hostmetricsreceiver`, `k8sattributesprocessor`, `lokiexporter` etc. are not in core. The agent should always note which distribution is required when recommending a component.

**Context7 vs WebFetch for SDK docs.** The OTel docs site rendered substantively via WebFetch (confirmed Go and JS pages return full content). Context7 is preferred for code examples and language-specific patterns where snippet density matters. Both are viable — use Context7 first for instrumentation code, WebFetch for doc structure and stability status.
