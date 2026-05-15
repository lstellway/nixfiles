# Software Reliability Agent — Sources

References that informed the heuristics in `software-reliability.md`.

## Existing Agents Reviewed

The following agents from [VoltAgent/awesome-claude-code-subagents](https://github.com/VoltAgent/awesome-claude-code-subagents) were reviewed for reliability-related content:

| Agent | Category | Relevance | Decision |
|---|---|---|---|
| `chaos-engineer` | Quality & Security | Direct overlap with chaos experiment design | Reviewed; not reused — agent file 404'd; chaos experiment methodology built from principlesofchaos.org directly |
| `sre-engineer` | Infrastructure | SLO/SLI, error budgets, on-call | Reviewed; not reused — agent file 404'd; SRE concepts sourced from Google SRE Book directly |
| `incident-responder` | Infrastructure | Incident response, escalation | Noted; scope is post-incident response, not pre-incident reliability design. Not adopted here. |
| `devops-incident-responder` | Infrastructure | DevOps incident management | Noted; deferred to DevOps agent boundary, not adopted |
| `performance-engineer` | Quality & Security | Latency optimization | Noted; latency optimization is explicitly deferred to Performance agent. Not adopted. |
| `error-detective` | Quality & Security | Error analysis, resolution | Noted; error analysis during incidents is out of scope. Not adopted. |
| `error-coordinator` | Meta & Orchestration | Error handling and recovery | Noted; recovery orchestration deferred to DevOps/Architecture agents. Not adopted. |

Agents not used and why:
- **`kubernetes-specialist`**: Kubernetes fault tolerance (pod restart policies, readiness/liveness probes) is deployment infrastructure — deferred to DevOps agent. Reliability agent stays at the pattern level, not the orchestrator config level.
- **`platform-engineer`**: Platform architecture decisions are Architecture agent scope.
- **`devops-engineer`**: Pipeline reliability and rollback mechanics are explicitly deferred to DevOps agent.

## Frameworks & Standards

### Version / Edition Pinning Table

| Source | Version / Edition / Date | Notes |
|---|---|---|
| Google SRE Book | First edition, 2016 (O'Reilly); freely available at sre.google | No second edition as of authoring. Chapters referenced: "Embracing Risk" (Ch. 3), "Eliminating Toil" (Ch. 5). |
| Google SRE Workbook | First edition, 2018 (O'Reilly); freely available at sre.google | Supplements the SRE Book with worked examples. |
| *Release It!* — Michael Nygard | Second edition, 2018 (Pragmatic Programmers, ISBN 978-1-68050-239-8) | Chapter 4 (stability antipatterns), Chapter 5 (stability patterns). Hystrix referenced as Netflix's original implementation; note that Hystrix is maintenance-mode — Resilience4j is the active successor. |
| Principles of Chaos Engineering | Last updated March 2019, principlesofchaos.org | No version number; snapshot date recorded. Five principles + four-step experimental methodology. |
| IEC 60812:2018 (FMEA/FMECA) | Third edition, 2018 | Supersedes IEC 60812:2006. Current standard for FMEA procedure. MIL-STD-1629A (1980) is the legacy military/aerospace predecessor; still referenced in defense contexts. |
| Fault Tree Analysis (IEC 61025) | IEC 61025:2006 | Standard methodology for FTA; five-step process cited in agent. |

### Primary Sources

- [Google SRE Book — Embracing Risk](https://sre.google/sre-book/embracing-risk/) — Error budget concept: the delta between SLO and actual performance is the budget of permitted unreliability. 100% is never the right target. Cost-reliability non-linearity: each additional nine costs approximately 10× the previous. Availability measurement via request success rate, not uptime.
- [Google SRE Book — Eliminating Toil](https://sre.google/sre-book/eliminating-toil/) — Toil definition: manual, repetitive, automatable, tactical, lacking enduring value, linearly scaling. SRE toil cap: no more than 50% of time on operational work. Characteristics used directly in the Toil & Operational Load section.
- [Google SRE Book — Service Level Objectives](https://sre.google/sre-book/service-level-objectives/) — SLI/SLO/SLA distinction; setting targets based on user impact; measuring SLIs from real traffic rather than synthetic probes.
- [Google SRE Workbook — Error Budget Policy](https://sre.google/workbook/error-budget-policy/) — Burn rate thresholds and the policy consequence model (release freeze, reliability work prioritization when budget is exhausted).
- [Principles of Chaos Engineering](https://principlesofchaos.org/) — The four-step methodology (steady state → hypothesis → failure variable → disprove hypothesis) and five advanced principles. Used directly as the structure for the Chaos Engineering section. Last updated March 2019 — no newer version found as of authoring.
- [*Release It!* 2nd Edition — Stability Patterns (Chapter 5)](https://www.oreilly.com/library/view/release-it-2nd/9781680504552/f_0047.xhtml) — Twelve stability patterns catalogued by name: Timeout, Circuit Breaker, Bulkheads, Steady State, Fail Fast, Let It Crash, Handshaking, Test Harnesses, Decoupling Middleware, Shed Load, Create Back Pressure, Governor. All twelve are addressed in the agent.
- [*Release It!* 2nd Edition — Stability Antipatterns (Chapter 4)](https://github.com/csabapalfi/release-it/blob/master/2-stability_antipatterns.md) — Ten antipatterns: Integration Points, Chain Reaction, Cascading Failures, Blocked Threads, Attacks of Self-Denial, Scaling Effects, Unbalanced Capacities, Slow Responses, SLA Inversion, Unbounded Result Sets. All ten addressed in the agent.
- [IEC 60812:2018 — Failure Modes and Effects Analysis](https://webstore.iec.ch/en/publication/26359) — Current edition of the FMEA standard. Seven-step FMEA process adapted for software reliability context in the agent. Third edition; supersedes 2006 version.
- [Fault Tree Analysis — Wikipedia / NTNU Chapter 5](https://en.wikipedia.org/wiki/Fault_tree_analysis) — Five-step FTA process: define top-level event, construct tree, identify minimal cut sets, qualitative analysis, quantitative analysis. AND/OR gate logic and single-point-of-failure identification.
- [Netflix/Hystrix GitHub](https://github.com/Netflix/Hystrix) — Netflix's original circuit breaker, bulkhead, and timeout library. Now in maintenance mode. Final release 1.5.18. Modern successor: Resilience4j. Referenced for historical context on the pattern lineage; agent heuristics are pattern-level and implementation-agnostic.
- [Resilience4j](https://resilience4j.readme.io/) — Active successor to Hystrix for JVM. Supports: circuit breaker, rate limiter, retry, bulkhead, time limiter, cache. Referenced as the current implementation-level library.
- [uptime.is — SLA & Uptime Calculator](https://uptime.is/) — Source for the nines table. Annual downtime values for 99% through 99.999% confirmed against this calculator.

## What Was Not Used and Why

| Source / Concept | Reason not adopted |
|---|---|
| **DORA metrics** (deployment frequency, lead time, change failure rate, recovery time) | DORA metrics are primarily deployment/DevOps pipeline metrics. Change failure rate and recovery time are covered in the DevOps agent. Reliability agent stays at architecture and pattern level, not pipeline metrics. |
| **Chaos Monkey / Simian Army** (Netflix) | These are implementation tools, not a methodology. The methodology is covered by Principles of Chaos Engineering. Tool-specific guidance would be stale as Netflix's tooling has evolved significantly. |
| **Resilience4j / specific library configuration** | Agent is intentionally implementation-agnostic. Specific library configuration (Resilience4j thresholds, Hystrix commands) would tie the agent to a single language/framework. Pattern-level guidance is more broadly applicable. |
| **SRE Workbook — Alerting on SLOs (burn rate thresholds)** | Burn rate alerting (14.4× / 6× / 1× thresholds) is in scope for the Observability agent, not the Reliability agent. Reliability agent covers *what SLO to set* and *whether it's achievable*; Observability agent covers *how to alert on budget burn*. |
| **Failure injection tools** (Gremlin, AWS Fault Injection Simulator, Chaos Toolkit) | Tool-specific guidance ages quickly. The chaos engineering section covers methodology; tool selection is implementation-specific and context-dependent. |
| **MIL-STD-1629A** | The 1980 military standard is the FMEA predecessor. IEC 60812:2018 is the current general-purpose standard and was used instead. MIL-STD-1629A remains relevant for defense/aerospace but is too domain-specific for a general reliability agent. |
| **Formal availability modeling** (Markov chains, reliability block diagrams) | These require failure rate data that is rarely available in software engineering contexts. The serial product and parallel formula in the agent cover the practical cases. Full stochastic modeling deferred to specialized reliability engineering tooling. |
| **SRE Team Structure / on-call rotation design** | Organizational patterns (embedded vs. centralized SRE, on-call rotation size) are Management/DevOps scope, not software reliability patterns. Not adopted. |

---

## Design Doc Notes

Three patterns observed during authoring that may benefit future agent files:

1. **Bidirectional scope statements are essential for adjacent-agent handoffs.** The observability agent demonstrated this well: each defer statement names what stays *and* what leaves. For reliability, the hardest boundary was Architecture: reliability analysis surfaces blast radius and failure isolation consequences of architectural choices. The resolution — "surface the gap, name it as needing Architecture, direct to Architecture agent" — avoids both silent scope creep and unhelpful deflection.

2. **Catalog names should appear verbatim in heuristics, not as concept labels.** Writing "check for the Circuit Breaker pattern" is less useful to the model than writing "is a circuit breaker present on calls to any dependency that can fail independently... it has three states: closed, open, half-open." Future agent authors should resist abstracting away the catalog name into a concept; the name is the retrieval key.

3. **Availability math is more useful as executable formulas than as narrative.** The nines table and the serial product formula are reference material that a model can apply directly to a specific architecture. Narrative descriptions of "the cost of reliability" are less useful without the formula. Where reliability frameworks provide math (error budget = `(1 - SLO) × window`, dependency product = `A_1 × A_2 × ... × A_n`), embed the formula directly in the heuristic rather than describing it in prose.
