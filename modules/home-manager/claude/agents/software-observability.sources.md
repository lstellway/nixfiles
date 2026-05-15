# Observability Agent — Sources

References that informed the heuristics in `software-observability.md`.

## Existing Agents & Skills

- [VoltAgent awesome-claude-code-subagents — sre-engineer](https://github.com/VoltAgent/awesome-claude-code-subagents/blob/main/categories/03-infrastructure/sre-engineer.md) — SLO/SLI implementation framing, error budget enforcement, burn rate monitoring patterns, on-call sustainability heuristics
- [VoltAgent awesome-claude-code-subagents — incident-responder](https://github.com/VoltAgent/awesome-claude-code-subagents/blob/main/categories/03-infrastructure/incident-responder.md) — incident context tooling, MTTD/MTTR, escalation path coverage

## Frameworks & Standards

- [Google SRE Book — Monitoring Distributed Systems](https://sre.google/sre-book/monitoring-distributed-systems/) — Four golden signals (latency, traffic, errors, saturation); alerting principles: every page must be actionable and require human judgment; the cost of false positives in degrading on-call quality
- [Google SRE Workbook — Alerting on SLOs](https://sre.google/workbook/alerting-on-slos/) — Multi-window, multi-burn-rate alerting approach; recommended thresholds (14.4× burn / 1h+5m, 6× burn / 6h+30m, 1× burn / 3d+6h); short window as 1/12 of long window rule; error budget ratio formula
- [Brendan Gregg — The USE Method](https://www.brendangregg.com/usemethod.html) — Utilization, Saturation, Errors per resource; per-resource checklist for CPU, memory, disk, network, and managed resources; USE as an early-investigation systematic sweep
- [Brendan Gregg — USE Method: Linux Performance Checklist](https://www.brendangregg.com/USEmethod/use-linux.html) — Concrete Linux resource metrics for each USE axis
- [OpenTelemetry Specification v1.56.0](https://opentelemetry.io/docs/specs/otel/) — Three signal types (traces, metrics, logs); context propagation (W3C traceparent); span kind semantics (SERVER, CLIENT, PRODUCER, CONSUMER); span status (OK, ERROR); exemplar specification
- [OpenTelemetry Semantic Conventions — HTTP Metrics](https://opentelemetry.io/docs/specs/semconv/http/http-metrics/) — Stable metric names `http.server.request.duration` and `http.client.request.duration`; stable attributes: `http.request.method`, `http.response.status_code`, `http.route`, `url.scheme`, `server.address`, `server.port`, `network.protocol.version`, `error.type`
- [OpenTelemetry Semantic Conventions — RPC](https://opentelemetry.io/docs/specs/semconv/rpc/) — `rpc.system`, `rpc.service`, `rpc.method`, `rpc.response.status_code`; release-candidate stability as of 2025 stabilization project
- [OpenTelemetry Semantic Conventions — Database](https://opentelemetry.io/docs/specs/semconv/database/) — `db.system`, `db.name`, `db.operation.name`; stabilized May 2025
- [OpenTelemetry — Declarative Configuration Stability](https://www.infoq.com/news/2026/04/opentelemetry-declarative-config/) — Key portions of declarative config spec reached stable status April 2026; informs Collector configuration guidance
- [DORA Metrics — dora.dev](https://dora.dev/guides/dora-metrics/) — Five current metrics: deployment frequency, lead time for changes, change failure rate, failed deployment recovery time (refined from MTTR in 2023 to focus on software-caused failures), deployment rework rate (added 2024)
- [DORA Metrics History — dora.dev](https://dora.dev/insights/dora-metrics-history/) — Evolution from four to five metrics; distinction between throughput metrics (deployment frequency, lead time) and stability metrics (change failure rate, recovery time)
- [Cindy Sridharan — Distributed Systems Observability (O'Reilly, 2018)](https://www.oreilly.com/library/view/distributed-systems-observability/9781492033431/) — Three pillars framing (metrics, tracing, logs); observability vs. monitoring distinction (complementary, not substitutes); failure modes in containerized systems requiring observability over alerting; 58% of catastrophic failures preventable by testing error-handling code

## Articles

- [Google Cloud — Alerting on Error Budget Burn Rate](https://docs.cloud.google.com/stackdriver/docs/solutions/slo-monitoring/alerting-on-budget-burn-rate) — Implementation reference for burn rate alert rules in Cloud Monitoring
- [Grafana Labs — Multi-Window Multi-Burn-Rate Alerts](https://grafana.com/blog/how-to-implement-multi-window-multi-burn-rate-alerts-with-grafana-cloud/) — Practical Grafana implementation of the Google SRE Workbook burn rate approach
- [Datadog — Burn Rate is a Better Error Rate](https://www.datadoghq.com/blog/burn-rate-is-better-error-rate/) — Why raw error rates produce alert fatigue; burn rate as a normalization against SLO target
- [OpenTelemetry 2026 Complete Guide — Calmops](https://calmops.com/devops/opentelemetry-observability-2026-complete-guide/) — Current OTel ecosystem state including Collector v1.49.0+, profiling signal progress, and declarative config stabilization
- [OTel Semantic Conventions 1.41.0 Overview](https://opentelemetry.io/docs/specs/semconv/) — Current semconv release; namespace index (General, HTTP, Database, RPC, Messaging, GenAI, CICD, FaaS, Cloud Providers)

## Design Doc Notes

Two patterns emerged during authoring that would benefit future agent files:

1. **Scope boundary phrasing that references both directions.** Each defer statement in this agent names *what stays* and *what leaves*, e.g., "Stay here for log-based metrics; defer log format to Logging & Auditing." Single-direction defers ("defer X to Y agent") leave ambiguity about whether the topic is fully out of scope or split. The bidirectional form is more useful to the model when it must decide in-context.

2. **Executable check formatting.** Heuristics that begin with a concrete noun (metric name, attribute key, config field) are easier for the model to apply than heuristics that begin with a concept label. Compare "Check cardinality" (concept) vs. "Check that `http.route` is used instead of `url.path` — a missing `http.route` attribute is a cardinality bomb" (concrete). Future agents benefit from this pattern: lead each check with the specific artifact or call site, then explain the principle.
