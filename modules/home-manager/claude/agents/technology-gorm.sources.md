# GORM Technology Expert — Sources

References that informed `technology-gorm.md`. Prioritizes Context7 (live-indexed against gorm.io and the `go-gorm/gorm` GitHub source) and the official `gorm.io/docs/` site, with `go doc` against the user's locally-installed GORM module promoted to the **top** of the lookup chain when a Go toolchain is available (fastest, version-correct).

## Version Calibration

- **GORM pinned**: **v1.31.1** (`gorm.io/gorm`), the current GORM v2 stable as of **2026-05-17**. Confirmed via `https://github.com/go-gorm/gorm/tags` (latest tag v1.31.1, released 2025-11-02) and `https://pkg.go.dev/gorm.io/gorm` (latest published version v1.31.1). The Generics API GA'd in v1.30.0 (2025-05-25); v1.30.4 added Set-based Create/Update; v1.31.0 added generics Set association ops + conditional bulk association updates; v1.31.1 added Allow Select/Omit for Generics Create.
- **GORM v1** (`github.com/jinzhu/gorm`) is end-of-life and frozen. Mentioned only as the legacy/migration-from context; all answers target v2 (`gorm.io/gorm`, semver tracked as v1.x).
- **Go version assumed**: any Go version supported by GORM's current minor (per its `go.mod` baseline). GORM 1.31.x targets Go 1.21+; the agent doesn't require pinning a specific Go version because the GORM API surface is largely Go-version-independent. Calibration note: the v1.30.4 changelog entry mentions a Go 1.21 compatibility fix, confirming Go 1.21 as the practical floor.
- **Drivers**: `gorm.io/driver/postgres` (current stable, pgx-backed since v1.5), `gorm.io/driver/mysql`, `gorm.io/driver/sqlite`, `gorm.io/driver/sqlserver`, `gorm.io/driver/clickhouse`. Calibration spans all five at current latest as of 2026-05-17.
- **Plugins referenced**: `gorm.io/plugin/dbresolver` (current latest), `gorm.io/plugin/opentelemetry`, `gorm.io/plugin/prometheus`, `gorm.io/plugin/optimisticlock`.
- **Date confirmed**: **2026-05-17**.

## Existing Agents and Skills Consulted

- **`agent-technology` SKILL.md** — followed all nine steps verbatim. Step 1's ternary triage classified GORM as **flat**: one coherent ORM library, one coherent doc site (gorm.io), one coherent semver line. The four sub-pieces (the runtime API, the drivers, the migration story, the plugins) are clearly secondary tooling around a single API surface — not co-equal sub-ecosystems like Docker's Engine/Compose/BuildKit. Real tasks rarely branch by sub-domain; "set up a connection," "write a query," and "diagnose slow Preload" all want the same approach strategy. Sub-sectioning would add noise without clarity.
- **`technology-go.md`** — read end-to-end. It already contains a GORM-focused subsection (in its Scope and Core Concepts), calibrated to v1.25.x for the codebase that hosts it. The new dedicated `technology-gorm.md` agent is calibrated to current v1.31.1 stable, written **general-purpose** (not codebase-specific), and covers the surface in far more depth (struct-tag reference table, four-association FK conventions, hook lifecycle table, session-flag table, Preload-vs-Joins decision rule, generics API, AutoMigrate trade-offs, migration-tool comparison table, plugin coverage). The Go agent's defer-block can be tightened in a future pass to delegate GORM questions to this new agent — noted as a follow-up, not done here to avoid touching the Go agent in this task.
- **`technology-mongodb.md`** — read end-to-end as the closest structural sibling (also a data-layer agent with a chainable API, struct-tag conventions in Mongoose, hook complexity, transactions, plugin ecosystem). Adopted: section ordering (Scope → Sources → Core Concepts → Approach → Output Format), the dual-axis persona (deep expertise + fetch-first), Context7-as-preferred-channel convention, the "preferred lookup order" line at the bottom of the Documentation Sources section, the Bash-shortcut row pattern (`go doc` here in place of `mongosh` for in-system lookup), the gotcha-first treatment of the most-misunderstood feature (`Save` vs. `Updates` here, parallels Mongoose's middleware-kind disambiguation), and the explicit "what hours to defer for" pattern in the Approach section. Content authored independently from primary sources.
- **`technology-helm.md`** (skim only) — confirmed the flat structural variant is the right call for a single-purpose tool with one coherent doc site; GORM matches that profile.
- **Sibling discipline agents** (`software-data-integrity.md`, `software-performance.md`, `software-security.md`, `software-architecture.md`) — confirmed present on disk; deferred-to in the Scope block per the user's brief. Mechanisms (parameterized queries, `gorm.DeletedAt`, `PrepareStmt`, `Preload` vs. `Joins`, the `constraint:` tag) stay with the GORM agent; policy and design discipline ("what consistency model do we need?", "how slow is too slow?", "where to draw the DAL boundary?") stay with the discipline agents.
- **Adjacent gap noted**: no `technology-postgres.md` or `technology-mysql.md` agent exists yet on disk. The GORM agent's Scope block calls this out explicitly and routes engine-deep questions (query planner, partitioning, replication topology, index types beyond what struct tags express) to the engine's official docs (`postgresql.org/docs/`, `dev.mysql.com/doc/`) directly. When a dedicated engine agent is authored, the GORM agent's defer block should be updated to route to it instead.
- **Adjacent tools mentioned (not embedded)**: **Atlas** (`atlasgo.io`, has a GORM provider), **golang-migrate**, **goose**, **sql-migrate** — covered in a migration-tool comparison table in Core Concepts without endorsing one universally. **`sqlx`**, **`sqlc`**, **`ent`**, **`bun`**, **`database/sql`** stdlib — named in the Defer block as alternative Go data libraries to give the user the broader landscape when GORM isn't the right tool. **GORM CLI** (`gorm.io/cli`) — noted in scope as available, with a separate Context7 entry, but covered lightly; full coverage would warrant its own agent if usage grew.
- **VoltAgent `awesome-claude-code-subagents`** (https://github.com/VoltAgent/awesome-claude-code-subagents) — checked as a scope sanity check only. Their database-adjacent entries skew DBA/devops-shaped with checklist/protocol archetypes that conflict with this skill's fetch-first-answerer voice. No content adopted; confirmed scope decision to keep GORM as a single expert agent with explicit defer to peer discipline agents.

## Primary Sources

### Context7 (primary lookup channel)

Resolved via `mcp__context7__resolve-library-id` query "GORM":

- **`/websites/gorm_io`** — High reputation, **benchmark 87.06**, 436 curated snippets. **Top GORM choice** — indexes gorm.io directly, narrative-formatted, ideal for "how do I X" questions. Verified at authoring time: query for "Session WithContext PrepareStmt DryRun options" returned the full `gorm.Session` struct definition and detailed DryRun/PrepareStmt usage examples.
- **`/go-gorm/gorm.io`** — Medium reputation, benchmark 84.69, **2,335 snippets**. The gorm.io site repo (the rendered version of `/websites/gorm_io`'s source). Use when `/websites/gorm_io` doesn't surface the answer — more snippets, less curation.
- **`/go-gorm/gorm`** — High reputation, benchmark 75.74, only 67 snippets. The runtime source repository itself. Use for internals ("what does this method actually do") rather than docs.
- **`/go-gorm/cli`** — High reputation, benchmark 84.4, 98 snippets. Code generation tool (`gorm gen`) for typed query interfaces. Noted but lightly covered; would warrant its own agent if usage grew.
- **`/yys190/gorm-docs`** — Medium reputation, benchmark 32.75. Skipped (low quality signal).

Recommended primary: `/websites/gorm_io`. Recommended fallback (when primary thin): `/go-gorm/gorm.io`.

### Official Documentation (verified at authoring time)

All URLs confirmed accessible and on-topic via WebFetch on 2026-05-17. Specific findings:

- **https://gorm.io/docs/** — Confirmed four major sections: Getting Started, CRUD Interface, Associations, Tutorials & Advanced Topics. Footer notes "Last updated: 2026-04-21." References v1.30.0+ for the Generics API.
- **https://gorm.io/docs/models.html** — Confirmed full struct-tag reference (column, type, serializer, size, primaryKey, unique, default, precision, scale, not null, autoIncrement, autoIncrementIncrement, embedded, embeddedPrefix, autoCreateTime, autoUpdateTime, index, uniqueIndex, check, `<-`, `->`, `-`, comment), `gorm.Model`, naming conventions (snake_case + pluralize), `TableName()` mention.
- **https://gorm.io/docs/connecting_to_the_database.html** — Confirmed supported drivers (mysql, postgres, sqlite, sqlserver, gaussdb, clickhouse, oracle community, tidb mysql-compat), basic `gorm.Open` pattern, connection-pool config via `db.DB()` → `SetMaxIdleConns`/`SetMaxOpenConns`/`SetConnMaxLifetime`.
- **https://gorm.io/docs/update.html** — **The zero-value gotcha confirmed verbatim**: "When updating with struct, GORM will only update non-zero fields. You might want to use `map` to update attributes or use `Select` to specify fields to update." Workarounds: `map[string]interface{}`, `Select("*")`, explicit field list.
- **https://gorm.io/docs/hooks.html** — Confirmed full hook lifecycle order (BeforeSave → BeforeCreate → save associations → INSERT → AfterCreate → AfterSave; mirrors for Update and Delete; AfterFind for queries). Confirmed signature `func (m *Model) HookName(tx *gorm.DB) error`. Confirmed return-error triggers rollback.
- **https://gorm.io/docs/transactions.html** — Confirmed `Transaction()` closure form (nil error → commit; non-nil → rollback), manual `Begin`/`Commit`/`Rollback`, nested via SavePoints, `SavePoint`/`RollbackTo`, `SkipDefaultTransaction` option claiming ~30% improvement.
- **https://gorm.io/docs/preload.html** — Confirmed Preload (separate query, IN clause) vs. Joins (LEFT JOIN, single query) distinction, nested via dot notation, conditional via filter args or sub-builder closure, `clause.Associations` for "preload all."
- **https://gorm.io/docs/the_generics_way.html** — **Note**: the correct path. The expected URL `gorm.io/docs/generics.html` returns 404 (the docs structure uses the longer path). Confirmed Generics API landed in v1.30.0, basic shape `gorm.G[T](db).Method(ctx, args...)`, intentional omission of `FirstOrCreate` and `Save`, enhanced `Joins`/`Preload` with `LimitPerRecord`, freely mixable with the dynamic API.
- **https://gorm.io/docs/migration.html** — Confirmed `AutoMigrate` capabilities (create tables, add missing columns/FKs/constraints/indexes, modify column types when size/precision changes), explicit warning "It **WON'T** delete unused columns to protect your data," `Migrator()` interface for programmatic ops, **Atlas integration** named in the official docs as the recommended alternative when versioned migrations are needed, mention that other migration tools can consume `db.DB()` to get `*sql.DB`.
- **https://gorm.io/docs/associations.html** — Confirmed four kinds (BelongsTo, HasOne, HasMany, Many2Many) and Association Mode (Append/Replace/Delete/Clear/Count/Find), and association tags (`foreignKey`, `references`, `many2many`, `joinForeignKey`, `joinReferences`, `constraint`).
- **https://gorm.io/docs/dbresolver.html** — Confirmed DBResolver plugin config (`Sources`, `Replicas`, `Policy`), `db.Clauses(dbresolver.Write)` for forcing primary, `db.Clauses(dbresolver.Use("name"))` for named pool, transaction routing via clause options before `.Begin()`.
- **https://gorm.io/docs/session.html** — Confirmed full `gorm.Session` struct fields (DryRun, PrepareStmt, NewDB, Initialized, SkipHooks, SkipDefaultTransaction, DisableNestedTransaction, AllowGlobalUpdate, FullSaveAssociations, QueryFields, Context, Logger, NowFunc, CreateBatchSize). DryRun usage example confirmed (Statement.SQL.String(), Statement.Vars, Dialector.Explain for logging).
- **https://pkg.go.dev/gorm.io/gorm** — Confirmed latest published version **v1.31.1** (2025-11-02), main exported types (DB, Model, Association, Statement, DeletedAt, Config, Session, Migrator) and functions (Open, Expr, Scan, G generic interface builder), 86,926 importing projects.
- **https://github.com/go-gorm/gorm/releases** and **/tags** — Verified release cadence: v1.31.1 (2025-11-02, latest), v1.31.0 (2025-09-12), v1.30.5 (2025-09-08), v1.30.4 (2025-09-08), v1.30.3 (2025-09-04), v1.30.2 (2025-08-28), v1.30.1 (2025-07-23), v1.30.0 (2025-05-25, Generics API GA).

### URLs in the agent's Documentation Sources table not individually fetched at authoring time

The following are listed in the agent's table based on canonical `gorm.io/docs/` path conventions confirmed by the index page; not separately fetched but follow the consistent docs-site path structure. Sanity-checked at next use:

- `gorm.io/docs/conventions.html`, `create.html`, `query.html`, `advanced_query.html`, `delete.html`, `sql_builder.html`, `belongs_to.html`, `has_one.html`, `has_many.html`, `many_to_many.html`, `polymorphism.html`, `method_chaining.html`, `context.html`, `error_handling.html`, `logger.html`, `generics_interfaces.html`, `sharding.html`, `security.html`, `write_plugins.html`, `performance.html`, `v2_release_note.html`, `changelog.html`, `settings.html`.
- pkg.go.dev paths under `gorm.io/gorm/*` and `gorm.io/driver/*` and `gorm.io/plugin/*` — godoc-rendered, conventional.

A future authoring pass or any session that hits a broken URL should update the table.

## Volatile vs. Stable Classification

**Stable (embedded; safe to answer without a fetch)**:

- The four association kinds and their FK conventions.
- The hook lifecycle order and method signature.
- The chainable builder vs. finisher distinction.
- The `Save` vs. `Update` vs. `Updates(struct)` vs. `Updates(map)` vs. `UpdateColumn` semantic distinction — especially the zero-value gotcha. This is the single most-misunderstood thing about GORM and warrants embedding it twice (Core Concepts section + Approach section opening rule).
- The Preload-vs-Joins decision rule (BelongsTo/HasOne → Joins; HasMany/Many2Many → Preload).
- Transaction closure-form semantics (nil → commit, non-nil → rollback) and nested-via-savepoint behavior.
- `WithContext(ctx)` mandatory for cancellation propagation.
- The `?` placeholder auto-parameterization story (and the `Order` string-input SQL-injection trap).
- The migration-tool trade-offs and AutoMigrate's "never drops columns" property.
- Conventions (snake_case + plural, `ID` PK, `CreatedAt`/`UpdatedAt`/`DeletedAt` auto-managed).

**Volatile (always fetch when precision matters)**:

- The full struct-tag option list — new options have been added (e.g., serializers, `check`, `comment`); verify before quoting.
- Exact method signatures of `*gorm.DB` methods — minor signature evolution (added options structs, new variants).
- Session-flag list — new flags appear (e.g., `QueryFields`, `FullSaveAssociations` are relatively recent).
- **Generics API surface** — the most volatile area. Methods and options have been added across v1.30.x and v1.31.x (Set-based Create/Update in v1.30.4, association ops + conditional bulk updates in v1.31.0, Select/Omit for Generics Create in v1.31.1). Pin to the user's installed minor.
- Driver `Config` struct fields — driver-specific options change as engines evolve.
- Plugin config struct fields (DBResolver `Policy` variants, OpenTelemetry options).
- Sentinel error list (`ErrDuplicatedKey`, `ErrForeignKeyViolated`, etc. are gated behind `TranslateError: true` — added relatively recently).
- v1 → v2 migration specifics (rare in modern code but the changelog is authoritative when needed).

## Design Notes

- **The Save-vs-Updates gotcha gets two mentions on purpose.** Once in Core Concepts under "Update — the gotcha section (memorize this)" with all four variants laid out side-by-side, once in the Approach section as "always open every update answer with the zero-value question." It's by far the most common production bug GORM users hit, and the cost of redundant coverage is far lower than the cost of an agent answer that doesn't flag it. This pattern (embed twice for high-impact gotchas) may generalize.
- **Migration-tool comparison without endorsement.** The user's brief explicitly asked for "compare to Atlas and goose/golang-migrate without endorsing one as universally correct (depends on team)." The Core Concepts section presents a four-row table (AutoMigrate, Atlas, golang-migrate, goose) with "best fit" and "trade-off" columns, then names "no universally correct answer" explicitly. This is a useful pattern for any technology agent whose tool sits alongside competitor/complement tools — present the trade-off, name the inputs, refuse to pick.
- **Adjacent gap callout in Defer block.** The brief asked the agent to defer engine-side concerns to `technology-postgres.md` / `technology-mysql.md` even though those don't exist yet. The agent calls this out explicitly ("**Adjacent gap**: a `technology-postgres.md` or `technology-mysql.md` agent would own engine-side concerns; until those exist, the user should consult the engine's official docs directly") rather than silently routing to nonexistent peers. This pattern — naming an adjacent gap as part of the defer block — is useful for any agent whose peer set is incomplete.
- **Generics-API caveat about intentional omissions.** The generics section names what's deliberately *not* there (`FirstOrCreate`, `Save`) and explains the reason (concurrency ambiguity). This is more useful than pretending the generics API is a drop-in replacement — users who reach for the missing methods get an answer ("use `Create` + `clause.OnConflict`") rather than a confused error.
- **The "always cite the version" closing line.** Inherits the technology-mongodb pattern. Especially load-bearing for GORM because the generics API is moving every minor and users will commonly be one or two minors behind current.
- **Flat structural variant confirmed for narrow-ORM agents.** GORM, like Helm and a single library, is a textbook flat case — one library, one doc site, one chainable API. The partial variant (used for MongoDB) makes sense when there are clearly distinct sub-domains with separate canonical sources (server docs vs. driver docs vs. ODM docs); GORM has no such split. Future ORM/library agents in this monorepo style should default to flat unless they wrap multiple distinct ecosystems.
