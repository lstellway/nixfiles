# NestJS Technology Expert — Sources

References that informed `technology-nestjs.md`. Prioritizes Context7 (live-indexed against the `nestjs/docs.nestjs.com` source repo and version-pinned source from `nestjs/nest`) over direct WebFetch of `docs.nestjs.com`, which is client-rendered and returns title-only HTML to scrapers.

## Version Calibration

- **NestJS version pinned**: **v11.1.21** (the latest stable release, published May 14, 2026 — three days before authoring). Context7 source-pinned ID available at `/nestjs/nest/v11.1.16` (the most recent v11 tag Context7 has indexed at the time of authoring).
- **Date confirmed**: 2026-05-17.
- **Major version line**: v11. Key v11 deltas from v10: Express **5** is the default platform (Fastify **5** also supported), **RxJS 7+** required, **Node.js 16 and 18 dropped** (Node 20+ required as of v11 release; v22 features supported via `--experimental-require-module` for ESM packages in the sample app `35-use-esm-package-after-node22`), `path-to-regexp` upgraded → middleware/route wildcard syntax changed (`*` and `(.*)` no longer work; use named wildcards like `*splat` or `{*splat}` — Nest 11 auto-converts middleware paths but new code should use the new form), enhanced `ModuleRef.get`/`resolve` with `strict` and `each` options.
- **Companion package versions** in scope: `@nestjs/common`, `@nestjs/core`, `@nestjs/platform-express`, `@nestjs/platform-fastify` (all 11.1.x); `@nestjs/microservices` 11.x; `@nestjs/graphql` 13.x with `@nestjs/apollo` (Apollo Server 4); `@nestjs/swagger` 8.x; `@nestjs/config` 4.x; `@nestjs/typeorm` 11.x; `@nestjs/mongoose` 11.x; `@nestjs/cache-manager` 3.x (paired with `cache-manager` 5+ Keyv-based stores); `@nestjs/bullmq` (BullMQ; `@nestjs/bull` is legacy); `@nestjs/schedule` 5.x; `@nestjs/testing` 11.x; `class-validator` 0.14+ / `class-transformer` 0.5+.

## Existing Agents and Skills Consulted

- **VoltAgent `awesome-claude-code-subagents`** (https://github.com/VoltAgent/awesome-claude-code-subagents) — surveyed for prior NestJS art. **Result: no NestJS-specific subagent in the collection**; the closest backend Node listing is the generic `node-specialist` under "Language Specialists". Nothing inherited; nothing to deconflict against. The community-agent archetype tends to be checklist/protocol oriented, which conflicts with this skill's "fetch-first expert" voice, so cross-checking was scope-only.
- **Repo-local style references**:
  - `technology-payloadcms.md` / `.sources.md` — adopted: broad-surface variant structure (sub-sectioned Documentation Sources and Core Concepts), Context7-first lookup discipline with `WebFetch` fallback, version calibration framing, deferral pattern that names peer agents explicitly.
  - `technology-react.md` — adopted: per-symbol decorator/option fetch discipline, the embedded-vs-fetch decision frame, the "always cite the version when version-sensitive" closing rule.
  - `technology-nix.md` — adopted: section ordering (Scope → Sources → Core Concepts → Approach → Output Format), the persona frame.
  Content is independently authored from primary NestJS sources.
- **No first-party Claude-plugin skill from Nest**. Unlike Payload's `tools/claude-plugin/skills/payload/reference/`, the `nestjs/nest` repo does not ship LLM-targeted reference snippets. Context7's `/nestjs/docs.nestjs.com` index — built from the markdown source of the official docs site — is the closest equivalent and is the agent's primary lookup channel.

## Primary Sources

### Context7 (primary lookup channel)

| Library ID | Score | Use |
|---|---|---|
| `/nestjs/docs.nestjs.com` | benchmark 87.47, 1,712 snippets, **High** source reputation | **Default lookup.** Indexes the markdown source of the official docs at `github.com/nestjs/docs.nestjs.com/blob/master/content/`. Snippet quality is high; coverage spans fundamentals, techniques, microservices, GraphQL, WebSockets, OpenAPI, recipes, FAQ. |
| `/nestjs/nest/v11.1.16` | versioned, 183 snippets, **High** reputation | Source-pinned to v11.1.16; useful for reading actual implementations, samples (`sample/<n>-<topic>`), integration tests, and internal types when docs are thin. Other tags available: `v11_1_6`, `v10_4_15`, `v10_4_6`. |
| `/websites/nestjs` | benchmark 79.11, 2,529 snippets, **High** reputation | Larger snippet count if `/nestjs/docs.nestjs.com` returns thin results on a niche topic. |
| `/websites/nestjs_cn` | benchmark 88.23, 1,493 snippets, Medium | Chinese mirror of the docs — useful as a fallback for retrieval coverage; ignore for source-of-truth claims. |
| `/websites/api-references-nestjs_netlify_app_api` | benchmark 54.12, 2,346 snippets, High | API references site mirror; lower benchmark, not the default. |

### Official documentation (URL verification log)

Verified via `curl -sIL` (HEAD request, follow redirects) on 2026-05-17. All return HTTP 200 unless noted. **Caveat**: `docs.nestjs.com` is rendered client-side; a `WebFetch` against the rendered page returns title-only HTML. The HEAD 200s confirm the URLs exist and serve the SPA shell; programmatic content retrieval must go through Context7 (which indexes the markdown source repo at `github.com/nestjs/docs.nestjs.com`).

**HTTP layer & fundamentals**:
- https://docs.nestjs.com/ — 200
- https://docs.nestjs.com/first-steps — 200
- https://docs.nestjs.com/controllers — 200
- https://docs.nestjs.com/providers — 200
- https://docs.nestjs.com/modules — 200
- https://docs.nestjs.com/middleware — 200
- https://docs.nestjs.com/pipes — 200
- https://docs.nestjs.com/guards — 200
- https://docs.nestjs.com/interceptors — 200
- https://docs.nestjs.com/exception-filters — 200
- https://docs.nestjs.com/custom-decorators — 200

**Modules & DI deep dive**:
- https://docs.nestjs.com/fundamentals/custom-providers — 200
- https://docs.nestjs.com/fundamentals/injection-scopes — 200
- https://docs.nestjs.com/fundamentals/dynamic-modules — 200
- https://docs.nestjs.com/fundamentals/lifecycle-events — 200
- https://docs.nestjs.com/fundamentals/circular-dependency — 200
- https://docs.nestjs.com/fundamentals/module-ref — 200
- https://docs.nestjs.com/fundamentals/lazy-loading-modules — 200
- https://docs.nestjs.com/fundamentals/execution-context — 200
- https://docs.nestjs.com/fundamentals/testing — 200
- https://docs.nestjs.com/fundamentals/unit-testing — 200 (covers the same Testing material from a different angle)
- https://docs.nestjs.com/faq/request-lifecycle — 200

**Techniques**:
- https://docs.nestjs.com/techniques/database — 200
- https://docs.nestjs.com/techniques/mongodb — 200
- https://docs.nestjs.com/techniques/configuration — 200
- https://docs.nestjs.com/techniques/validation — 200
- https://docs.nestjs.com/techniques/caching — 200
- https://docs.nestjs.com/techniques/serialization — 200
- https://docs.nestjs.com/techniques/versioning — 200
- https://docs.nestjs.com/techniques/task-scheduling — 200
- https://docs.nestjs.com/techniques/queues — 200
- https://docs.nestjs.com/techniques/logger — 200
- https://docs.nestjs.com/techniques/cookies — 200
- https://docs.nestjs.com/techniques/events — 200
- https://docs.nestjs.com/techniques/compression — 200
- https://docs.nestjs.com/techniques/file-upload — 200
- https://docs.nestjs.com/techniques/streaming-files — 200
- https://docs.nestjs.com/techniques/http-module — 200
- https://docs.nestjs.com/techniques/session — 200
- https://docs.nestjs.com/techniques/mvc — 200
- https://docs.nestjs.com/techniques/performance — 200
- https://docs.nestjs.com/techniques/server-sent-events — 200
- https://docs.nestjs.com/techniques/sse — 200 (alias of server-sent-events)

**Security**:
- https://docs.nestjs.com/security/authentication — 200
- https://docs.nestjs.com/security/authorization — 200
- https://docs.nestjs.com/security/encryption-and-hashing — 200
- https://docs.nestjs.com/security/helmet — 200
- https://docs.nestjs.com/security/cors — 200
- https://docs.nestjs.com/security/csrf — 200
- https://docs.nestjs.com/security/rate-limiting — 200

**Microservices**:
- https://docs.nestjs.com/microservices/basics — 200
- https://docs.nestjs.com/microservices/redis — 200
- https://docs.nestjs.com/microservices/mqtt — 200
- https://docs.nestjs.com/microservices/nats — 200
- https://docs.nestjs.com/microservices/rabbitmq — 200
- https://docs.nestjs.com/microservices/kafka — 200
- https://docs.nestjs.com/microservices/grpc — 200
- https://docs.nestjs.com/microservices/exception-filters — 200
- https://docs.nestjs.com/microservices/pipes — 200
- https://docs.nestjs.com/microservices/guards — 200
- https://docs.nestjs.com/microservices/interceptors — 200
- https://docs.nestjs.com/microservices/custom-transport — 200

**GraphQL**:
- https://docs.nestjs.com/graphql/quick-start — 200
- https://docs.nestjs.com/graphql/resolvers — 200
- https://docs.nestjs.com/graphql/mutations — 200
- https://docs.nestjs.com/graphql/subscriptions — 200
- https://docs.nestjs.com/graphql/scalars — 200
- https://docs.nestjs.com/graphql/federation — 200

**WebSockets**:
- https://docs.nestjs.com/websockets/gateways — 200
- https://docs.nestjs.com/websockets/exception-filters — 200
- https://docs.nestjs.com/websockets/pipes — 200
- https://docs.nestjs.com/websockets/guards — 200
- https://docs.nestjs.com/websockets/interceptors — 200
- https://docs.nestjs.com/websockets/adapter — 200

**OpenAPI (Swagger)**:
- https://docs.nestjs.com/openapi/introduction — 200
- https://docs.nestjs.com/openapi/types-and-parameters — 200
- https://docs.nestjs.com/openapi/operations — 200
- https://docs.nestjs.com/openapi/decorators — 200
- https://docs.nestjs.com/openapi/cli-plugin — 200

**Recipes**:
- https://docs.nestjs.com/recipes/passport — 200
- https://docs.nestjs.com/recipes/sql-typeorm — 200
- https://docs.nestjs.com/recipes/mongodb — 200
- https://docs.nestjs.com/recipes/prisma — 200
- https://docs.nestjs.com/recipes/mikroorm — 200
- https://docs.nestjs.com/recipes/sql-sequelize — 200
- https://docs.nestjs.com/recipes/cqrs — 200
- https://docs.nestjs.com/recipes/repl — 200
- https://docs.nestjs.com/recipes/documentation — 200
- https://docs.nestjs.com/recipes/router-module — 200
- https://docs.nestjs.com/recipes/async-local-storage — 200
- https://docs.nestjs.com/recipes/swc — 200
- https://docs.nestjs.com/recipes/crud-generator — 200
- https://docs.nestjs.com/recipes/hot-reload — 200
- https://docs.nestjs.com/recipes/automock — 200
- https://docs.nestjs.com/recipes/suites — 200
- https://docs.nestjs.com/recipes/nest-commander — 200
- https://docs.nestjs.com/recipes/sentry — 200
- https://docs.nestjs.com/recipes/necord — 200
- https://docs.nestjs.com/recipes/serve-static — 200
- https://docs.nestjs.com/recipes/swagger — 200

**CLI, DevTools, FAQ, migration**:
- https://docs.nestjs.com/cli/overview — 200
- https://docs.nestjs.com/cli/usages — 200
- https://docs.nestjs.com/devtools/overview — 200
- https://docs.nestjs.com/standalone-applications — 200
- https://docs.nestjs.com/faq/hybrid-application — 200
- https://docs.nestjs.com/faq/serverless — 200
- https://docs.nestjs.com/faq/raw-body — 200
- https://docs.nestjs.com/faq/global-prefix — 200
- https://docs.nestjs.com/faq/keep-alive-connections — 200
- https://docs.nestjs.com/migration-guide — 200 (current v10 → v11)
- https://docs.nestjs.com/v10/migration-guide — 200 (snapshot of the older guide)

### URLs that 404'd

- `https://github.com/nestjs/nest/blob/master/MIGRATION.md` — **404**. The repo does not host a top-level `MIGRATION.md`; the canonical migration guide lives at `https://docs.nestjs.com/migration-guide` (sourced from `github.com/nestjs/docs.nestjs.com/blob/master/content/migration.md`).
- `https://github.com/nestjs/nest/blob/master/CHANGELOG.md` — **404**. No repo-root changelog file. The canonical changelog is `https://github.com/nestjs/nest/releases`.
- `https://github.com/nestjs/devtools-integration` — **404**. The DevTools client integration is documented at `https://docs.nestjs.com/devtools/overview`; the npm package is `@nestjs/devtools-integration` but no public GitHub repo of that exact name. Removed from the table.
- `https://www.npmjs.com/package/@nestjs/core` and `@nestjs/common` — **403** to my HEAD probe (npm blocks unauthenticated HEAD on some package pages). The URLs are valid in a browser; included neither in the table nor as a reference path.

### Source & ecosystem (verified)

- https://github.com/nestjs/nest — 200 (core monorepo)
- https://github.com/nestjs/nest/releases — 200 (canonical changelog; v11.1.21 confirmed as latest)
- https://github.com/nestjs/nest-cli — 200
- https://github.com/nestjs/typeorm — 200
- https://github.com/nestjs/mongoose — 200
- https://docs.bullmq.io — 200 (for BullMQ-internal questions referenced by the queues recipe)
- https://trilon.io/blog — 200 (Trilon is the company behind Nest; long-form release-narrative posts often appear here)

## Volatile vs. Stable Classification

### Embedded (stable across v11.x — unlikely to change without a major)

- The request-response pipeline ordering (middleware → guards → interceptors-before → pipes → handler → interceptors-after → exception filters).
- Module-as-encapsulation-boundary semantics; the "Nest can't resolve dependencies" failure mode and its root causes.
- The four custom-provider shapes (`useValue`/`useClass`/`useFactory`/`useExisting`) and the `inject` array convention for `useFactory`.
- The three injection scopes (`DEFAULT`/`REQUEST`/`TRANSIENT`) and the scope-taint propagation rule.
- The `forRoot`/`forRootAsync`/`forFeature` convention; the existence of `ConfigurableModuleBuilder`.
- The five lifecycle interfaces (`OnModuleInit`, `OnApplicationBootstrap`, `OnModuleDestroy`, `BeforeApplicationShutdown`, `OnApplicationShutdown`) and the `enableShutdownHooks()` requirement.
- The `MessagePattern` vs `EventPattern` semantic difference (cold vs hot Observable; request-response vs fire-and-forget).
- The Local-API equivalent in microservices: `ClientProxy.send` vs `.emit`.
- The Reflector lookup patterns (`get`, `getAllAndOverride`, `getAllAndMerge`) and the `Reflector.createDecorator` typed-metadata API.
- The `Test.createTestingModule({...}).compile()` shape and the override builders; `moduleRef.get` (singletons) vs `moduleRef.resolve` (scoped).
- The CLI command set at the category level (`new`, `generate`, `start`, `build`).
- The three platform-adapter choices: Express (default), Fastify, none (`createApplicationContext`).
- The HTTP exception class hierarchy (`HttpException` and its standard subclasses 400–505).

### Always fetch (volatile — version-sensitive)

- Specific decorator option shapes (`@Controller({ version, scope, host })`, `@Module({ ... })`, `@Inject(token)` overloads).
- `ValidationPipe` option list — `whitelist`, `forbidNonWhitelisted`, `transform`, `transformOptions`, `forbidUnknownValues`, `errorHttpStatusCode`, etc. — interactions are subtle and the defaults shifted between v8/v9/v10/v11.
- Transport options for each microservice (`Transport.TCP`/`REDIS`/`NATS`/`MQTT`/`RMQ`/`KAFKA`/`GRPC`) — these objects differ per transport and add fields between minor versions.
- GraphQL driver options (`ApolloDriverConfig`, `MercuriusDriverConfig`) — Apollo Server 4 vs 5 transitions move these.
- `@nestjs/swagger` decorator API (`@ApiProperty`, `@ApiOperation`, etc.) and CLI-plugin config in `nest-cli.json`.
- Storage of `cache-manager` v5+ via Keyv-compatible stores (v11 migrated from `cache-manager` v4); decorator semantics (`@CacheKey`, `@CacheTTL`) and the underlying interceptor's behavior moved.
- `@nestjs/throttler` config (the rate-limiter API has churned across majors).
- Express 5 wildcard syntax in middleware and route paths (`*splat`/`{*splat}` vs the legacy `*`/`(.*)`).
- `path-to-regexp` behavior in route matching (the v11 upgrade is the source of most v10 → v11 route migration friction).
- `ModuleRef.get` / `.resolve` options (`each`, `strict`) — added in v11.
- Auth strategy interfaces for Passport (`@nestjs/passport` AuthGuard signatures).
- Lifecycle of `@nestjs/bullmq` processors (`@Processor`, `@WorkerHost`, `@OnWorkerEvent`) — relatively new and still evolving.
- Nest CLI flags and `nest-cli.json` schema additions (SWC integration, monorepo mode, plugin slots).

## Design Notes

- **Broad-surface variant chosen.** NestJS spans HTTP, microservices, GraphQL, WebSockets, OpenAPI, scheduling, queues, caching, and testing — each with its own decorator surface, lifecycle, and integration shape. Flattening these into a single Documentation Sources table or Core Concepts list would have produced something unscannable. The sub-sectioned table (with the Context7 primary channel pulled out as its own top section) lets the agent jump to the relevant chunk fast.

- **Context7 is non-optional here.** `docs.nestjs.com` is a client-rendered SPA that returns title-only HTML to scrapers (`WebFetch` against any docs page returned literally just the page title in my probes). Without Context7 (`/nestjs/docs.nestjs.com`, indexed from the markdown source repo), the agent would have no programmatic way to retrieve current decorator-option shapes. The agent's "Preferred lookup path" note calls this out explicitly so future invocations don't waste cycles on dead WebFetches.

- **Version timing is favorable.** v11.1.21 shipped May 14, 2026 — three days before authoring. The Context7 source-pinned ID `/nestjs/nest/v11.1.16` lags by five patch releases but is close enough for source-level reference; the docs-indexed ID `/nestjs/docs.nestjs.com` tracks the docs repo (not a NestJS version), so it reflects the latest official documentation regardless of the patch version.

- **The "MIGRATION.md/CHANGELOG.md don't exist" trap.** Common community references suggest looking at `github.com/nestjs/nest/blob/master/MIGRATION.md` or `CHANGELOG.md` — both 404. The canonical sources are `docs.nestjs.com/migration-guide` (sourced from `github.com/nestjs/docs.nestjs.com/blob/master/content/migration.md`) and the GitHub releases page. The sources file documents this so the agent doesn't waste a fetch in the future.

- **Three orthogonal database adapter conventions.** TypeORM and Mongoose have first-party `@nestjs/*` packages and their own narrative docs. Prisma and Drizzle do not — they're community patterns documented (Prisma in the recipes, Drizzle nowhere on the official site). The agent's Database Integration section makes the first-party/community distinction explicit so users don't wait for an `@nestjs/prisma` or `@nestjs/drizzle` package that doesn't exist.

- **Scope/durability is the highest-leverage concept gotcha.** Most "my app got slow after I added [provider]" issues trace back to a `Scope.REQUEST` provider tainting the dep chain. The Core Concepts section spells out the taint rule and the `durable: true` escape hatch because no amount of doc-fetching will help a user who doesn't know to look for it.

- **`MessagePattern` vs `EventPattern` is the second-highest leverage gotcha.** The cold vs hot Observable distinction is non-obvious to RxJS-naive users and is the source of many "my Kafka message never sent" reports — the sender called `.send()` and never subscribed. Embedded in the Microservices Core Concepts section verbatim.

- **Defer-to-Next.js/React policing.** NestJS is often used as the API tier behind a React/Next.js frontend. Many questions a user phrases as "NestJS questions" are actually frontend concerns (CORS config aside). The Scope section names the boundary explicitly so the agent doesn't drift into Technology Next.js or Technology React territory.
