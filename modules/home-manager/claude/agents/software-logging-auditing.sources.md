# Sources: software-logging-auditing.md

## Agents & Skills Consulted

**VoltAgent/awesome-claude-code-subagents** (https://github.com/VoltAgent/awesome-claude-code-subagents)
- Reviewed agent index for existing logging, auditing, and observability subagents
- Found: `security-auditor`, `compliance-auditor`, `devops-incident-responder`, `sre-engineer`, `error-coordinator`, `error-detective`
- No dedicated logging or audit trail agent existed — confirmed the gap this agent fills
- Noted that the security-related agents skew toward infrastructure hardening and AD; none addressed application-layer logging schema, audit trail design, or retention policy

**Existing peer agents in this project**
- `software-security.md` — reviewed to identify overlap in the "Security Logging & Audit Trails" sub-section; scope boundary between security agent (which events warrant logging, threat detection) and this agent (that events are logged, log structure, retention, integrity) was derived from this overlap
- `software-architecture.md`, `software-api-design.md` — consulted for output format conventions, defer/scope language, persona framing style, and evidence-anchoring requirement

---

## Frameworks Surveyed

### OWASP Logging Cheat Sheet
https://cheatsheetseries.owasp.org/cheatsheets/Logging_Cheat_Sheet.html
Primary source for:
- Events that must always be logged (authentication, authorization, session, system events, high-risk operations)
- Required event attribute taxonomy (When/Where/Who/What → `timestamp`, `source_ip`, `user.id`, `event.type`)
- Data to exclude from logs (passwords, tokens, PAN, keys, connection strings)
- Log storage and protection recommendations (separate partition, restrict write access, no web-accessible locations)
- Log injection sanitization requirements (CRLF, encoding)
- Known attack vectors: confidentiality, integrity, availability, accountability

### OWASP Application Logging Vocabulary Cheat Sheet
https://cheatsheetseries.owasp.org/cheatsheets/Logging_Vocabulary_Cheat_Sheet.html
Primary source for:
- Standardized event type taxonomy used in "What to Log" section:
  - `[AUTHN]`: login success/fail, lockout, impossible travel, token create/revoke
  - `[AUTHZ]`: access denied, permission change, admin actions
  - `[SESSION]`: created, renewed, expired, use-after-expire
  - `[DATA]`: sensitive_create/read/update/delete
  - `[USER]`: user_created/updated/archived/deleted
  - `[SYS]`: startup/shutdown/crash/monitor events
  - `[INPUT]`: input_validation_fail
  - `[EXCESS]`: rate_limit_exceeded
  - `[UPLOAD]`: upload_complete/stored/validation/delete
  - `[MALICIOUS]`: excess_404, attack_tool, sqli, cors, direct_reference
  - `[PRIVILEGE]`: permissions_changed
  - `[CRYPT]`: decrypt_fail, encrypt_fail
  - `[MCP]`: prompt_injection, resource_exhaustion, tool_poisoning (newly added category in 2025)

### OWASP Application Security Verification Standard (ASVS) v5.0.0
https://owasp.org/www-project-application-security-verification-standard/
https://raw.githubusercontent.com/OWASP/ASVS/v5.0.0/5.0/en/0x25-V16-Security-Logging-and-Error-Handling.md

Note: ASVS 5.0.0 was released May 30, 2025. Logging requirements moved from V7 (4.x) to **V16** in 5.0.

V16 requirements mapped into agent sections:

| Requirement ID | Level | Agent Section |
|---|---|---|
| 16.1.1 | L2 | Audit Trail Design — log inventory requirement |
| 16.2.1 | L2 | Structured Logging & Schema — when/where/who/what metadata |
| 16.2.2 | L2 | Structured Logging & Schema — timestamp UTC/offset requirement |
| 16.2.3 | L2 | Audit Trail Design — log only to documented destinations |
| 16.2.4 | L2 | Structured Logging & Schema — common format for log processor |
| 16.2.5 | L2 | PII & Sensitive Data — logging based on data protection level |
| 16.3.1 | L2 | What to Log — all authentication operations |
| 16.3.2 | L2 | What to Log — failed authorization |
| 16.3.3 | L2 | What to Log — documented security events + bypass attempts |
| 16.3.4 | L2 | What to Log — unexpected errors and TLS failures |
| 16.4.1 | L2 | Log Integrity — log injection encoding |
| 16.4.2 | L2 | Log Integrity — tamper protection |
| 16.4.3 | L2 | Log Integrity — transmission to separate system |
| 16.5.1 | L2 | (deferred to Security agent — error handling) |
| 16.5.2–16.5.4 | L2–L3 | (deferred to Security agent — error handling) |

### OpenTelemetry Logging Specification
https://opentelemetry.io/docs/specs/otel/logs/
https://opentelemetry.io/docs/specs/otel/logs/data-model/
https://opentelemetry.io/docs/specs/otel/logs/supplementary-guidelines/

LogRecord schema fields incorporated into Structured Logging & Schema section:

| Field | Type | Used In Agent |
|---|---|---|
| `Timestamp` | uint64 ns since epoch | timestamp requirement |
| `ObservedTimestamp` | uint64 ns since epoch | (noted but not surfaced as check) |
| `TraceId` | byte sequence (W3C) | correlation — `trace_id` |
| `SpanId` | byte sequence | correlation — `span_id` |
| `TraceFlags` | byte | (implementation detail, not surfaced) |
| `SeverityText` | string | level discipline |
| `SeverityNumber` | number | level discipline — TRACE(1-4), DEBUG(5-8), INFO(9-12), WARN(13-16), ERROR(17-20), FATAL(21-24) |
| `Body` | AnyValue | message field |
| `Resource` | Resource | service, environment fields |
| `Attributes` | Attribute Collection | all structured key-value fields |
| `EventName` | string | event type taxonomy |

OTel semantic conventions for logs (development status as of May 2026):
- `log.record.uid` — unique log record identifier
- `log.file.name` / `log.file.path` — file-based log source identification

W3C Trace Context propagation (`traceparent` header) referenced in Correlation section for distributed trace ID format.

### Elastic Common Schema (ECS)
https://www.elastic.co/guide/en/ecs/current/ecs-field-reference.html

Field sets referenced for schema alignment recommendation in Structured Logging & Schema section:

| ECS Field Set | Key Fields Noted |
|---|---|
| `event.*` | `event.action`, `event.outcome`, `event.type` |
| `log.*` | `log.level`, `log.logger` |
| `trace.*` | `trace.id` |
| `http.*` | `http.request.method`, `http.response.status_code` |
| `user.*` | `user.id`, `user.name` |
| `error.*` | `error.type`, `error.message`, `error.stack_trace` |
| `process.*` | `process.pid` |
| `host.*` | `host.name` |

ECS noted as a concrete naming standard to recommend when a team asks what field names to use.

### NIST SP 800-92 / 800-92r1
https://csrc.nist.gov/pubs/sp/800/92/final
https://csrc.nist.gov/pubs/sp/800/92/r1/ipd

- SP 800-92 (2006): foundational guidance on log management processes — generation, transmission, storage, analysis, disposal. Log integrity and confidentiality protection requirements incorporated into Log Integrity section.
- SP 800-92r1 (initial public draft, 2023): draft revision motivated by OMB M-21-31 (EO 14028 on federal cyber incident response). Key additions noted: playbook model for log management planning, coverage consistency across hybrid/multi-cloud environments, telemetry assurance for validating log authenticity against adversarial manipulation (MITRE ATT&CK reference), and risk-based retention (base on threat hunting / DFIR requirements, not just cost).
- Note: 800-92r1 was in draft/public comment status as of late 2023; final publication status as of May 2026 was not confirmed via web fetch (PDF binary was not parseable). Guidance incorporated is from the draft and public commentary.

### PCI DSS 4.0.1
https://pcidssguide.com/pci-dss-requirement-10/
https://nxlog.co/news-and-blog/posts/pci-dss-log-collection-compliance

Requirement 10 incorporated into Retention & Rotation and Audit Trail Design sections:

| Sub-requirement | Agent Section |
|---|---|
| Req 10.2: automatic audit trails for all system components | What to Log — required events list |
| Req 10.2.2: audit log fields (user ID, event type, date/time, success/fail, origination) | Audit Trail Design — actor/action/outcome/timestamp/source_ip |
| Req 10.2.1: specific events (cardholder data access, admin actions, log access, failed logins, auth mechanism changes, object creation/deletion, log enable/disable) | What to Log — required events |
| Req 10.7: 12-month retention, 3 months immediately available | Retention & Rotation — compliance floor table |

Current version confirmed as PCI DSS 4.0.1 (via PCI SSC document library, May 2026).

---

## Design Principles Applied

Following conventions from peer agents in this project:

- **Persona as decision-making frame**: "You treat logs as the ground truth of what a system actually did — if it wasn't logged, it didn't happen" shapes how the model prioritizes findings. It is a reasoning posture, not an expertise claim.
- **Non-blocking context**: Context section explicitly says "state your assumptions and proceed" to prevent the agent from stalling on incomplete inputs.
- **Evidence anchoring**: "Every response must cite specific log statements, fields, functions, or config keys" — carried forward from `software-security.md` convention and made concrete for the logging domain.
- **Specificity test applied to every heuristic**: each bullet is phrased as an observable, actionable check derivable from code, config, log sample, or diff — not a concept label. For example: "Flag any logger that requires manual ID passing" is actionable; "Check correlation ID handling" is not.
- **Explicit scope deferrals**: Security, Observability, Data Privacy, DevOps, and Compliance are each named with a specific split of what stays here vs. what defers there. The split is asymmetric by design: this agent covers the *application's emission* of log data; peer agents cover downstream handling.
- **Task-adaptive output**: four named modes with distinct structures. Each mode was chosen to match a realistic invocation scenario: code review, existing system audit, new feature design, and compliance review. The modes parallel those in `software-security.md` to maintain cross-agent consistency.

## Design Doc Notes

**Split pattern for cross-cutting concerns**: Several standards (OWASP Logging Cheat Sheet, ASVS V16) bundle what-to-log together with how-to-detect-threats-in-logs and how-to-ship-logs. The pattern that worked well here: define the split at the *application boundary*. This agent covers what the application emits and how it structures that emission. Agents downstream (Observability, Security) handle what happens to the data after emission. This boundary is durable — it holds regardless of how the shipping or detection infrastructure changes.

**Versioned standards require version checking**: ASVS 5.0 moved logging from V7 to V16. Any agent that references a versioned standard by section number should note the version explicitly and flag if the section path was confirmed at authoring time. The fetch of the old `0x15-V7-Error-Logging.md` path returned 404 (it no longer exists at that path in v5.0); the correct path is `0x25-V16-Security-Logging-and-Error-Handling.md`. Future agents referencing ASVS should start from the v5.0 chapter structure, not the 4.x chapter structure.

**PII in logs requires a deferred handoff, not full silence**: The agent surfaces PII risk (what fields may carry personal data, what correlation attacks look like) but explicitly defers remediation guidance to the Data Privacy agent. This pattern — surface-then-defer — prevents the agent from either ignoring PII entirely or overreaching into data governance territory. It is the right pattern for any concern that is relevant to this agent's output but whose remediation requires depth from a specialized peer agent.
