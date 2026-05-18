# technology-go.sources.md

Provenance and version calibration for `technology-go.md`.

## Existing agents and skills consulted

- **`agent-technology` skill** (`/Users/logan/.claude/skills/agent-technology/SKILL.md`) — the 9-step authoring methodology; followed verbatim. Persona frame ("deep expertise + fetch-first discipline") adopted.
- **`technology-docker.md`** — used as the tonal/structural model. Adopted: the "Primary lookup channel" header preceding a Context7-first row, the per-area sub-tables under Documentation Sources, the per-task-type bullet style in Approach, and the "Adapt to the task" Output Format pattern. Did not adopt: the partial-variant sub-domain restructuring (Go is flat, see Step 1 note below).
- **`technology-nix.md`** — confirmed the flat-variant pattern (single Documentation Sources table, single Core Concepts, single Approach). Adopted the "fetch from authoritative sources when precision matters" framing and the lightweight "Adapt to the task" Output Format. Used as the reference for what a *flat* technology agent looks like.
- **`technology-kubernetes.md`** — sampled for its sub-domain Scope bullets and explicit "Defer to peer agents" enumeration. Adopted the practice of naming each peer agent explicitly with what defers, rather than generic "the security agent."
- **`technology-github-actions.md`** — sampled for its "calibrated to date" pattern (the agent calls out the live calibration date). Adopted in the opening sentence.
- **`technology-grpc.md`** and **`technology-gorm.md`** — sibling library agents. The Go agent defers to both for their respective libraries; this includes Go server-side gRPC wiring (owned by `technology-grpc.md`) and all GORM-specific API questions (owned by `technology-gorm.md`).

Community agent indexes (VoltAgent's awesome-claude-code-subagents and similar) were not consulted — per the skill's guidance these are for scope sanity checks only, and the Go scope here is well-bounded by the language + stdlib + toolchain.

## Version calibration

Calibrated against **Go 1.26** as of **2026-05-17** with full support back through **Go 1.21** (the oldest minor inside Go's two-release support window — Go's policy is that the current minor and the immediately previous minor receive security fixes).

Rationale: the agent is general-purpose and lives in `~/.claude/agents/`, invoked from arbitrary projects. The latest *upstream* stable release as of 2026-05-17 is **Go 1.26.3** (released 2026-05-07; verified via WebFetch of `https://go.dev/doc/devel/release`), so the agent targets that by default but knows the Go 1.21 → 1.26 landmark changes so it can answer questions about any supported version. For projects pinned to an older `go.mod` directive, the agent should note which-version-introduced-what when relevant.

Go-language landmark version dates the agent references:

- 1.18 (Mar 2022) — generics (type parameters, `any`, `comparable`, `~T`)
- 1.19 (Aug 2022) — typed `atomic.Int64`/`atomic.Pointer[T]`; `GOMEMLIMIT`
- 1.20 (Feb 2023) — `errors.Join`; `math/rand` global auto-seeded; multi-error wrapping in `%w`
- 1.21 (Aug 2023) — `slices`, `maps`, `log/slog`; `min`/`max`/`clear` builtins; relaxed generic inference; toolchain auto-download
- 1.22 (Feb 2024) — `for` loop variable per-iteration scoping; `http.ServeMux` method/wildcard patterns; `for i := range n` over integers
- 1.23 (Aug 2024) — `iter`, range-over-func; `unique` package; timer reset semantics fixed
- 1.24 (Feb 2025) — `testing/synctest` (experimental); generic type aliases; weak pointers; FIPS 140 module
- 1.25 (Aug 2025) — `synctest` GA; `encoding/json/v2`; `sync.WaitGroup.Go`; container-aware GOMAXPROCS
- 1.26 (current upstream stable as of 2026-05-17) — confirm specific changes via `go.dev/doc/go1.26` release notes when relevant

## Documentation sources verified at authoring time

All verified 2026-05-17 unless noted.

**Context7 IDs** (via `mcp__context7__resolve-library-id` and `mcp__context7__query-docs`):

| Library ID | Verified | Notes |
|---|---|---|
| `/websites/pkg_go_dev_go1_25_3` | ✓ | Go stdlib pinned at 1.25.3 — ~11k snippets, benchmark 73. **This is the agent's preferred primary source for stdlib lookups.** For 1.26-specific behavior, the agent is instructed to resolve a newer index ID first. |

**Direct URL verifications** (via WebFetch):

| URL | Verified | Notes |
|---|---|---|
| https://go.dev/doc/ | ✓ | Index confirmed; section structure matches what the agent's table assumes. |
| https://pkg.go.dev/std | ✓ | Returned at version go1.26.3 — agent uses this for stdlib package index regardless of pinned Go version (the package list is stable; per-symbol pages reflect the latest version). |
| https://go.dev/ref/spec | ✓ | Language spec; page returned references Go 1.26 — agent notes spec is generally stable across minors. |
| https://go.dev/doc/effective_go | ✓ | Confirmed; agent notes this doc predates modules and generics. |
| https://go.dev/ref/mod | ✓ | Modules reference; sections match what agent's Core Concepts cites (MVS, workspaces, `go.mod` directives). |
| https://go.dev/doc/devel/release | ✓ | Release history; current is 1.26.3 (2026-05-07). |

URLs referenced but not individually fetched at authoring time (well-known canonical endpoints, low risk of being wrong):

- `https://pkg.go.dev/cmd/go` (Go command reference)
- `https://go.dev/ref/mem` (memory model)
- `https://go.dev/doc/gc-guide`
- `https://go.dev/doc/diagnostics`
- `https://go.dev/doc/go1.<minor>` (per-release notes)

If any of these 404 on first use, the agent's instinct to fall back to `https://go.dev/` as a hub will recover.

## Volatile vs. stable classification

**Embedded (stable foundational knowledge):**

- Language design philosophy and identifier export rules
- Goroutine + channel + `select` + `context` model — the four-cell channel-op-vs-state table, the cancellation pattern, the `sync` primitive guide
- Error handling idioms — `%w` vs `%v`, sentinel vs wrapped vs typed, `errors.Is`/`As`/`Join`
- Generics basics — type parameters, constraint forms, `comparable`/`any`, `~T` underlying-type approximation, generic type aliases (1.24+)
- Module/workspace concepts — `go.mod` directives, MVS, `replace`, `go.work`
- Testing idioms — table-driven, subtests, `t.Parallel`, `httptest`, `-race`, fuzzing
- Stdlib high-leverage packages at the conceptual level (`context`, `net/http` graceful shutdown, `database/sql` pool semantics, `log/slog`, `time` monotonic clocks)
- Go idioms — accept interfaces/return concretes, `internal/`, zero-value usability, defer-for-cleanup, "goroutines should know how to stop"

**Always fetched (volatile / version-sensitive):**

- Exact stdlib signatures and their introduction version (`go doc <pkg>.<Sym>` is the fastest path)
- `go` command flags and behavior (changes every minor release)
- Go version landmarks (release notes pages)
- Vulnerability data via `govulncheck`
- Third-party library APIs (deferred to library-specific peer agents where they exist; otherwise fetched from the library's docs)

## Structural variant: flat (justified)

Per Step 1 of the skill, the ternary choice was: flat, partial, or full broad-surface.

**Chose flat.** Justification:

- The Go language, the `go` toolchain, and the standard library are *tightly* coupled — they version together, document together at `go.dev`, and are designed as one coherent system. The same `go` binary that builds also tests, formats, and downloads modules; there is no separate `gofmt` distribution to track.
- Third-party libraries have been *removed* from this agent's embedded knowledge and routed to peer agents (`technology-grpc.md` for gRPC including Go server wiring, `technology-gorm.md` for GORM). The Go agent's scope is the language, the stdlib, and the toolchain — that is a coherent flat domain.
- Contrast with Docker (partial): there, Engine, BuildKit, and Compose really are distinct codebases with distinct specs and distinct docs hubs. For Go, the core language and toolchain do not have that profile — one Core Concepts and one Approach handle the entire scope.
- Contrast with Kubernetes / WordPress / NestJS (full broad-surface): those have genuinely orthogonal sub-ecosystems where the task strategies meaningfully differ across them. Go's core (language + stdlib + toolchain) does not.

The Documentation Sources table is sub-sectioned (Bash command shortcuts, Primary online channel, Language/stdlib/toolchain, Popular Go libraries) for *scannability*, but Core Concepts and Approach remain flat.

## Design notes (Step 9 — patterns worth surfacing)

A few patterns emerged here that may generalize to other language-runtime agents:

1. **The "in-system lookup over web fetch" pattern, expressed as a dedicated Bash-command sub-table under Documentation Sources.** For technologies with strong introspection (`go doc`, `kubectl explain`, `nix search`, `terraform providers schema`, `helm show values`), promoting the local-command path *above* the web URL in the table is the skill's guidance — but giving it its own labeled sub-section ("Bash command shortcuts (preferred for in-environment lookup)") makes the agent more reliably reach for it. Worth lifting into the skill as the standard pattern for any technology with first-class introspection.

2. **Support-window framing over single-version pinning for general-purpose agents.** An earlier draft pinned the agent to "Go 1.25 because that's what the codebase uses." For a reusable general-purpose agent in `~/.claude/agents/`, this is wrong — the agent gets invoked from arbitrary projects. The fix: state the *current stable* release date-stamped, plus the *supported window* (here, "back through Go 1.21 per Go's two-release security policy"), so the agent can confidently answer for any project's pinned version without sounding parochial. Worth lifting into the skill: a general-purpose technology agent should frame its calibration as "current stable as of <date>, with coverage back through <oldest-supported>" rather than "version X because the codebase uses X."

3. **The "library-as-peer-agent, not embedded cookbook" distinction.** An earlier draft embedded full cookbooks for gRPC server wiring, GORM, and Atlas — all libraries the original calling codebase used. Once dedicated peer agents existed (`technology-grpc.md`, `technology-gorm.md`), those embedded cookbooks became duplicate-maintenance liability. The corrected scope: this agent owns the language, stdlib, and toolchain; library specifics route to dedicated library agents (with a brief "popular libraries" table for awareness and routing). Worth a note in the skill: when a peer agent exists for a library, the language agent should defer rather than embed — embedded library cookbooks decay faster than language fundamentals and create conflict between agents.

4. **The "defer to peer agent but volunteer the bridge info" pattern.** Repeated throughout this agent's deferrals: "K8s manifest defers — but volunteer healthz/graceful-shutdown wiring"; "Dockerfile defers — but volunteer `CGO_ENABLED=0 -trimpath -ldflags='-s -w'`." This makes deferrals useful rather than just stopping the conversation. Worth adding to the skill's "Defer to peer agents for" guidance: deferrals should include what to *volunteer to the user before deferring*, not just what to route away.

5. **Embedding the four-cell channel-operation-vs-state table.** Truth tables with sharp edges (panics, blocks-forever, returns-zero-value) are exactly the kind of thing LLMs get wrong from training data and exactly the kind of thing too valuable to make the agent fetch every time. The pattern of "embed the truth table; cite the page" applies to lots of language semantics surfaces (Python's MRO rules, Rust's borrow-checker rules, JS's `this` rules). Worth a note that embedded truth tables are high-leverage content.
