# Performance Agent — Sources

References that informed the heuristics in `software-performance.md`.

---

## Step 1 — Existing Agents & Skills Survey

**VoltAgent/awesome-claude-code-subagents** (https://github.com/VoltAgent/awesome-claude-code-subagents)

Reviewed via web fetch of the repository index. Performance-related agents found:

| Agent | Category | What it covers |
|---|---|---|
| `performance-engineer` | 04-quality-security | General optimization across profiling, database, and infrastructure; workflow-oriented with phases (analyze → implement → achieve SLA) |
| `database-optimizer` | 05-data-ai | Database query optimization, index strategy, execution plan analysis across multiple DB systems; targets sub-100ms query time |
| `performance-monitor` | 09-meta-orchestration | Agent-level (meta) performance optimization, not software performance |

**What was NOT found and why:**

- No dedicated frontend performance agent covering Core Web Vitals, asset loading, or render blocking. The `frontend-developer` agent covers UI/UX but not performance metrics.
- No caching strategy specialist — caching appears only incidentally in the `database-optimizer` agent.
- No memory profiling / leak detection agent.
- No agent covering the N+1 pattern specifically, batch processing patterns, or connection pool sizing heuristics.
- The `performance-engineer` agent is workflow-framed ("phases") rather than heuristic-framed — it describes what the agent does procedurally rather than providing executable checks derivable from code, query plans, or config. This agent fills that gap with specific, detectable patterns.
- The `database-optimizer` agent targets specific numeric SLAs (sub-100ms, 95% index usage) without tying them to context — thresholds that are reasonable for OLTP but not for analytical queries or bulk operations. This agent contextualizes thresholds against use case.

**Existing peer agents in this project** — reviewed for style and scope boundaries:

- `software-architecture.md` — bidirectional scope deferrals, surface-then-defer pattern for cross-cutting concerns, ADR output format
- `software-observability.md` — RED/USE method coverage, evidence anchoring requirement, metric-name-level specificity
- `software-code-quality.md` — Fowler smell catalog approach, cognitive complexity thresholds, persona as decision-making frame
- `software-data-integrity.md` — schema-level heuristics, defer boundary with performance implications of schema choices
- `software-logging-auditing.sources.md` — design principle notes, versioned standards version-checking pattern

---

## Step 2 — Framework & Standard Survey

### Core Web Vitals
https://web.dev/articles/vitals  
https://web.dev/articles/inp  
https://web.dev/articles/optimize-lcp

**Version/date pinning table:**

| Metric | Replaces | Stable Since | Good | Needs Improvement | Poor |
|---|---|---|---|---|---|
| LCP (Largest Contentful Paint) | — | Original CWV launch (2020) | ≤ 2.5s | 2.5–4s | > 4s |
| INP (Interaction to Next Paint) | FID (First Input Delay) | March 2024 | ≤ 200ms | 200–500ms | > 500ms |
| CLS (Cumulative Layout Shift) | — | Original CWV launch (2020) | ≤ 0.1 | 0.1–0.25 | > 0.25 |

**Note on FID replacement**: FID measured only the delay before the browser began processing the *first* interaction. INP measures the latency of *all* click, tap, and keyboard interactions throughout the page visit, reporting the worst (or near-worst) value. INP became a pending Core Web Vital in 2023 and a stable Core Web Vital in March 2024. Any agent referencing FID as a current Core Web Vital is out of date.

**Key heuristics derived:**
- `fetchpriority="high"` on LCP image vs. `loading="lazy"` (always wrong on LCP element)
- `font-display` and layout-shift causes from dynamic content injection
- Long tasks > 50ms as INP contributor, forced synchronous layouts from read-after-write pattern

### RAIL Model
https://web.dev/articles/rail  
Last updated: 2020-06-10

| Category | Threshold | Notes |
|---|---|---|
| Response | ≤ 100ms total; ≤ 50ms processing | User perceives action as immediate below 100ms |
| Animation | ≤ 10ms per frame | 16ms technical max minus ~6ms browser overhead |
| Idle | 50ms idle task chunks | Preserve responsiveness during background work |
| Load | ≤ 5s interactive (first); ≤ 2s (subsequent) | Mid-range mobile, slow 3G baseline |

**Note**: The web.dev RAIL article itself states that Core Web Vitals is the newer recommended measurement framework, and RAIL is now a conceptual / design-time model. The agent uses RAIL as a design heuristic (animation frame budgets, idle task sizing) while using Core Web Vitals as the primary field measurement standard.

### Brendan Gregg — USE Method
https://www.brendangregg.com/usemethod.html  
https://www.brendangregg.com/USEmethod/use-linux.html

USE = Utilization, Saturation, Errors — applied per resource.

| Term | Definition | When to flag |
|---|---|---|
| Utilization | % busy over a time interval | Near or at 100% (70%+ for disk I/O causes queueing) |
| Saturation | Queue length / wait time | Any non-zero saturation warrants investigation |
| Errors | Count of discrete error events | Non-zero is always worth investigating |

The USE Method resolves approximately 80% of server-side performance issues as a systematic early sweep. Used in this agent primarily to inform the connection/thread pool section and scope boundary with Observability (what to measure vs. how to instrument).

### Brendan Gregg — Systems Performance (2nd Edition, 2020)
https://www.brendangregg.com/blog/2020-07-15/systems-performance-2nd-edition.html

Key tools and methodologies noted for agent awareness:
- Flame graphs for CPU profiling hotspot identification
- BPF/eBPF tools (BCC, bpftrace) for off-CPU analysis, syscall tracing, memory allocation profiling
- `perf` for Linux CPU and cache performance counters
- Heat maps and frequency trails for latency distribution visualization
- Off-CPU analysis for blocking I/O and lock contention (distinct from on-CPU profiling)

These inform the agent's emphasis on profiling evidence before flagging memory/CPU findings, and the recommendation to specify *what* to measure in each finding.

### Database Query Performance
https://use-the-index-luke.com/sql/preface  
"Use the Index, Luke" by Markus Winand (web edition, continually updated)

Key heuristics derived:
- B-tree index structure and leading column rule for composite indexes
- Function calls on indexed columns preventing index use
- Write amplification from over-indexing
- Covering index pattern for high-frequency narrow-column queries
- The developer's role in indexing: developers know access patterns; DBAs know the engine — indexing requires both

### Azure Architecture — Performance Antipatterns
https://learn.microsoft.com/en-us/azure/architecture/antipatterns/  
Last updated: 2023-12-13

Full catalog of antipatterns surveyed:

| Antipattern | Summary | Agent Section |
|---|---|---|
| Busy Database | Offloading processing to data store | Database Query Patterns, Serialization & I/O |
| Busy Front End | Resource-intensive tasks blocking foreground | Thread Pooling, Batch Processing |
| Chatty I/O | Many small network requests | Serialization & I/O |
| Extraneous Fetching | Fetching more data than needed | Database Query Patterns, Serialization & I/O |
| Improper Instantiation | Recreating shared/reusable objects | Memory & Allocation |
| Monolithic Persistence | Single data store for dissimilar workloads | (deferred to Architecture) |
| No Caching | Failing to cache cacheable data | Caching Strategy |
| Noisy Neighbor | Single tenant consuming disproportionate resources | (deferred to Reliability) |
| Retry Storm | Excessive retry pressure on a failing server | (deferred to Reliability/Architecture) |
| Synchronous I/O | Blocking thread during I/O | Connection & Thread Pooling, Serialization & I/O |

### Google SRE — Performance Context
https://sre.google/sre-book/  

Used to anchor the decision hierarchy (measure → profile → fix) and to validate the scope boundary with Observability. The observability agent owns SLO definition, error budget, and burn rate alerting; this agent owns the performance root cause analysis that feeds into whether an SLO is achievable.

---

## Step 7 — Fresh-Eyes Review Notes

Traced the following realistic invocations cold:

**"Is this ORM change going to cause an N+1?"**  
→ N+1 detection section provides specific ORM syntax signals per framework (ActiveRecord, Hibernate, SQLAlchemy). Executable from a code diff. ✓

**"Our LCP is 4.2 seconds in field data — where do I start?"**  
→ LCP section breaks into four subparts (TTFB, resource load delay, resource load duration, element render delay) with specific HTML attributes and config checks per subpart. Actionable without additional context. ✓

**"The database CPU is at 90% — what should I look at?"**  
→ Query plan section covers sequential scans, hash join memory spill, stale statistics. Advises ANALYZE on stale stats. Scope boundary correctly defers "scale the database" to Architecture. ✓

**"We're leaking memory somewhere — can you help?"**  
→ Memory section covers event listener accumulation (with framework-specific lifecycle hook names), growing caches, unbounded result sets, and string concatenation. Explicitly requires profiling evidence to escalate to High. ✓

**Persona frame check**: "You treat performance as a user experience problem first" — shapes the LCP/INP/CLS detail level (user-facing), the de-emphasis of micro-optimization without measurement, and the decision hierarchy (measure → profile → fix). The frame is visible in prioritization, not just the opening sentence. ✓

**Bidirectional scope deferrals check**: Each defer statement names what stays (e.g., "Stay here: query performance implications of schema choices") and what leaves ("Defer to Data Integrity: schema correctness, migration safety"). ✓

---

## Step 8 — Version/Date Pinning Summary

| Spec / Framework | Version / Date Confirmed | Key Change to Note |
|---|---|---|
| Core Web Vitals — INP | Stable: March 2024 | Replaced FID; measures all interactions, not just first |
| Core Web Vitals — LCP | Original (2020); thresholds unchanged | — |
| Core Web Vitals — CLS | Original (2020); thresholds unchanged | — |
| RAIL Model | Last updated 2020-06-10 | Now conceptual/design-time; CWV is primary measurement standard |
| USE Method | No version; continuously maintained | Brendan Gregg's site, permalink stable |
| Systems Performance (Gregg) | 2nd edition, 2020 | Adds BPF/eBPF tools vs. 1st edition |
| Azure Performance Antipatterns | 2023-12-13 | 10-antipattern catalog |
| Use the Index, Luke | Web edition (no version; continuously updated) | B-tree index focus |

---

## Design Doc Notes

Three patterns that emerged during authoring worth encoding for future agents:

**1. Threshold contextualization over bare thresholds.**  
Performance agents are tempted to state thresholds as absolutes ("queries should run under 100ms"). This agent consistently contextualizes thresholds: "100ms for OLTP, not analytical queries"; "batch sizes of 100–1,000 for most OLTP workloads, then tune". Bare thresholds create false precision and produce noise findings in valid contexts. Future agents covering performance-adjacent topics should pair every threshold with its context condition.

**2. Evidence-gating for speculative findings.**  
Memory and CPU findings without profiling data are hypotheses. The agent explicitly gates memory findings at `[Info]` without profiling evidence and states what evidence would promote them to `[High]`. This pattern prevents the agent from producing a wall of speculative findings that a developer cannot act on. Future agents should consider: for each finding type, what evidence is required to escalate severity? State it explicitly.

**3. Surface-then-defer as a first-class pattern.**  
Performance issues frequently require architectural changes to fully resolve (a bottleneck that cannot be fixed within the service boundary). The agent encodes this as a named instruction in the scope section and in the output format: "Where a finding requires architectural change to resolve, flag it and direct to the Architecture agent." The key design decision is that the performance agent does not simply stop at the boundary — it characterizes the finding fully (cost, impact, nature) before deferring. Stopping at "this is an architecture problem" without characterization is not useful. Future cross-cutting agents should adopt the same surface-then-defer form: full characterization, then explicit handoff.
