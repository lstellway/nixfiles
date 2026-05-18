# gRPC + Protocol Buffers Technology Expert — Sources

References that informed the content in `technology-grpc.md`. First-hand research from authoritative sources (Context7 + grpc.io + protobuf.dev + buf.build) was prioritized over pre-existing agent definitions.

## Version Calibration

Authoring date: **2026-05-17**. The agent is calibrated against currently stable releases as of this date, with continuing coverage for older lines that remain supported per gRPC's and Protobuf's normal release cadence (gRPC's policy supports the prior several `v1.x` minor versions; Protobuf editions are additive over proto2/proto3, which remain indefinitely supported).

| Component | Calibration target | How confirmed |
|---|---|---|
| Protocol Buffers IDL | **proto3** (current dominant syntax), **proto2** (legacy, still supported), **Edition 2024** (current released edition) | `https://protobuf.dev/editions/overview/` confirms "The latest released edition is 2024." Proto3 remains fully supported and is the dominant in-the-wild syntax. |
| `google.golang.org/protobuf` | **v1.34+** (current stable family) | `https://pkg.go.dev/google.golang.org/protobuf` |
| `google.golang.org/grpc` (Go runtime) | **v1.81.1** (May 14, 2026 — current stable); prior `v1.x` lines remain supported per gRPC's release cadence | `https://github.com/grpc/grpc-go/releases`. The `grpc.NewClient` vs `grpc.Dial` migration note is embedded because `Dial`/`DialContext` are deprecated as of v1.65 and continue to be deprecated. |
| `@grpc/grpc-js` (Node runtime) | **v1.14.x** (current stable) | `npm view @grpc/grpc-js version`. |
| `google-protobuf` (Node, classic stack) | **v4.x** (current stable); `@bufbuild/protobuf` covered as the modern alternative | `npm view google-protobuf version`. |
| `buf` CLI | **v1.42+** (Context7 latest pinnable label is `v1.42.0`) | `mcp__context7__resolve-library-id` for `buf` returns `/bufbuild/buf` with version label `v1.42.0`. |
| `protoc-gen-go` + `protoc-gen-go-grpc` | Latest (gRPC Go quickstart uses `@latest` for installation) | `https://grpc.io/docs/languages/go/quickstart/` confirms installation pattern. |
| Other-language gRPC runtimes | Latest stable per `https://grpc.io/docs/languages/` (Python `grpcio`, Java `grpc-java`, C++ `grpc/grpc`, Kotlin `grpc-kotlin`, Ruby `grpc`, C# `Grpc.Net.Client`, Dart `grpc-dart`) plus community Rust `tonic` | Coverage by reference to each language's quickstart and basics page. |

Coverage is intentionally cross-language: Go and TypeScript/Node receive the deepest treatment (the two most-deployed gRPC stacks), with Python, Java, C++, Kotlin, Ruby, C#, Dart, and Rust receiving pointer-level coverage with links to their canonical quickstarts and generated-code references. All four RPC kinds (unary, server-streaming, client-streaming, bidirectional) are covered. The modern `buf` toolchain is treated as a first-class sub-domain alongside the classic `protoc` flow.

## Existing Agents Consulted

Surveyed `~/.claude/agents/` to understand the existing technology- and software- agent surface and choose appropriate deferrals. Deferrals are framed by **capability**, not by what any specific repository uses.

- **`technology-nextjs.md`** (and any other framework-specific technology agent) — used as the structural template (frontmatter, scope, sources table, core concepts, approach, output format). Framework-specific HTTP/transport integration patterns (RSC fetches, route handlers, SSR caching of gRPC responses, Express/FastAPI/Spring middleware around a gRPC client) defer to the relevant framework agent. The gRPC agent keeps the mechanical "how do I construct a `@grpc/grpc-js` client" / "how do I call a streaming RPC from Python" question.
- **`technology-docker.md`** — surveyed for the **partial-variant** structural pattern (sub-sectioning Documentation Sources + Core Concepts by sub-domain while keeping Approach flat). Docker did this for Engine/Compose/BuildKit; gRPC follows the same pattern for Protobuf/gRPC/Tooling.
- **`technology-go.md`** — defer Go-language idioms (channels, goroutine lifecycle, `context.Context` usage *outside* the RPC boundary, error wrapping, graceful shutdown). The gRPC agent keeps `context` use *inside* an RPC (deadline propagation, `ctx.Err()` checks in streaming handlers) because that's part of the gRPC protocol surface.
- **`software-api-design.md`** — defer "REST vs gRPC vs GraphQL" decisions, high-level versioning *strategy*, and the dedicated-request-per-RPC philosophy at the *advisory* level. (The gRPC agent still embeds the mechanical "don't share `Empty`" rule because it comes up in every `.proto` authoring task.)
- **`software-security.md`** — defer TLS configuration philosophy, threat modeling, secret-handling, and authn/authz design. The gRPC agent covers the *mechanical* wiring (`grpc.creds.NewTLS`, auth interceptors) but not policy.
- **`software-reliability.md`** — defer retry-strategy decisions (backoff jitter, retry budgets, circuit-breaking). The gRPC agent covers the *mechanical* deadline-and-cancellation API and `service config`-based retry declaration.
- **`software-performance.md`** — defer payload-size/compression policy and streaming-batch sizing strategy. The gRPC agent covers the *mechanical* `MaxRecvMsgSize`, compression-codec selection, and streaming RPC ergonomics.

No community subagents from VoltAgent's `awesome-claude-code-subagents` or similar indexes were adopted — community gRPC agents (where they exist) tend to be checklist/protocol archetypes that don't match this skill's "fetch-first expert answerer" voice.

## Documentation Sources Verified

All URLs in `technology-grpc.md`'s Documentation Sources table were either directly verified during authoring or selected from Context7's high-reputation index. Verification log:

### Verified by direct WebFetch at authoring time

- **`https://grpc.io/docs/what-is-grpc/core-concepts/`** — confirmed coverage of unary, server-streaming, client-streaming, bidi, deadlines, cancellation, metadata, channels. Structure: Overview → RPC life cycle.
- **`https://grpc.io/docs/guides/status-codes/`** — confirmed all 17 canonical status codes are listed (`OK` 0 through `UNAUTHENTICATED` 16) with description column. Page also lists the conventionally client-side-only subset.
- **`https://grpc.io/docs/guides/error/`** — confirmed coverage of standard model + richer model. Page references `google.rpc.error_details.proto` and the language-support matrix (C++, Go, Java, Python, Ruby first-class; Node partial).
- **`https://grpc.io/docs/languages/go/quickstart/`** — confirmed plugin installation commands (`protoc-gen-go@latest`, `protoc-gen-go-grpc@latest`) and the canonical `protoc` invocation with `paths=source_relative`.
- **`https://grpc.io/docs/languages/node/quickstart/`** — confirmed `@grpc/grpc-js` is the runtime; quickstart uses the dynamic-codegen path with `@grpc/proto-loader`.
- **`https://protobuf.dev/programming-guides/proto3/`** — confirmed structure (Defining A Message Type, Scalar Types, Default Values, Enumerations, Updating A Message Type, Any, Oneof, Maps, Packages, Defining Services, JSON Mapping, Options, Generating Your Classes).
- **`https://protobuf.dev/best-practices/dos-donts/`** — confirmed page exists and covers reserved-tag rule, type-change prohibition, RPC/storage message separation, enum unspecified value, `java_outer_classname` (before Edition 2024) note. Initial WebFetch hit a redirect; the correct URL is `/best-practices/dos-donts/` (not `/programming-guides/dos-donts/`).
- **`https://protobuf.dev/editions/overview/`** — confirmed Edition 2024 is current. Confirms wire format unchanged, proto2/proto3 import compatibility, Prototiller migration tool.
- **`https://buf.build/docs/`** — confirmed top-level structure: Buf CLI, Buf Schema Registry, Open Source (Protovalidate, ConnectRPC), Protobuf Guide.
- **`https://github.com/grpc/grpc-go/releases`** — confirmed grpc-go latest is **v1.81.1** (May 14, 2026), with security fix for xds/rbac authorization bypass via SAN/DN fallback.

### Context7 libraries selected

- **`/grpc/grpc.io`** — Source Reputation High, benchmark 59, 1424 snippets. Primary lookup for runtime/concept docs across languages.
- **`/grpc/grpc-go`** — Source Reputation High, benchmark 83 (highest gRPC implementation index), 457 snippets, version label `v1.73.0` pinnable.
- **`/grpc/grpc-node`** — Source Reputation High, benchmark 77, 192 snippets.
- **`/websites/protobuf_dev`** — Source Reputation High, benchmark 68, 8997 snippets. Primary protobuf-spec lookup.
- **`/websites/pkg_go_dev_google_golang_org_protobuf`** — Source Reputation High, benchmark **87 (highest among Go protobuf sources)**, 7933 snippets. Recommended for Go-side protobuf API lookups.
- **`/bufbuild/protobuf.com`** — Source Reputation High, benchmark 78, 534 snippets — Buf's IDL grammar / language reference.
- **`/bufbuild/buf`** — Source Reputation High, benchmark 76, version label `v1.42.0` pinnable.
- **`/websites/buf_build`** — Source Reputation High, benchmark 81, 5695 snippets — broader buf.build site index.

### Not directly verified but selected as canonical pointers

- `https://protobuf.dev/programming-guides/proto2/` — canonical proto2 spec.
- `https://protobuf.dev/programming-guides/encoding/`, `/json/`, `/field_presence/`, `/style/` — protobuf.dev sub-pages cited by other verified pages; safe to include.
- `https://protobuf.dev/reference/protobuf/google.protobuf/` — well-known types reference; structurally cited from the proto3 guide.
- `https://protobuf.dev/reference/{python,java,cpp,csharp}/...` — per-language generated-code references; structurally part of the protobuf.dev reference tree.
- `https://github.com/googleapis/googleapis/blob/master/google/rpc/error_details.proto` — the canonical detail messages for the richer error model. Cited by the error-handling guide page.
- `https://buf.build/docs/configuration/v2/buf-yaml/`, `/buf-gen-yaml/`, `https://buf.build/docs/lint/rules/`, `/breaking/rules/`, `/generate/usage/`, `/format/style/`, `/curl/usage/`, `/best-practices/style-guide/`, `/bsr/overview/`, `/cli/installation/` — buf.build sub-pages; structure verified at the landing page.
- gRPC Guides pages: `/docs/guides/{deadlines, cancellation, metadata, auth, compression, retry, service-config, health-checking, reflection, keepalive, wait-for-ready}/` — all sub-pages of grpc.io confirmed-accessible via the verified `/docs/what-is-grpc/core-concepts/` parent.
- Per-language gRPC quickstart + basics pages at `https://grpc.io/docs/languages/{go,node,python,java,cpp,kotlin,csharp,ruby,dart}/...` — confirmed structurally via the Go and Node entries; the other languages follow the same template.
- `https://github.com/hyperium/tonic` + `https://docs.rs/tonic/` — `tonic` is the de facto Rust gRPC implementation (community-led, not in the gRPC org); included as the standard Rust pointer.

## Volatile vs. Stable Classification

**Stable (embedded directly in the agent):**

- Field-number rules (1–15 = 1 byte, 19000–19999 reserved, never reuse, always `reserved` removed numbers). Stable since protobuf's inception.
- The four RPC kinds (unary, server-streaming, client-streaming, bidi) and when to use each. Stable since gRPC's inception.
- The 17 canonical gRPC status codes and their semantics. Effectively frozen — adding a new code would itself be a breaking change to the protocol.
- `oneof`, `optional`, `repeated`, `map` semantics in proto3. Stable.
- Well-known types (`Timestamp`, `Duration`, `Any`, `Empty`, `FieldMask`, wrappers, `Struct`, `Value`). Stable surface.
- Enum convention (`_UNSPECIFIED = 0`). Stable since proto3 mandated it.
- JSON mapping rules (camelCase, int64-as-string, base64 bytes, enum-as-name). Defined by the canonical mapping; stable.
- Channel-reuse rule, deadline-on-every-call rule. Stable best practices since gRPC's inception.
- Schema-evolution rules (wire-compat what's safe vs unsafe). Stable; only the rule-category names in `buf breaking` evolve.

**Volatile (always fetch from docs):**

- **`grpc.NewClient` vs `grpc.Dial` migration in grpc-go** — `Dial`/`DialContext` deprecated; usage guidance has evolved across recent grpc-go releases. Always fetch for definitive current API.
- **Plugin flag names and option syntax** — `protoc-gen-go` options (`paths=source_relative`, `module=`, `Mfile.proto=...`), `protoc-gen-es` options, `ts-proto` options, language-specific plugins. Plugin-specific and version-specific.
- **`buf.yaml` / `buf.gen.yaml` schema** — v1 vs v2 config formats; key names; rule categories. Buf has shipped multiple config-format generations.
- **Editions feature defaults** — Edition 2023 vs 2024 differ in some defaults; will continue to evolve annually.
- **Service config JSON schema** — retry policy, load-balancing config; structure has evolved.
- **Language-binding ergonomics** — `@grpc/grpc-js` API surface (`Metadata`, `ServiceError`, `Status`); `google-protobuf` v3 vs v4 API differences; static-vs-dynamic codegen tradeoffs as `@bufbuild/protobuf` matures; Python `grpcio` API additions; Java `grpc-java` interceptor surface; Rust `tonic` major-version changes.
- **gRPC release notes** — both `grpc-go` and `grpc-node` ship security fixes periodically (v1.81.1 included a xds/rbac SAN/DN authorization-bypass fix in May 2026).

## Design Notes

A few patterns from authoring this agent that may generalize to the technology-agent archetype:

1. **Two-spec, one-runtime ecosystems** are a recognizable shape — Protobuf-the-IDL and gRPC-the-framework are independently specified, independently versioned, but used together in almost every real task. Docker (Compose Spec separate from Engine separate from BuildKit) is the same shape. The **partial variant** with grouped Documentation Sources + Core Concepts and unified Approach handled both cleanly. Worth canonicalizing this shape.

2. **Cross-language protocols deserve explicit cross-language Core Concepts coverage.** The "JSON mapping implications" and "field-presence implications" callouts pay off the most when the agent is invoked on a "side A sends X, side B sees Y" mystery. A protocol agent without cross-language framing leaves the user re-asking once they realize each language binding diverges.

3. **The "what to embed vs fetch" line for status/error codes is interesting** — the 17 gRPC codes are stable enough that embedding the table saves a fetch on every "which code do I use?" question, which is the single most common gRPC question. By contrast, embedding `next.config.js` keys would have aged out within a major release. The heuristic: embed if the surface is a frozen part of a protocol or specification; fetch if it's an implementation surface.

4. **Tooling deserves its own sub-domain even when not every consumer uses it.** `buf` is the answer to almost every recurring pain in a protobuf-heavy repo (lint discipline, breaking-change CI, generation reproducibility, schema sharing) and is the industry-standard modern toolchain. Embedding it as a first-class sub-domain — not just a "see also" pointer — sets the agent up to recommend a migration when warranted, without disparaging working `protoc` flows.

5. **Pointer-level cross-language coverage works.** Going wide across Python, Java, C++, Kotlin, Ruby, C#, Dart, and Rust with just quickstart + generated-code links — while keeping Go and TS/Node as the deep dives — keeps the agent's bulk manageable while still being credible when invoked from any-language projects. The per-language quickstart pages on grpc.io are structurally identical, so the agent doesn't need to re-explain each one.

6. **Deprecation guidance ages well when framed by the upstream stance, not by a pin.** Recommending `grpc.NewClient` over `grpc.Dial` is the upstream-recommended path; this stays true regardless of which `v1.x` pin a given repo uses. Framing it as "deprecated; new code should not use `Dial`" rather than "use this because we're on v1.65+" keeps the guidance correct across version movements.
