# Data Integrity Agent — Sources

References that informed the heuristics in `software-data-integrity.md`.

## Existing Agents & Skills Consulted

- [VoltAgent awesome-claude-code-subagents — postgres-pro](https://github.com/VoltAgent/awesome-claude-code-subagents/blob/main/categories/05-data-ai/postgres-pro.md) — phase-based operational workflow, quantified outcome framing; informed the migration review output structure
- [VoltAgent awesome-claude-code-subagents — database-administrator](https://github.com/VoltAgent/awesome-claude-code-subagents/blob/main/categories/03-infrastructure/database-administrator.md) — checklist-based validation approach; confirmed zero-downtime migration as a scope item
- `software-architecture.md` (peer agent) — output format conventions (tagged findings, assumptions section, what's-working section); scope boundary pattern (explicit defer-to list)

## Frameworks Surveyed

### ACID & Transactions
- [ACID Properties — Wikipedia](https://en.wikipedia.org/wiki/ACID) — canonical definitions; informed transaction boundaries and isolation level heuristics
- [CAP, PACELC, ACID, BASE — ByteByteGo](https://blog.bytebytego.com/p/cap-pacelc-acid-base-essential-concepts) — BASE transactions and CAP theorem tradeoffs; informed distributed consistency section framing
- [ACID Compliance — Airbyte](https://airbyte.com/data-engineering-resources/transactional-databases-explained-acid-properties-and-best-practice) — practical ACID application checklist; informed the transaction boundary questions

### Distributed Consistency & Sagas
- [Saga Design Pattern — Azure Architecture Center](https://learn.microsoft.com/en-us/azure/architecture/patterns/saga) — compensating transaction requirements, isolation lack as a structural property of sagas
- [Saga Pattern — microservices.io (Chris Richardson)](https://microservices.io/patterns/data/saga.html) — countermeasures for isolation gaps; outbox pattern reference; idempotency key requirement
- [Mastering Saga Patterns — Temporal](https://temporal.io/blog/mastering-saga-patterns-for-distributed-transactions-in-microservices) — saga length heuristic (< 5–7 steps), step idempotency, stuck saga monitoring; directly sourced the saga step count recommendation
- [Saga Choreography — AWS Prescriptive Guidance](https://docs.aws.amazon.com/prescriptive-guidance/latest/cloud-design-patterns/saga-choreography.html) — choreography vs. orchestration tradeoffs

### Event Sourcing
- [Event Sourcing Pattern — Azure Architecture Center](https://learn.microsoft.com/en-us/azure/architecture/patterns/event-sourcing) — append-only store guarantees, event immutability, compensating events for corrections
- [Idempotency in CQRS/ES Projections — Medium (Arsalan Valoojerdi)](https://medium.com/@arsalan.valoojerdi/idempotency-in-cqrs-es-projections-strategies-and-implementation-techniques-e21a7cd06575) — ProcessedEvents table pattern, checkpoint + idempotent upsert as complementary strategies
- [Dealing with Eventual Consistency and Idempotency in MongoDB Projections — Event-Driven.io](https://event-driven.io/en/dealing_with_eventual_consistency_and_idempotency_in_mongodb_projections/) — at-least-once delivery as the default assumption, sequence number checkpointing

### Schema Design & Normalization
- [Database Normalization — DigitalOcean](https://www.digitalocean.com/community/tutorials/database-normalization) — 1NF–BCNF definitions with worked examples; directly informed the repeating groups and partial dependency heuristics
- [Understanding Database Normalization: 1NF to BCNF — Medium (Artem Khrienov)](https://medium.com/@artemkhrenov/understanding-database-normalization-from-1nf-to-bcnf-3893fac16fc9) — BCNF practical rarity heuristic ("matters exactly twice in thirty years"); confirmed 3NF as the practical target
- [Normalization vs Denormalization — CelerData](https://celerdata.com/glossary/normalization-vs-denormalization-the-trade-offs-you-need-to-know) — "normalize early for correctness, denormalize later for measured performance"; directly sourced the denormalization-without-sync-strategy anti-pattern framing
- [Database Design Principles — Exasol](https://www.exasol.com/hub/database/design-principles/) — JSON-as-catch-all pattern; typed column preference for queried JSON fields

### Constraints & Referential Integrity
- [Foreign Key Constraints — Software Patterns Lexicon](https://softwarepatternslexicon.com/sql/data-integrity-and-validation-patterns/enforcing-data-integrity-with-constraints/foreign-key-constraints/) — TOCTOU race for application-only uniqueness; FK enforcement gap for bulk imports
- [Referential Integrity — Accel Data](https://www.acceldata.io/blog/referential-integrity-why-its-vital-for-databases) — orphaned record formation mechanism; ON DELETE CASCADE unintended data loss scenarios
- [Cascade Delete — EF Core / Microsoft Learn](https://learn.microsoft.com/en-us/ef/core/saving/cascade-delete) — soft-delete + cascade conflict; shared-reference cascade risk pattern

### Migration Safety
- [Database Migration Tools: Flyway, Liquibase, Alembic — dasroot.net](https://dasroot.net/posts/2026/04/database-migration-tools-flyway-liquibase-alembic/) — one-logical-change-per-script atomicity principle; version alignment and checksum integrity
- [Zero-Downtime Migrations: Liquibase + Spring Boot — Medium (Kanha Aggarwal)](https://medium.com/@kanhaaggarwal/zero-downtime-migrations-how-i-replaced-flyway-scripts-with-liquibase-spring-boot-f98ca3534a68) — expand-contract pattern for zero-downtime column changes
- [Database Migration Testing: Flyway and Liquibase Guide — yrkan.com](https://yrkan.com/blog/database-migration-testing/) — schema validation, rollback procedure testing, shadow database pattern
- [Flyway Database Migrations in 2026 — DeployHQ](https://www.deployhq.com/blog/master-your-database-migrations-with-flyway-a-comprehensive-guide-for-all-projects) — ADD COLUMN NOT NULL locking behavior; baseline-first adoption requirement
- [Atlas vs Classic Schema Migration Tools — AtlasGo](https://atlasgo.io/atlas-vs-others) — comparison of migration safety guarantees across tools; drift detection pattern

### Validation Strategy
- [Database Constraints vs Application Validation — Medium (Diwakar Patel)](https://medium.com/@diwakarpatelsatya/database-constraints-vs-application-validation-the-ultimate-developers-guide-2fe31ed05e2a) — DB constraints as authoritative backstop; application validation for UX feedback; directly sourced the hybrid strategy framing
- [Validation, Database Constraint, or Both? — Thoughtbot](https://thoughtbot.com/blog/validation-database-constraint-or-both) — ORM validation bypass via direct DB access; TOCTOU uniqueness race condition; informed the "constraints at both layers" recommendation
- [Relying on the Database to Validate Your Data — Matthias Noback](https://matthiasnoback.nl/2020/07/relying-on-the-database-to-validate-your-data/) — argument for DB as the authoritative validation boundary; informed the decision-making frame in the agent persona

### Data Type & Precision
- [Floats Don't Work For Storing Cents — Modern Treasury](https://www.moderntreasury.com/journal/floats-dont-work-for-storing-cents) — binary representation of 0.1; rounding accumulation in summation; directly sourced the FLOAT/DOUBLE for money finding
- [Never Use Float and Double for Monetary Calculations — DZone](https://dzone.com/articles/never-use-float-and-double-for-monetary-calculatio) — BigDecimal vs. integer cents tradeoffs; scale specification requirement for NUMERIC
- [Storing Currency Values: Data Types, Caveats, Best Practices — cardinalby.github.io](https://cardinalby.github.io/blog/post/best-practices/storing-currency-values-data-types/) — integer cents storage pattern; NUMERIC precision/scale specification

### Soft Deletes & Audit Trails
- [Deleting Data: Soft, Hard or Audit? — Marty Friedel](https://www.martyfriedel.com/blog/deleting-data-soft-hard-or-audit) — UNIQUE constraint conflict with soft deletes; partial index as the fix; serialized representation on hard delete as an alternative pattern
- [Immutable Audit Trails: A Complete Guide — Hubifi](https://www.hubifi.com/blog/immutable-audit-log-basics) — write-once storage requirement; separation of audit log from operational table
- [Rails Soft Delete & Audit Logging Guide — sulmanweb.com](https://sulmanweb.com/rails-soft-delete-audit-logging-implementation) — global scope missing filter as a recurring bug vector; `deleted_at` timestamp preference over boolean flag

## Martin Fowler References

- [Patterns of Enterprise Application Architecture — Catalog](https://martinfowler.com/eaaCatalog/) — Unit of Work (transaction boundary coordination), Identity Map (preventing duplicate object loads), Data Mapper (domain/persistence separation), Active Record vs. Data Mapper tradeoffs; informed transaction boundary and ORM-level constraint heuristics
- [Patterns of Enterprise Application Architecture — Book](https://martinfowler.com/books/eaa.html) — offline concurrency patterns (optimistic vs. pessimistic locking); informed the SELECT FOR UPDATE and version column heuristics
