# MongoDB + Mongoose Technology Expert — Sources

References that informed `technology-mongodb.md`. Prioritizes Context7 (live-indexed against the `mongodb/docs`, `Automattic/mongoose`, and `mongodb/node-mongodb-native` GitHub mirrors) and the official `mongodb.com/docs/manual/` + `mongoosejs.com/docs/` sites, with `mongosh` in-shell introspection promoted to the **top** of the lookup chain when a live cluster is available.

## Version Calibration

- **MongoDB Server pinned**: **8.x** — the current GA stable line and what the official docs default to (the docs site currently lands on the 8.3-series). Calibration material uses 8.x syntax and semantics; embedded examples reflect 8.x defaults.
- **Still-supported lines (call out, don't bury)**: **7.x** and **6.x** are still supported with bug fixes and security patches. Check current end-of-support dates at the authoritative lifecycle page: https://www.mongodb.com/legal/support-policy/lifecycles. The agent flags features added in 6.x/7.x/8.x explicitly so users on still-supported older lines know what does and doesn't apply to them.
- **Mongoose pinned**: **9.x** (current stable; doc site lands on 9.6.x as of 2026-05-17 confirmation). **8.x is the previous stable major**, still widely deployed, and is called out as a fallback. Awareness of 5.x/6.x/7.x as legacy lines (still in migration guides). Mongoose 9 introduced syntactic and default changes that the agent should pin on when a user states their stack.
- **MongoDB Node.js driver**: **6.x** (current stable). The Context7 indexed snapshot pins to an older 5.x entry, but the driver project is on 6.x; calibration uses 6.x as primary.
- **`mongosh`**: current stable (replaces the legacy `mongo` shell). Treated as the canonical shell throughout.
- **Date confirmed**: **2026-05-17**.
- **Calibration rationale**: pivoted from the previous calibration (which had pinned to 7.x server + Mongoose 8.x based on a specific codebase's deployed stack) to the general-purpose "current GA" pinning. This agent lives in `~/.claude/agents/` and is invoked from arbitrary projects; calibrating to upstream current keeps it useful for the broadest set of users while the still-supported-lines callout protects users who are deliberately one or two majors back.

## Existing Agents and Skills Consulted

- **Repo-local style references** (`technology-payloadcms.md`, `technology-docker.md`, `technology-nextjs.md`, `technology-nestjs.md`, and their `.sources.md` companions) — adopted for tone, section ordering (Scope → Sources → Core Concepts → Approach → Output Format), the dual-axis persona (deep expertise + fetch-first), Context7-as-preferred-channel convention, the `mongosh` shortcut row at the top of the table (analogous to Docker's preferred-lookup-order callout), and the partial variant treatment for sub-sectioning sources/concepts while keeping Approach flat. Content authored independently from primary sources.
- **Sibling discipline and technology agents named in `Defer to:`** (`technology-payloadcms.md`, `software-data-integrity.md`, `software-performance.md`, `software-security.md`, `software-reliability.md`) — referenced by capability rather than by what any specific project deploys. The MongoDB agent owns Mongo-side mechanisms (operator semantics, index design, aggregation pipelines, server admin, slow-query diagnosis, config shapes for the security/reliability primitives); discipline agents own policy.
- **VoltAgent `awesome-claude-code-subagents`** (https://github.com/VoltAgent/awesome-claude-code-subagents) — checked as a scope sanity check only. Their MongoDB-adjacent entries are organized around DevOps/DBA personas with a checklist/protocol archetype; that voice conflicts with this skill's fetch-first answerer voice. Confirmed scope decision: keep MongoDB+Mongoose as a single expert and defer infra-shaped concerns to DevOps/Reliability/Security peers. No content adopted.
- **`agent-technology` SKILL.md** — followed all nine steps. Step 1's ternary triage classified MongoDB+Mongoose as **partial**: the three sub-domains (Server manual + `mongosh`, Node driver, Mongoose ODM) have clearly distinct authoritative sources (separate doc sites, separate repos, separate version cadences), but most real tasks cross the boundary (you design a schema in Mongoose → query syntax compiles down to a Mongo query → you debug it with mongosh on the server). Sub-sectioned the Documentation Sources table and Core Concepts by sub-domain; kept Approach flat because task strategies (ESR analysis, explain-driven diagnosis, hook-kind disambiguation, populate-vs-lookup) generalize and would otherwise duplicate.

## Primary Sources

### Context7 (primary lookup channel)

Resolved via `mcp__context7__resolve-library-id`:

- **`/mongodb/docs`** — High reputation, ~10k snippets, version-branch indexed (e.g. `__branch__v7.2`). **Top server-side choice** — indexes the `mongodb/docs` GitHub source tree backing docs.mongodb.com.
- **`/websites/mongodb_manual`** — High reputation, ~6k snippets. Alternative when narrative manual content is needed and `/mongodb/docs` doesn't surface it.
- **`/mongodb/mongo`** — High reputation, ~8k snippets. Server source repository — useful for internals questions (WiredTiger behavior, planner internals).
- **`/mongodb/mongo-tools`** — High reputation, ~2.5k snippets. `mongodump`, `mongorestore`, `mongoimport`, `mongoexport`, `mongofiles`, `mongostat`, `mongotop`.
- **`/automattic/mongoose`** — High reputation, ~800 snippets, versioned (`5_13_22`, `7.8.8`, `8_19_1`, `9.0.1`). **Top Mongoose choice** because it's version-pinnable.
- **`/websites/mongoosejs`** — High reputation, ~3k snippets from mongoosejs.com. Narrative-form alternative to the GitHub-mirrored `/automattic/mongoose`; useful when looking for tutorial-style content.
- **`/mongodb/node-mongodb-native`** — High reputation, ~6k snippets. **Driver canonical choice**.

Versions worth pinning explicitly when a user states their stack:

- Server 7.x branch: `/mongodb/docs/__branch__v7.2` (the only versioned branch surfaced; falls back to current default for content not in that branch).
- Mongoose 9.x: `/automattic/mongoose/9.0.1` (the latest indexed snapshot on Context7; doc site shows 9.6.x — pin to nearest available).
- Mongoose 8.x: `/automattic/mongoose/8_19_1` (for projects still on the 8 line).

### Official Documentation (verified at authoring time)

All URLs confirmed accessible and on-topic via WebFetch on 2026-05-17. Findings:

- **https://www.mongodb.com/docs/manual/reference/operator/aggregation/** — Canonical index of aggregation expression operators. Confirmed 17 major categories (arithmetic, array, bitwise, boolean, comparison, conditional, custom, data size, date, string, encrypted string, set, type, timestamp, trigonometry, window, miscellaneous). Note: the URL redirects to `/reference/mql/expressions/` on the 8.x default version; the legacy URL still routes correctly.
- **https://www.mongodb.com/docs/manual/reference/operator/query/** — Query operators; canonical.
- **https://www.mongodb.com/docs/manual/reference/operator/update/** — Update operators; canonical.
- **https://www.mongodb.com/docs/manual/reference/operator/aggregation-pipeline/** — Stages reference; canonical.
- **https://www.mongodb.com/docs/manual/core/aggregation-pipeline/** — Aggregation concepts page.
- **https://www.mongodb.com/docs/manual/core/aggregation-pipeline-optimization/** — Optimizer rules (early `$match`, `$sort` push-down, `$lookup` sub-pipeline push-down).
- **https://www.mongodb.com/docs/manual/indexes/** — Indexes overview. Confirmed coverage of single/compound/multikey/text/2dsphere/hashed/wildcard/TTL/unique/sparse/partial; confirms B-tree storage, automatic `_id` index, getting-started routes via Atlas UI / driver / mongosh.
- **https://www.mongodb.com/docs/manual/core/indexes/index-types/** — Per-type pages.
- **https://www.mongodb.com/docs/manual/core/index-properties/** — Properties orthogonal to type (unique, partial, sparse, TTL, case-insensitive, hidden).
- **https://www.mongodb.com/docs/manual/tutorial/equality-sort-range-rule/** — ESR rule page. Canonical reference for compound index field ordering.
- **https://www.mongodb.com/docs/manual/reference/explain-results/** — `executionStats` field interpretation.
- **https://www.mongodb.com/docs/manual/reference/bson-types/** — BSON type table with numeric codes; required reading for `$type` queries.
- **https://www.mongodb.com/docs/manual/reference/method/ObjectId/** — ObjectId structure and methods (`getTimestamp`, `createFromTime`).
- **https://www.mongodb.com/docs/manual/reference/read-concern/** — Read concern levels.
- **https://www.mongodb.com/docs/manual/reference/write-concern/** — Write concern (`w`, `j`, `wtimeout`). Default `w: "majority"` since 5.0.
- **https://www.mongodb.com/docs/manual/core/read-preference/** — Read preference modes.
- **https://www.mongodb.com/docs/manual/core/transactions/** — ACID transactions, `withTransaction` pattern, `transactionLifetimeLimitSeconds` default 60s.
- **https://www.mongodb.com/docs/manual/reference/server-sessions/** — Sessions and causal consistency.
- **https://www.mongodb.com/docs/manual/changeStreams/** — Change streams.
- **https://www.mongodb.com/docs/manual/core/schema-validation/** — `$jsonSchema` validation, `validationLevel`, `validationAction`.
- **https://www.mongodb.com/docs/manual/core/capped-collections/** — Capped collection semantics.
- **https://www.mongodb.com/docs/manual/core/timeseries-collections/** — Time-series collections (5.0+).
- **https://www.mongodb.com/docs/manual/reference/method/** — `mongosh` methods reference. Confirmed 14 method category groupings (collections, cursors, databases, plan caches, bulk, user/role mgmt, replication `rs.`, sharding `sh.`, BSON constructors, connections, in-use encryption, Atlas Search/Stream, native).
- **https://www.mongodb.com/docs/mongodb-shell/** — `mongosh` install and usage.
- **https://www.mongodb.com/docs/manual/reference/parameters/** — Server parameters.
- **https://www.mongodb.com/docs/manual/release-notes/** — Confirmed current GA on docs site is **8.3-series**; supported lines listed: **8.3, 8.2, 8.0, 7.0**. Earlier majors EOL or approaching EOL.
- **https://www.mongodb.com/legal/support-policy/lifecycles** — Authoritative lifecycle / end-of-support page. Surfaces Atlas, Enterprise Advanced, and Ops Manager schedules. The specific EOL dates live here; the agent points users at this URL rather than embedding dates that go stale.
- **https://www.mongodb.com/docs/manual/reference/versioning/** — Versioning scheme. Confirmed semantic version `X.Y.Z`; since 8.2, minor releases ship outside the once-a-year major cadence and are production-grade.
- **https://www.mongodb.com/docs/manual/reference/connection-string/** — Connection URI format.
- **https://www.mongodb.com/docs/drivers/node/current/** — Node driver landing. Routes to current major (6.x).
- **https://mongodb.github.io/node-mongodb-native/** — Auto-generated TypeDoc reference.
- **https://mongoosejs.com/docs/** — Mongoose docs landing. Defaults to **9.6.1** as of 2026-05-17 verification — confirming Mongoose 9 is current stable (not in-development as a previous draft had assumed). 8.x, 7.x, 6.x docs are still accessible via the version dropdown.
- **https://mongoosejs.com/docs/guide.html** — Schema options. Confirmed coverage of `autoIndex`, `autoCreate`, `bufferCommands`, `capped`, `collection`, `strict`, `strictQuery`, `timestamps`, `versionKey`, `virtuals`, `toJSON`/`toObject`, `validateBeforeSave`, `optimisticConcurrency`, plus discriminators, read/write concerns, collation, methods/statics/query helpers.
- **https://mongoosejs.com/docs/schematypes.html** — SchemaTypes.
- **https://mongoosejs.com/docs/queries.html** — Query builder.
- **https://mongoosejs.com/docs/populate.html** — Populate.
- **https://mongoosejs.com/docs/subdocs.html** — Subdocuments.
- **https://mongoosejs.com/docs/validation.html** — Validation.
- **https://mongoosejs.com/docs/middleware.html** — Middleware. Confirmed 4 kinds: document, query, aggregate, model. Confirmed `this`-semantics distinction (doc instance vs Query vs Aggregate vs Model). Confirmed gotchas re: defining hooks before `.model()`, query middleware doesn't see the document, validators don't run on `findOneAndUpdate` without `runValidators: true`.
- **https://mongoosejs.com/docs/discriminators.html** — Discriminators.
- **https://mongoosejs.com/docs/plugins.html** — Plugins.
- **https://mongoosejs.com/docs/connections.html** — Connections.
- **https://mongoosejs.com/docs/transactions.html** — Transactions, `Model.create([...], {session})` array-form gotcha.
- **https://mongoosejs.com/docs/tutorials/lean.html** — `.lean()` and trade-offs.
- **https://mongoosejs.com/docs/tutorials/virtuals.html** — Virtuals.
- **https://mongoosejs.com/docs/api.html** — Full API reference.
- **https://mongoosejs.com/docs/migrating_to_9.html** — Mongoose 8 → 9 migration. Other per-major guides at `/migrating_to_8.html`, `/migrating_to_7.html`, `/migrating_to_6.html`.
- **https://github.com/Automattic/mongoose** — Mongoose source.
- **https://github.com/mongodb/node-mongodb-native** — Driver source.

### URLs noted as redirected or thin

- `https://www.mongodb.com/docs/manual/reference/operator/aggregation/` → redirects to `/reference/mql/expressions/` on the 8.x docs default. The legacy URL still routes correctly and is the more discoverable name; both are listed.
- The MongoDB docs site honors a version dropdown — pin via path (`/docs/v7.0/...`) when version-specific behavior is needed. The default landing always points at current GA (8.x at the time of authoring).
- The lifecycle page (https://www.mongodb.com/legal/support-policy/lifecycles) renders specific EOL tables behind a JS-rendered SPA; WebFetch surfaces only the page chrome. The agent points users at the URL rather than embedding a stale snapshot of dates.

No 404s encountered.

## Volatile vs. Stable Classification

**Embedded (stable across recent MongoDB/Mongoose versions — unlikely to change without a major)**:

- Document/BSON model, `_id`/`ObjectId` structure and timestamp extractability.
- 16 MB document size limit.
- Aggregation pipeline as an ordered stream-of-stages mental model.
- The names and roles of foundational stages (`$match`, `$group`, `$lookup`, `$unwind`, `$project`, `$set`, `$sort`, `$limit`, `$facet`).
- The ESR rule (Equality → Sort → Range) for compound index ordering.
- The index-prefix usage rule.
- The covered-query concept.
- `explain('executionStats')` field meanings (`stage`, `totalKeysExamined`, `totalDocsExamined`, `nReturned`).
- Replica-set primary/secondary/arbiter conceptual model.
- Read-concern/write-concern levels and their guarantees at a conceptual level.
- Causal consistency within sessions.
- Transactions: scope (replica set 4.0+, cross-shard 4.2+), the `withTransaction` retry semantics, the lifetime cap.
- Mongoose's four middleware kinds (document/query/aggregate/model) and the `this`-binding distinction.
- The document-vs-query update overlap gotcha.
- The validators-don't-run-on-update gotcha without `runValidators: true`.
- The "middleware must be defined before `.model()`" gotcha.
- Populate's behavior (one extra query per populated path).
- `.lean()` returns plain objects; loses document features.
- `mongosh` introspection command shapes (`getIndexes`, `stats`, `explain`, `currentOp`, `serverStatus`, `db.system.profile`).

**Always fetch (volatile — version-sensitive)**:

- Specific aggregation operator option lists (new operators ship per minor; `$densify`/`$fill` 5.1+, `$rankFusion` 8.1+, etc.).
- Query/update operator availability (e.g. `$function`'s preconditions).
- Index option flag inventory (new options ship per minor; compound wildcard indexes 7.0+).
- Mongoose schema option semantics where defaults change between majors (`strictQuery` changed default in 7.x).
- Middleware event lists per major (new model-middleware events added in 8.x; verify against 9.x).
- Driver connection-string option additions.
- Transaction-related parameter names and defaults.
- Time-series collection option list (introduced 5.0; options have grown).
- Atlas Search / Vector Search operator and pipeline-stage availability.
- Queryable Encryption status and supported predicate types.
- `EXPRESS` vs `IDHACK` plan-stage naming (introduced/renamed in the 8.x line).
- End-of-support dates — never embed; always link the lifecycle page.

## Design Notes

- **Partial variant chosen (Sources sub-sectioned by sub-domain, Concepts sub-sectioned by sub-domain, Approach flat).** MongoDB+Mongoose has three sub-domains with clearly distinct authoritative sources (server manual + mongosh, Node driver, Mongoose docs), so grouping the Sources table preserves scannability when a user knows which sub-domain they're in. Core Concepts is similarly sub-sectioned because the conceptual material is large enough that a flat treatment would crowd out the Mongoose-specific concepts behind the server-side material. Approach was kept flat because real tasks cross sub-domains constantly — "this Mongoose query is slow" is simultaneously a Mongoose question (schema/middleware) and a server question (`explain`/indexes), and a per-sub-domain Approach would duplicate guidance. The Docker agent applied the same reasoning and provided a direct precedent.
- **`mongosh` promoted to the top of the Sources table.** Per the skill's "for live-system technologies, promote in-system lookups to the top" guidance. `db.collection.getIndexes()` / `.explain('executionStats')` / `db.serverStatus()` will always be faster and more authoritative than any web fetch when a live cluster is reachable. The Bash-shortcut row is structured as a table-within-the-section rather than a single row so the agent can quickly scan it. This is a general-purpose in-system-introspection pattern, not codebase-specific.
- **ESR rule embedded as a core concept, not deferred to a fetch.** This is the single highest-leverage piece of index design knowledge and it is foundational/stable. Embedding it (with the worked example) means the agent can produce a recommendation without a round trip on the most common index-design question.
- **`explain('executionStats')` field semantics embedded.** Same logic — this is the canonical diagnostic workflow for slow queries, and the field meanings are stable. Specific stage names sometimes evolve (`EXPRESS` superseding many `IDHACK` cases in 8.x) but the diagnostic chain doesn't.
- **Middleware kinds + `this`-binding table embedded.** This is the most-confused area in Mongoose; surfacing it as a table is more useful than prose. The "pre('save') doesn't catch findOneAndUpdate" gotcha and the "validators don't run on update without `runValidators: true`" gotcha are also embedded because they're discoverable only by experience or fetching middleware docs.
- **Version calibration to 8.x server + 9.x Mongoose (current GA).** Re-pivoted from a previous codebase-specific calibration (7.x server, 8.x Mongoose) to upstream current. The agent lives in `~/.claude/agents/` and is invoked from arbitrary projects — anchoring to current GA serves the largest set of users. Still-supported lines (7.x and 6.x server, 8.x Mongoose) are called out as fallbacks with a link to the lifecycle page so users on those lines can verify what does and doesn't apply.
- **Adjacent surfaces named, not embedded.** Atlas UI, sharded cluster provisioning, Atlas Search/Vector, Queryable Encryption — all called out as adjacent with a one-line note and the right defer-target. Saves prompt space for the high-leverage core surface.
- **Aggregation pipeline given heavy treatment.** Aggregation is where MongoDB usage rises above "key-value store with extra steps" and where most users get into trouble. Stages, optimizer behavior, and the "when to use it vs multiple finds" disambiguation all embedded.
- **Indexes given heavy treatment.** Types, properties, ESR, covered queries, `explain` interpretation — all embedded. This is the area where production incidents originate most often.
- **`mongosh` commands embedded in a dedicated Core Concepts subsection too**, not just the top-of-table shortcut list. The shortcut list is for the agent's lookup behavior; the Core Concepts treatment teaches the user the right commands when the answer is "go check yourself."
- **Defer-to block reframed by capability, not by deployment.** Listed agents are described by what they own (Payload collection-config patterns; data-integrity / performance / security / reliability disciplines), not by what any specific project deploys. Keeps the agent reusable across arbitrary projects.

## Step 7 cold review (post-revision)

Re-ran the two-invocation cold review per `agent-technology` SKILL.md Step 7 after the 8.x/9.x re-pivot and the codebase-specific content removal:

**Invocation 1 — "Does the calibration land cleanly?"** The 8.x server primary calibration reads naturally: examples use 8.x defaults (`w: 'majority'` as default since 5.0 made explicit, `EXPRESS` stage acknowledged alongside `IDHACK`), 8.x-only operators are version-stamped (`$rankFusion` 8.1+), and the "still-supported lines" framing in the front matter and `Approach` section gives users on 7.x/6.x the right signal without burying them. The Mongoose 9.x pivot (from a previous draft that had treated 9 as in-development) is reflected throughout — schema-option defaults, middleware-event coverage, migration guide list. Driver stays at 6.x. Defer-to block reads as general capability framing — no project paths, no monorepo assumptions, no "this codebase uses…" rationale.

**Invocation 2 — "Would this agent be useful in a project I've never seen?"** Yes. The Sources table works the same whether the user's project is a Next.js app with Mongoose, a NestJS service, a CLI tool, a Payload v3 admin, or a raw Node script using the driver directly. The `mongosh` shortcut block is a general in-system-introspection pattern that any MongoDB user benefits from. The Payload reference in `Defer to:` is framed as "one example of many ODM-consuming frameworks" rather than as the agent's primary consumer. No `apps/admin`, no `libs/`, no Docker Compose mention, no PayloadCMS-as-the-only-consumer framing remains. The agent reads as a general-purpose MongoDB+Mongoose expert.

**Temptations resisted**:

- Was tempted to keep a sentence about MongoDB-in-Docker-Compose being a great local dev pattern (it is, generally) — cut it because it edges toward prescription of a specific dev setup. The `mongosh` shortcut row already implicitly assumes a reachable cluster without prescribing how it got there.
- Was tempted to keep the `@payloadcms/db-mongodb 3.84.1` example as a concrete Mongoose-via-framework pin in the calibration notes — cut it; replaced with the general "many ODM-consuming frameworks" framing.
- Was tempted to leave the previous "Calibration to this codebase" header in this sources file because it had useful context — renamed to "Version Calibration" per the brief and stripped the codebase rationale.
