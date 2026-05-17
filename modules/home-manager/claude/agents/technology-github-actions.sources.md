# GitHub Actions Technology Expert — Sources

References that informed `technology-github-actions.md`. Prioritizes Context7 (`/websites/github_en_actions` — indexes `docs.github.com/en/actions` at high snippet density) and the post-2025-reorg `docs.github.com` reference tree, with first-party action repos (`actions/checkout`, `actions/cache`, `actions/upload-artifact`, etc.) as the canonical authority for action major versions and runtime constraints. Also relies on the `gh` CLI for live run/workflow inspection — strictly faster than WebFetch for actual-run questions.

## Version Calibration

- **Service**: GitHub Actions is hosted; no semantic version. Calibrated to the **2026-05-17** state of `docs.github.com/en/actions`.
- **First-party action majors confirmed at authoring time**:
  - `actions/checkout@v6` (latest `v6.0.2`, Jan 2026)
  - `actions/cache@v5` (latest `v5.0.5`, Apr 2024; Node 24 runtime; runner ≥ `2.327.1`)
  - `actions/upload-artifact@v7` (latest `v7.0.1`, Apr 2026; v4 was the immutability cutover; v5+ continues immutability; v7 = Node 24 runtime)
  - `actions/download-artifact@v8` (latest `v8.0.1`, Mar 2025)
  - `actions/setup-node@v6` (latest `v6.4.0`, Apr 2026; Node 24 runtime)
  - `actions/setup-python@v6` (latest `v6.2.0`, Jan 2025; Node 24 runtime)
  - `actions/setup-go@v6` (Node 24 runtime)
  - `actions/github-script@v9` (latest `v9.0.0`, Apr 2026; ESM-only `@actions/github` — `require('@actions/github')` no longer works inside `script:` block)
- **JavaScript action runtime**: `node20` is the documented current runtime per the JavaScript action authoring guide. (Workflow `runs.using:` for JS actions remains `node20`; first-party actions themselves have moved their internals to Node 24 since v5/v6/v7 majors, but that's about the action's bundled runtime, not the `runs.using:` declaration.)
- **Runner images**: hosted-runner labels and specs verified against `docs.github.com/en/actions/reference/runners/github-hosted-runners`. Notable additions present at calibration: `ubuntu-slim` (1 CPU / 5 GB), `windows-2025`, `windows-11-arm`, `macos-15-intel` / `macos-26-intel`, `macos-26`.
- **Docs reorganization**: confirmed during authoring that the major reorg moved content from `/learn-github-actions/`, `/using-workflows/`, `/using-jobs/`, `/using-github-hosted-runners/`, `/deployment/`, `/creating-actions/`, `/security-guides/` into `/reference/{workflows-and-actions,security,runners,metadata-syntax-reference}/`, `/how-tos/{write-workflows,secure-your-work,manage-runs,monitor-workflows,host-runners,deploy,manage-runners}/`, `/concepts/security/`, and `/sharing-automations/`. Many old URLs **redirect**, but several 404 outright when the path no longer maps cleanly — verified individually.
- **Date confirmed**: 2026-05-17.

## Existing Agents and Skills Consulted

- **`agent-technology` SKILL.md** — followed all nine steps. The skill was amended just before authoring; specifically used:
  - Step 1's ternary classification — chose the **partial variant** (see Design Notes).
  - Step 2's "live-system lookups" rule — promoted `gh run view`, `gh workflow view`, `gh run rerun` to the top of the table for run/workflow questions, since `gh` is strictly faster than `docs.github.com` for actual-run state.
  - Step 2's "spec vs implementation" rule — surfaced where applicable: the `action.yml` schema (one canonical reference) vs the toolkit packages (separate canonical source at `actions/toolkit`). Less load-bearing here than for Docker (Compose Spec vs Docker Compose) because Actions has a single implementation.
  - Step 2's "client-rendered docs" guidance — verified that `docs.github.com` is server-rendered (substantive HTML returned by WebFetch) and does NOT require Context7 as mandatory; Context7 is preferred for speed but the URL fetches work fine.
  - Step 6's partial-variant structural option — Documentation Sources table is sub-sectioned (primary lookup channel / workflow syntax / permissions+OIDC / reusable+actions / runners / first-party actions / changelog+source); Core Concepts is mostly flat with concept-area `###` headings (execution model, expressions, permissions, OIDC, action types, reusable-vs-composite, caching scope, artifacts, workflow commands, pull_request vs pull_request_target, command injection, SHA pinning, concurrency, matrix, environments, runner labels); Approach is **flat** — task strategies generalize across sub-domains because most real tasks cross them.
- **Repo-local style references** (`technology-docker.md`/`.sources.md`, `technology-payloadcms.md`/`.sources.md`, `technology-nix.md`/`.sources.md`) — adopted for tone, section ordering (Scope → Sources → Core Concepts → Approach → Output Format), persona frame (deep expertise + fetch-first), Context7-as-top-row convention, and the partial-variant treatment of Documentation Sources sub-grouping (modeled on Docker's Engine/Compose/Standards split and Payload's per-section URL list). Content authored independently from primary sources.
- **VoltAgent `awesome-claude-code-subagents`** (https://github.com/VoltAgent/awesome-claude-code-subagents) — checked for prior GitHub Actions subagent art as a scope sanity check only. The collection includes generic `devops-engineer`, `cicd-pipeline` and similar agents, but none specifically scoped to GitHub Actions as a technology surface. No content adopted; the checklist/protocol archetype most of those use conflicts with this skill's "fetch-first expert answerer" voice. Confirmed scope decision: keep GitHub Actions as its own expert with the DevOps agent owning macro pipeline design, Security owning threat modeling, and Docker/K8s/Helm/Terraform owning their respective deploy-target territory.

## Primary Sources

### Context7 (primary lookup channel)

Resolved via `mcp__context7__resolve-library-id` against "GitHub Actions" and "Actions Toolkit":

- **`/websites/github_en_actions`** — Source Reputation **High**, benchmark **85.81**, **3,278** snippets. Indexes `docs.github.com/en/actions` — the primary docs site. **Top-row choice.** Verified with a `query-docs` call against `workflow_dispatch inputs and concurrency cancel-in-progress`; returned high-quality, source-attributed snippets covering both topics including the typed-input pattern (`type: choice|boolean|string|environment`) and the `concurrency: { group, cancel-in-progress }` shape.
- **`/github/docs`** — High reputation, benchmark **75.68**, 9,599 snippets. Broader GitHub docs corpus (everything on docs.github.com, not just Actions). Useful when an Actions question pulls in GitHub-platform context (repository settings, API, app installations); for Actions-only questions, `/websites/github_en_actions` is denser.
- **`/actions/toolkit`** — High reputation, benchmark **78.19**, 626 snippets. The first-party `@actions/core`, `@actions/github`, `@actions/exec`, `@actions/io`, `@actions/cache`, `@actions/tool-cache`, `@actions/glob`, `@actions/http-client`, `@actions/artifact` packages. **Use when authoring JavaScript actions.**
- **`/actions/runner-images`** — High reputation, benchmark **56.65**, 146 snippets. Pre-installed software per OS image. Useful when answering "is X available on the runner."
- **`/actions/runner`** — High reputation, benchmark **69.83**, 399 snippets. Self-hosted runner source and release tracking.
- **`/actions/actions-runner-controller`** — High reputation, benchmark **71.29**, 603 snippets. ARC (Kubernetes operator for autoscaling self-hosted runners).
- **`/actions/checkout`** — High reputation, benchmark **75.36**, 81 snippets, versioned at `v5` (which is what Context7 currently indexes; latest GitHub release is `v6.0.2` — Context7 lags one major). Use for checkout-specific deep-dive; verify version against the GitHub release page when pinning.

### Official Documentation (verified at authoring time)

All URLs in the agent's Documentation Sources table were fetched at authoring (2026-05-17). Results:

**Workflow syntax / events / contexts / expressions / variables / workflow commands**

- `https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax` — confirmed canonical post-reorg. Server-rendered. Documents all top-level keys (`name`, `run-name`, `on`, `permissions`, `env`, `defaults`, `concurrency`, `jobs`) plus job/step keys.
- `https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows` — confirmed canonical. Catalogs all triggers (push, pull_request, workflow_dispatch, schedule, etc.) with activity types and payload references.
- `https://docs.github.com/en/actions/reference/workflows-and-actions/expressions` — confirmed canonical. Covers literals, operators, functions, status checks, object filters.
- `https://docs.github.com/en/actions/reference/workflows-and-actions/contexts` — confirmed canonical. Documents 11 contexts (`github`, `env`, `vars`, `job`, `jobs`, `steps`, `runner`, `secrets`, `strategy`, `matrix`, `needs`, `inputs`) with availability rules.
- `https://docs.github.com/en/actions/reference/workflows-and-actions/variables` — confirmed canonical. Default env vars (`GITHUB_*`, `RUNNER_*`), `vars.*`, naming conventions, limits, precedence.
- `https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-commands` — confirmed canonical. Documents `GITHUB_OUTPUT`, `GITHUB_ENV`, `GITHUB_PATH`, `GITHUB_STATE`, `GITHUB_STEP_SUMMARY`, plus `::add-mask::`, `::group::`, `::error::`, `::warning::`, `::notice::`, `::debug::`.
- `https://docs.github.com/en/actions/how-tos/write-workflows/choose-when-workflows-run/manually-run-a-workflow` — confirmed canonical via Context7 cross-reference.
- `https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/run-job-variations` — confirmed canonical for matrix strategy how-to. The `using-jobs/using-a-matrix-for-your-jobs` URL is the pre-reorg path; the content moved here.

**Permissions / GITHUB_TOKEN / secrets / OIDC / environments**

- `https://docs.github.com/en/actions/security-for-github-actions/security-guides/automatic-token-authentication` — confirmed canonical. Covers GITHUB_TOKEN, the `permissions:` block, scopes.
- `https://docs.github.com/en/actions/security-for-github-actions/security-guides/using-secrets-in-github-actions` — confirmed canonical. The pre-reorg `security-guides/using-secrets-in-github-actions` URL works.
- `https://docs.github.com/en/actions/reference/security/secure-use` — confirmed canonical. The amalgamated security hardening reference (SHA pinning, command injection, fork-PR risk, GITHUB_TOKEN least-privilege, OIDC mention, third-party action review, self-hosted runner hardening).
- `https://docs.github.com/en/actions/concepts/security/openid-connect` — confirmed canonical for OIDC concepts. The pre-reorg `deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect` URL **was not the canonical for this content post-reorg**.
- `https://docs.github.com/en/actions/how-tos/secure-your-work/security-harden-deployments/oidc-in-aws` — confirmed canonical. Documents IAM trust-policy `sub` claim patterns (`repo:owner/repo:ref:refs/heads/branch`, `repo:owner/repo:environment:prod`, `repo:owner/repo:*`). Sister pages `/oidc-in-azure` and `/oidc-in-gcp` follow the same path structure.
- `https://docs.github.com/en/actions/how-tos/deploy/configure-and-manage-deployments/manage-environments` — confirmed canonical. Covers required reviewers, wait timers, branch protection, environment secrets, environment variables, custom deployment protection rules.

**Reusable workflows / custom actions / metadata**

- `https://docs.github.com/en/actions/sharing-automations/reusing-workflows` — confirmed canonical. Documents `workflow_call`, `inputs`, `secrets`, `secrets: inherit`, `outputs`.
- `https://docs.github.com/en/actions/sharing-automations/creating-actions/about-custom-actions` — confirmed canonical. Documents the three action types (composite / JavaScript / Docker container).
- `https://docs.github.com/en/actions/reference/metadata-syntax-reference` — confirmed canonical for the `action.yml` schema. Documents `name`, `description`, `author`, `inputs`, `outputs`, `runs`, `branding`.
- `https://docs.github.com/en/actions/sharing-automations/creating-actions/creating-a-composite-action` — confirmed canonical.
- `https://docs.github.com/en/actions/sharing-automations/creating-actions/creating-a-javascript-action` — confirmed canonical. Verified that current documented runtime is `runs.using: 'node20'`.
- `https://docs.github.com/en/actions/sharing-automations/creating-actions/creating-a-docker-container-action` — confirmed canonical.

**Runners**

- `https://docs.github.com/en/actions/reference/runners/github-hosted-runners` — confirmed canonical. Lists all current labels and specs (see calibration above).
- `https://docs.github.com/en/actions/how-tos/manage-runners/self-hosted-runners/add-runners` — confirmed canonical. Covers repo / org / enterprise scopes for self-hosted runner registration.

**Monitoring / debugging**

- `https://docs.github.com/en/actions/how-tos/monitor-workflows/enable-debug-logging` — confirmed canonical. Documents `ACTIONS_RUNNER_DEBUG` and `ACTIONS_STEP_DEBUG` repo secrets/variables.

**First-party action releases**

All `/releases` pages on github.com confirmed accessible and were used to source current major versions (see calibration above).

**Changelog & source**

- `https://github.blog/changelog/label/actions/` — confirmed. The canonical "what changed in Actions recently" feed. Most-recent entries at calibration: "Upcoming image migrations" (2026-05-14), "Concurrency groups now allow larger queues" (2026-05-07), "Copilot cloud agent starts 20% faster with Actions custom images" (2026-04-27).
- `https://github.com/actions/toolkit`, `https://github.com/actions/runner`, `https://github.com/actions/runner-images`, `https://github.com/actions/actions-runner-controller` — all confirmed.
- `https://github.com/marketplace?type=actions` — confirmed.

### URLs noted as redirected, 404'd, or thin

- `https://docs.github.com/en/actions/learn-github-actions/expressions` — **redirects** (or aliases) to the new `/reference/workflows-and-actions/expressions`. Both currently return the same content; agent table uses the new canonical path.
- `https://docs.github.com/en/actions/learn-github-actions/contexts` — same. New path: `/reference/workflows-and-actions/contexts`.
- `https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows` — same. New path: `/reference/workflows-and-actions/events-that-trigger-workflows`.
- `https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions` — same. New path: `/reference/workflows-and-actions/workflow-syntax`.
- `https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions` — content moved to `/reference/security/secure-use` (consolidated security-hardening reference). The old URL returns related content but isn't the canonical post-reorg location.
- `https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect` — content split: concepts moved to `/concepts/security/openid-connect`; per-cloud how-tos moved to `/how-tos/secure-your-work/security-harden-deployments/oidc-in-{aws,azure,gcp}`.
- `https://docs.github.com/en/actions/creating-actions/metadata-syntax-for-github-actions` — works, but the **canonical** post-reorg URL is `/reference/metadata-syntax-reference`. Agent table uses the reference path.
- `https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners` — works as an entry page; the **reference** content (with the full label/spec table) lives at `/reference/runners/github-hosted-runners`.
- `https://docs.github.com/en/actions/concepts/workflows-and-actions/events-that-trigger-workflows` — **404**. Events content is under `/reference/`, not `/concepts/`.
- `https://docs.github.com/en/actions/reference/security/openid-connect` — **404**. OIDC content lives under `/concepts/security/openid-connect` (concepts) and `/how-tos/secure-your-work/security-harden-deployments/oidc-in-*` (how-tos), not under `/reference/security/`.
- `https://docs.github.com/en/actions/how-tos/write-workflows/choose-when-workflows-run/use-conditions` — **404**. Did not find a direct successor; content about `if:` conditions is dispersed across the workflow-syntax reference and the expressions reference.
- `https://docs.github.com/en/actions/how-tos/write-workflows/choose-when-workflows-run/control-jobs`, `https://docs.github.com/en/actions/how-tos/write-workflows/use-matrices`, `https://docs.github.com/en/actions/how-tos/manage-runs/runs/enable-debug-logging`, `https://docs.github.com/en/actions/how-tos/host-runners/self-hosted-runners/manage` — all **404**. Correct successors found and substituted: `…/choose-what-workflows-do/run-job-variations` (matrices), `…/monitor-workflows/enable-debug-logging` (debug logs), `…/manage-runners/self-hosted-runners/add-runners` (self-hosted).
- `https://docs.github.com/en/actions/using-workflows/reusing-workflows` — works but post-reorg canonical is `/sharing-automations/reusing-workflows`. Agent table uses the new path.

**No HTTP 5xx encountered.** All Context7 IDs probed returned results. The docs site is server-rendered (substantive HTML body to WebFetch) — Context7 is preferred for speed but not strictly required.

## Volatile vs. Stable Classification

**Embedded (stable — unlikely to change without a major reorg)**:

- The execution model (events → workflows → jobs → steps; one runner per job; serial steps within a job).
- The expression language operators and the function catalog.
- The 12-context list and the broad availability rules (e.g., `secrets` not available to fork PRs).
- The `GITHUB_TOKEN` lifecycle (auto-minted per run, scoped by `permissions:`, auto-revoked at job end).
- The `permissions:` scope catalog at the category level (contents / issues / pull-requests / actions / packages / id-token / pages / deployments / checks / statuses / security-events / attestations / discussions / models).
- The OIDC trust model (JWT structure, JWKS endpoint, default `sub` formats, audience configurability).
- The three action types and the decision rule between them.
- The reusable-workflow-vs-composite-action decision boundary.
- The `pull_request` vs `pull_request_target` trust model (this is the security model and won't change).
- The command-injection-via-`${{ }}` pattern and the env-var workaround.
- The cache scoping rules (per-repo, per-branch with main fallback for read, partial restore semantics).
- The artifact immutability rule (v4+ — cannot upload twice to the same name).
- The workflow-commands file contract (`GITHUB_OUTPUT`, `GITHUB_ENV`, etc.) since `set-output`/`save-state` deprecation.

**Always fetch (volatile — version-sensitive or actively evolving)**:

- The exact list of supported events and their activity types (events get added — e.g. `merge_group` was a 2023 add).
- Specific `github.event.*` payload fields per event.
- The `permissions:` scope additions (`attestations` was a recent add; `models` is recent for AI workflows).
- First-party action major versions and their runtime/runner constraints — moves frequently.
- Runner image labels (`*-arm` rollouts, larger-runner availability, image deprecations — weekly drift).
- Pre-installed software on each runner image — read `actions/runner-images/images/<os>-<ver>/Readme.md` for the authoritative current state.
- The runner agent minimum version requirements (drifts with action majors).
- Reusable-workflow nesting depth limit (was 4 levels at one point; verify current).
- Cache backend specifics — `actions/cache@v5` runtime constraints, eviction behavior tweaks.
- `act` (the local-runner emulator) compatibility — diverges from real runner behavior often.

## Design Notes

- **Partial variant chosen per the amended Step 1.** GitHub Actions has clearly distinct authoritative sources (workflow syntax / events / contexts / expressions / permissions / OIDC / reusable workflows / custom actions / runners / first-party actions), and the Documentation Sources table is sub-sectioned to preserve scannability. But real-world tasks routinely cross these — debugging a failed deploy can touch workflow syntax (an `if:` evaluating false), the action being called (a pinned major moved), OIDC (the trust policy doesn't match the new `sub`), and runner labels (image rolled forward). A flat Approach section reads more naturally than per-sub-domain branches because the strategies generalize: "name the layer, fetch the reference, propose the fix" works across all of them.
- **Live `gh` CLI as the top-of-table promotion.** Per the amended Step 2 (live-system lookups). For any question about an *actual run* (failed job, missing log, why was this skipped), `gh run view <id> --log-failed` or `gh run view --log` is strictly faster and version-correct compared to fetching docs. Promoted to the primary lookup channel section.
- **First-party action versions table as a separate sub-section.** This information moves more than anything else in the agent — `actions/upload-artifact` jumped 3 → 4 → 7 in a couple of years with immutability as the breaking change, `actions/github-script` v9 broke `require('@actions/github')`. Pinning these in their own sub-table in Documentation Sources (plus the Approach guidance to verify on the release page) is the highest-leverage practical guidance the agent can give beyond raw lookups.
- **`pull_request` vs `pull_request_target` as a first-class core concept.** This produces real incidents. It's not in the Approach section alone — it's an embedded `###` core concept with the canonical vulnerability pattern called out. Same for command injection via `${{ github.event.* }}` in `run:` — embedded as a core concept, not deferred to Security. The Security agent owns deep threat modeling; the *mechanics* of these patterns are GitHub-Actions-specific and belong here.
- **OIDC structure embedded, cloud-policy specifics fetched.** The JWT claim shape, default `sub` formats, and the workflow-side `permissions: { id-token: write }` + cloud action pattern are stable enough to embed. The cloud-side trust policy *syntax* (IAM trust policy JSON, Azure federated credential YAML, GCP WIF attribute mapping) drifts and is per-cloud — fetched.
- **Docs reorg discipline.** The 2025 docs reorganization broke a lot of bookmark/training-data URLs. The agent's table uses post-reorg canonical paths, and the sources file enumerates the redirects/404s found during authoring so future re-survey can confirm they're still valid. This is high-leverage because the temptation is to assume the path the model "knows" still works — many do not.
- **Reusable-workflow-vs-composite-action decision table.** This is the perennial confusion. Embedding it as a side-by-side table (when each is the right tool) is more useful than prose, mirrors the ENTRYPOINT/CMD table in the Docker agent, and produces a clean fast answer for the common form of the question.
- **`node20` for JS action `runs.using:` vs `Node 24` in first-party action internals.** Important not to conflate. The `runs.using: 'node20'` declaration in `action.yml` is the *runner side* — that's the JS runtime the runner provides for executing the action. First-party actions like `actions/checkout@v6` internally bundled to Node 24 in their builds — that's about the action's own code, not the runtime declaration. The agent calls this out so users don't think they need to write `runs.using: 'node24'` (which isn't supported yet).
- **`ubuntu-latest` is a moving alias; recommend pinning.** Worth surfacing because many existing workflows use `*-latest` and silently inherit image churn. Embedded recommendation: pin to `ubuntu-24.04` (etc.) for reproducibility.
- **`act` mentioned but not endorsed strongly.** Local-runner emulation via `nektos/act` is useful for simple workflow iteration but diverges from the real runner in non-trivial ways (OIDC, environment-specific tools, matrix nuances). Mentioned in the debugging Approach paragraph with the caveat — enough that the agent knows the tool exists, not enough that it recommends it as the default debug path.
- **Defer boundaries are tighter than for some technologies.** Actions sits next to DevOps (CI/CD architecture), Security (threat modeling), Docker (Dockerfile internals), Kubernetes/Helm/Terraform (deploy targets). The Scope section names the boundaries explicitly: macro CI/CD design defers to DevOps; threat modeling defers to Security; Dockerfile authoring inside a Docker action defers to Docker; what `kubectl apply` should apply defers to Kubernetes. The agent does volunteer Actions-side info (the `permissions:` minimum, the action invocation, the OIDC `permissions:` block) when deferring, so the user has the bridge.
