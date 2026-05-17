# Docker Technology Expert — Sources

References that informed `technology-docker.md`. Prioritizes Context7 (live-indexed against the `docker/docs` GitHub mirror) and the official `docs.docker.com` site, with the `compose-spec/compose-spec` repo as the canonical authority for Compose questions.

## Version Calibration

- **Docker Engine pinned**: **29.5.x** (latest stable, released 2026-05-14 per the release notes page). v29.0.0 made the containerd image store the default for fresh installs and introduced several breaking changes (deprecated API removals).
- **BuildKit**: bundled default builder since Engine 23.0 (mid-2023); calibration assumes the version shipped with Engine 29.x. Dockerfile frontend `docker/dockerfile:1` stable channel.
- **Docker Compose v2 (plugin)**: latest v2 line ~v2.40.x as of confirmation; the GitHub releases page also shows a new v5.x line is in development but v2 is current stable for typical use. Legacy `docker-compose` (Python) is deprecated.
- **Compose Specification**: canonical at `compose-spec/compose-spec`; recent additions tracked include `attach` (Compose v2.20.0), `develop` (v2.22.0), `gpus` (v2.30.0). Spec is platform-agnostic; the version-the-feature-arrived-in is the Compose implementation version, not a spec version.
- **OCI Image Spec**: v1.1.1 (March 2025).
- **Date confirmed**: 2026-05-17.

## Existing Agents and Skills Consulted

- **Repo-local style references** (`technology-payloadcms.md`, `technology-payloadcms.sources.md`, `technology-nix.md`) — adopted for tone, section ordering (Scope → Sources → Core Concepts → Approach → Output Format), persona frame (deep expertise + fetch-first), Context7-as-top-row convention, and the broad-surface variant treatment for sub-section grouping. Content authored independently from primary sources.
- **VoltAgent `awesome-claude-code-subagents`** (https://github.com/VoltAgent/awesome-claude-code-subagents) — checked for prior Docker-specific subagent art as a scope sanity check only. No content adopted; their archetype (checklist/protocol-style DevOps agents) conflicts with this skill's fetch-first answerer voice. Confirms scope decision to keep Docker as its own expert and defer K8s/CI to peers.
- **`agent-technology` SKILL.md** — followed all nine steps; specifically used the "broad-surface variant" guidance for the Documentation Sources table grouping (Engine/Dockerfile/Build vs Compose vs Standards) and for the Core Concepts sub-headings on Compose. The Approach section was kept as a flat sequence of task-strategy paragraphs (rather than splitting by sub-domain) because most real Docker questions cross Dockerfile/CLI/Compose boundaries and a flat approach reads more naturally.

## Primary Sources

### Context7 (primary lookup channel)

Resolved via `mcp__context7__resolve-library-id`:

- **`/docker/docs`** — High reputation, benchmark 84, 6,782 snippets. Indexes the `docker/docs` GitHub source tree (which is what backs docs.docker.com). **Top-row choice** — fastest and source-linked. Verified with a `query-docs` call against `HEALTHCHECK` syntax; returned high-quality, source-attributed snippets from the BuildKit Dockerfile reference and Compose services reference.
- **`/websites/docker_reference`** — High reputation, benchmark 82.27, 4,265 snippets. Reference-focused (APIs, CLIs, specs). Good alternative when narrative `docker/docs` content is not granular enough.
- **`/llmstxt/docker_llms_txt`** — High reputation, benchmark 80.81, 18,909 snippets — largest snippet corpus. Useful when looking for niche content but unsorted by docs taxonomy.
- **`/moby/buildkit`** — High reputation, benchmark 83.4, 709 snippets. Best for BuildKit internals (LLB, frontends, advanced mount semantics) not surfaced in user-facing docs.
- **`/compose-spec/compose-spec`** — High reputation, benchmark 71.05, 759 snippets. **The canonical Compose Specification** — when Compose docs and the spec disagree, the spec is authoritative.
- **`/compose-spec/compose-go`** — High reputation, benchmark 86.5, 99 snippets. Go parser reference; useful when you need to know exactly how a key is interpreted.
- **`/docker/compose`** — High reputation, benchmark 76.52, 122 snippets. The Compose v2 implementation.

### Official Documentation (verified at authoring time)

All URLs confirmed accessible and on-topic via WebFetch on 2026-05-17. Findings:

- **https://docs.docker.com/reference/dockerfile/** — Dockerfile reference. All 17 instructions in scope confirmed present. Top of page recommends `# syntax=docker/dockerfile:1`.
- **https://docs.docker.com/reference/cli/docker/** — CLI reference index. All major subcommand groups present. Doesn't pin a specific Engine version on the page itself.
- **https://docs.docker.com/build/** — Build docs index. Page exists but the WebFetch summary returned a thin excerpt; structure is correct but content is light at the index level — use sub-pages for detail.
- **https://docs.docker.com/build/concepts/overview/** — Build concepts. Confirms client-server (Buildx ↔ BuildKit) architecture.
- **https://docs.docker.com/build/buildkit/** — BuildKit. Confirms default-builder status (Linux containers; Windows containers still use legacy), frontends, LLB.
- **https://docs.docker.com/build/buildkit/dockerfile-frontend/** — Dockerfile frontend. Confirms `# syntax=` directive, `docker/dockerfile:1` stable, `:1-labs` experimental.
- **https://docs.docker.com/build/builders/** — Builders and drivers. Confirms 4 drivers (`docker`, `docker-container`, `kubernetes`, `remote`), `docker buildx ls/use`, `BUILDX_BUILDER` env, `--builder` flag.
- **https://docs.docker.com/build/building/multi-stage/** — Multi-stage. Confirms `AS <NAME>`, `COPY --from=<stage|image>`, `--target` for stopping at a stage, and the BuildKit-only behavior of skipping unneeded stages.
- **https://docs.docker.com/build/building/multi-platform/** — Multi-platform. Confirms `docker buildx --platform`, QEMU emulation, and cross-compile pattern using `BUILDPLATFORM`/`TARGETOS`/`TARGETARCH` predefined ARGs.
- **https://docs.docker.com/build/building/secrets/** — Build secrets. Confirms `--secret id=,src=`, `RUN --mount=type=secret,id=,target=`, `--ssh default` + `--mount=type=ssh`, and `GIT_AUTH_TOKEN` / `GIT_AUTH_HEADER` predefined secrets for Git context auth.
- **https://docs.docker.com/build/cache/** — Build cache mechanics. Confirms cache invalidation cascades on layer change.
- **https://docs.docker.com/build/cache/optimize/** — Cache optimization. Confirms cache mount examples for Go/apt/npm/pip/cargo/dotnet/composer, layer ordering guidance, `.dockerignore`.
- **https://docs.docker.com/build/cache/backends/** — Cache backends. Confirms 5 backends (inline, registry, local, gha [beta], s3 [unreleased at time of doc]), `--cache-to`/`--cache-from`, mode `min|max`, OCI media types.
- **https://docs.docker.com/engine/network/** — Networking. Confirms all 6 Linux drivers (bridge, host, none, overlay, ipvlan, macvlan).
- **https://docs.docker.com/engine/storage/** — Storage. Confirms volumes / bind mounts / tmpfs distinction; mentions containerd image store and graph drivers.
- **https://docs.docker.com/engine/security/** — Security overview. Confirms namespaces, cgroups, capabilities, userns (since 1.10), seccomp, AppArmor/SELinux integration, content trust, rootless reference.
- **https://docs.docker.com/engine/security/rootless/** — Rootless mode. Confirms installation methods (RPM/DEB, `get.docker.com/rootless` script), `newuidmap`/`newgidmap` + `/etc/subuid`/`/etc/subgid` prerequisites. Page content is thinner than ideal — limitations and networking are not deeply covered there; supplement with the spec / KB articles when needed.
- **https://docs.docker.com/engine/release-notes/** — Release notes. Confirmed Engine **29.5.0** latest (2026-05-14); v29.0.0 made containerd image store default for fresh installs.
- **https://docs.docker.com/compose/** — Compose docs index. Confirms introductory content; sub-pages carry the detail.
- **https://docs.docker.com/reference/compose-file/** — Compose file reference (the Compose Specification on docs.docker.com). Confirms this is the implementation reference; refers users to the `compose-spec` repo as the canonical spec.
- **https://docs.docker.com/compose/how-tos/file-watch/** — `develop.watch`. Confirms three actions (`sync`, `rebuild`, `sync+restart`), `initial_sync`, ignore patterns.
- **https://docs.docker.com/reference/cli/docker/image/history/** — `docker image history`. Confirms IMAGE / CREATED / CREATED BY / SIZE columns.
- **https://docs.docker.com/get-started/docker-overview/** — Overview. Confirms architecture (daemon, client, registry, Docker Desktop, objects).
- **https://hub.docker.com/** — Docker Hub. Reachable.

### Standards & ecosystem

- **https://github.com/compose-spec/compose-spec** — Compose Specification repo. Confirmed structure: numbered chapter files `00-overview.md` through `15-profiles.md`, plus `spec.md`. Website mirror at `compose-spec.io`. Reference implementation: Docker Compose.
- **https://github.com/compose-spec/compose-spec/blob/main/spec.md** — `spec.md` itself. Confirmed. Recent additions tracked: `attach` (v2.20.0), `develop` (v2.22.0), `gpus` (v2.30.0). Spec includes guidance on how implementations should handle unsupported attributes (default / strict / loose modes).
- **https://github.com/opencontainers/image-spec** — OCI Image Spec, v1.1.1 (March 2025). Confirms manifest / config / layers / descriptor / image index structure.
- **https://github.com/moby/buildkit** — BuildKit source. Authoritative for LLB and frontend internals.
- **https://github.com/docker/compose/releases** — Compose v2 release notes (the `docs.docker.com/compose/releases/release-notes/` URL **301-redirects here**). Latest v2.40.3 (Oct 2024 era from the WebFetch sample); a separate v5.x line is in development per the same page.

### URLs noted as redirected or thin

- **https://docs.docker.com/compose/releases/release-notes/** → **301** to https://github.com/docker/compose/releases. Agent sources table points to the GitHub URL directly.
- **https://docs.docker.com/build/** — index page is thin; sub-pages carry the substance. Agent table includes both the index and the specific sub-pages.
- **https://docs.docker.com/compose/** — same; index is intro-only.
- **https://docs.docker.com/engine/security/rootless/** — page content is less comprehensive than the section name implies (no networking/storage limitations detail at that URL). Acceptable as the entry-point; deeper rootless questions may need supplementary fetches.

No 404s encountered.

## Volatile vs. Stable Classification

**Embedded (stable across recent Engine versions — unlikely to change without a major)**:

- Image / container conceptual model (layers, manifest, config, namespaces).
- Dockerfile instruction set and the exec-vs-shell-form distinction.
- The `ENTRYPOINT` + `CMD` interaction.
- `COPY` vs `ADD` guidance.
- The build cache invalidation rule (input hash → cascading misses).
- Multi-stage build pattern and `COPY --from`.
- Network driver list and the default-bridge-vs-user-defined-bridge DNS distinction.
- Volume / bind mount / tmpfs trade-offs.
- OCI image format structure (manifest / config / layers / index).
- Compose Specification top-level structure (services / networks / volumes / secrets / configs).
- The Local-bridge-by-default and `-p` port-publishing semantics.
- Rootless trade-offs.

**Always fetch (volatile — version-sensitive)**:

- Specific Dockerfile instruction option flags (`HEALTHCHECK --start-interval` is recent; `COPY --link` was BuildKit-only when introduced).
- BuildKit mount option syntax (`--mount=type=cache` properties — `id`, `sharing`, `from`, `source`, `uid`/`gid`/`mode` — evolve with frontend versions).
- Cache backend option keys per backend type.
- `docker` CLI subcommand flag inventory (large and growing).
- Compose service-level keys (the spec adds keys regularly — `gpus`, `develop.watch`, etc.).
- Compose feature-introduction version numbers.
- Engine release-notes breaking changes (Engine 29.0 containerd image store default, iptables behavior changes around 28).
- Buildx driver-specific options.
- `--provenance` / `--sbom` flag values and defaults (changed multiple times).
- Multi-platform build behavior with QEMU vs cross-compile (predefined ARG set has grown).

## Design Notes

- **Broad-surface variant chosen for the Sources table; flat for Approach.** Docker has three meaningfully distinct sub-ecosystems — Engine/Dockerfile/Build, Compose, and Standards — each with its own canonical source set. Grouping the table preserves scannability. The Core Concepts section similarly sub-sections Compose under its own heading so it doesn't crowd out Engine content. However, the Approach section was kept as a flat task-strategy list because most real Docker questions cross sub-domain boundaries (a Compose service needs a Dockerfile; a build-cache question intersects with `develop.watch`); a per-sub-domain Approach would have duplicated and fragmented guidance.
- **Compose Specification as canonical source, not docs.docker.com.** The skill emphasizes preferring official documentation, but for Compose specifically there are *two* official sources — `compose-spec/compose-spec` (platform-agnostic spec) and `docs.docker.com/reference/compose-file/` (Docker's implementation reference). They normally agree, but when they don't, the spec is authoritative. The agent documents this explicitly so it doesn't blindly trust the Docker mirror.
- **Cardinal-rule embedding for the build cache.** The single most common Docker question after "how do I write a Dockerfile" is "why is my build slow / why isn't the cache working." Embedding the invalidation rule (input change → cascading downstream misses) and the layer-ordering corollary directly is high-leverage; it's foundational and doesn't change between versions. Cache mount syntax, by contrast, is fetched because it evolves.
- **ENTRYPOINT/CMD table.** The exec-form / shell-form interaction with `ENTRYPOINT` + `CMD` is the single Dockerfile concept that produces the most "why isn't this working?" questions. Putting it in a compact comparison table is more useful than prose. The signal-handling consequence of shell form (SIGTERM gets swallowed) is called out because it surfaces as production incidents.
- **Docker Desktop bind mount perf as a first-class footnote.** Many "Docker is slow" questions on macOS are bind mount perf on Desktop, not an actual Docker issue. The agent calls this out in Core Concepts and again in the Approach section so it doesn't waste time diagnosing the wrong layer.
- **Defer boundaries are tighter than for some technologies.** Docker sits next to Kubernetes, Helm, DevOps (CI/CD), and Security. Each of those has natural overlap. The Scope section names the boundaries explicitly with examples ("a Dockerfile question is yours; 'how do I run this image in K8s' defers") so the agent doesn't drift. The agent does volunteer Docker-side info (image ref, port, healthcheck endpoint) when deferring to K8s, so the user has what they need to bridge.
- **Context7 was an unambiguous top-row choice.** Benchmark 84, source-linked into the `docker/docs` GitHub mirror, and a sanity check on `HEALTHCHECK` returned high-quality, attributed snippets from both the Dockerfile reference and the Compose services reference in one query. Faster than browsing docs.docker.com (which has been observed to rate-limit), and Compose + Dockerfile coverage in one library ID is convenient.
- **Compose v5 mention.** The Compose v2 releases page shows a v5.x line in development (with major changes — SDK capabilities, Bake-based builds). Currently calibrated to v2 because it's stable; flag for re-survey when v5 ships stable. Not embedded as agent content yet.
