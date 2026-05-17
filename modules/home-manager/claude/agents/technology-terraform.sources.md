# Terraform Technology Expert — Sources

References that informed `technology-terraform.md`. Prioritizes Context7 (versioned indexes of `developer.hashicorp.com/terraform` and `opentofu.org/docs`) and the official HashiCorp / OpenTofu docs over community material.

## Version Calibration

- **Terraform version pinned**: **v1.15.x** (latest stable: **v1.15.3**, released 2026-05-13; alpha line: 1.16.0-alpha20260513).
- **OpenTofu version pinned**: **v1.12.0** (released 2026-05-14), with the 1.11.x line (latest 1.11.8) still in active maintenance.
- **Date confirmed**: 2026-05-17.
- **Major-version line**: Terraform v1.x (compatibility promises in force across v1.x). OpenTofu v1.x, governed by the Linux Foundation under MPL-2.0, forked after HashiCorp's BUSL license change for Terraform.
- **Feature GA confirmation as of authoring**:
  - **Import block** — Terraform 1.5+ (declarative `import { to, id }`).
  - **`import` with `for_each`** — Terraform 1.7+.
  - **`check` blocks** — Terraform 1.5+ (verified at https://developer.hashicorp.com/terraform/language/checks).
  - **`removed` block** — Terraform 1.7+ (verified at https://developer.hashicorp.com/terraform/language/block/removed).
  - **`moved` block** — Terraform 1.1+.
  - **Ephemeral resources / variables / outputs / write-only arguments** — Terraform 1.10+ (verified at https://developer.hashicorp.com/terraform/language/resources/ephemeral).
  - **Provider-defined functions** — Terraform 1.8+.
  - **S3 backend native locking (`use_lockfile`)** — Terraform 1.10+.
  - **OpenTofu state encryption** — OpenTofu 1.7+.
  - **OpenTofu early variable evaluation** — OpenTofu 1.8+.
  - **OpenTofu provider `for_each`** — OpenTofu 1.9+ (verified at https://opentofu.org/docs/language/providers/configuration/).
  - **OpenTofu `enabled` lifecycle meta-argument** — OpenTofu 1.11+ (verified at https://opentofu.org/docs/intro/whats-new/).
  - **OpenTofu `-exclude` / `-exclude-file`** — current 1.x (verified at https://opentofu.org/docs/cli/commands/plan/).

## Existing Agents and Skills Consulted

- **VoltAgent `awesome-claude-code-subagents`** (https://github.com/VoltAgent/awesome-claude-code-subagents) — scope sanity check only. The index contains general DevOps / IaC subagents but not a focused Terraform expert agent at the level this skill produces (most are protocol/checklist-archetype workflows for "plan reviews"). Nothing inherited.
- **Repo-local style references**:
  - `technology-payloadcms.md` and `technology-payloadcms.sources.md` — primary tonal/structural reference (most recent and refined; ~32KB). Adopted: persona frame (deep expertise + fetch-first), section ordering (Scope → Sources → Core Concepts → Approach → Output Format), Context7-as-top-row pattern, divergent-variant treatment (here applied to OpenTofu rather than v2/v3).
  - `technology-nix.md` and `technology-nix.sources.md` — secondary reference for the leaner end of the agent surface. Adopted: layered ecosystem table pattern (here: language / CLI / registry sub-tables), embedded Core Concepts depth calibration.
- **HashiCorp's own Terraform CLAUDE.md / repo guidance** (in the public `hashicorp/terraform` repository) — referenced for version-promise framing. Not directly content-inherited.

## Primary Sources

### Context7 (primary lookup channel)

- **`/websites/developer_hashicorp_terraform`** — High source reputation, benchmark 79.25, **24,626 code snippets**. Indexes the full `developer.hashicorp.com/terraform` documentation. The agent's preferred runtime lookup path: `mcp__context7__query-docs` with this libraryId.
- **`/hashicorp/terraform`** — High reputation, 110 snippets, **versioned** (`v1.14.5`, `v1.14.3`, `v1.12.2`, `v1.8.0`). Lower snippet count but exposes per-version indexing — preferred when the user is pinned to a specific Terraform version that differs from latest.
- **`/websites/opentofu`** — High reputation, benchmark 71.65, 3,003 snippets. Mirrors `opentofu.org/docs` for OpenTofu coverage.
- **`/opentofu/opentofu`** — High reputation, benchmark 83.31, 1,258 snippets. Source-tree index for OpenTofu when docs are insufficient.
- **`/websites/developer_hashicorp_terraform_cloud-docs`** — High reputation, 5,822 snippets, for HCP Terraform / Terraform Cloud.

Alternative IDs noted but not preferred: `/websites/opentofu_1_11_x` (low benchmark, sparse coverage); `/upbound/provider-opentofu` (Crossplane-specific, not relevant to core).

### Official Documentation (Terraform — verified at v1.15.x)

Verified accessible at authoring time (2026-05-17):

- [Terraform Docs Home](https://developer.hashicorp.com/terraform/docs) — confirmed; four top categories (Introduction / Manage Infrastructure / Collaborate / Develop and Share).
- [Language Reference](https://developer.hashicorp.com/terraform/language) — confirmed v1.15.x.
- [Expressions](https://developer.hashicorp.com/terraform/language/expressions) — confirmed; covers types/values, strings/templates, references, operators, function calls, conditional, for, splat, dynamic blocks, type constraints, version constraints.
- [Meta-Arguments](https://developer.hashicorp.com/terraform/language/meta-arguments) — confirmed; documents `depends_on`, `count`, `for_each`, `lifecycle`, `provider`, `providers`.
- [Functions](https://developer.hashicorp.com/terraform/language/functions) — confirmed; nine categories (numeric/string/collection/encoding/filesystem/date-time/hash-crypto/IP-network/type-conversion) plus provider-defined functions notice.
- [Variables](https://developer.hashicorp.com/terraform/language/values/variables) — confirmed; validation blocks, sensitive, ephemeral, precedence order documented.
- [Outputs](https://developer.hashicorp.com/terraform/language/values/outputs) — referenced.
- [Resources](https://developer.hashicorp.com/terraform/language/resources) — referenced.
- [Ephemeral Resources & Write-Only Arguments](https://developer.hashicorp.com/terraform/language/resources/ephemeral) — confirmed; documents `ephemeral` block and `*_wo` / `*_wo_version` arguments with AWS RDS example.
- [Checks](https://developer.hashicorp.com/terraform/language/checks) — confirmed; documents check blocks, requires Terraform v1.5.0+, warnings-not-errors semantics.
- [Modules Overview](https://developer.hashicorp.com/terraform/language/modules) — confirmed; introduction / hierarchy / sources / workflows subsections.
- [State Overview](https://developer.hashicorp.com/terraform/language/state) — confirmed; storing state, inspection/modification, JSON format.
- [Backends](https://developer.hashicorp.com/terraform/language/backend) — confirmed; 12 built-in backend types enumerated (local, remote, azurerm, consul, cos, gcs, http, kubernetes, oci, oss, pg, s3).
- [Import (overview)](https://developer.hashicorp.com/terraform/language/import) — confirmed.
- [Import block reference](https://developer.hashicorp.com/terraform/language/block/import) — confirmed; documents `to`, `id`, `identity`, `for_each`, `provider` arguments.
- [Moved block](https://developer.hashicorp.com/terraform/language/block/moved) — confirmed; documents `from`/`to` semantics.
- [Removed block](https://developer.hashicorp.com/terraform/language/block/removed) — confirmed; documents `from`, `lifecycle { destroy = false }`, provisioner support.
- [v1 Compatibility Promises](https://developer.hashicorp.com/terraform/language/v1-compatibility-promises) — confirmed. **Note**: the URL `v1.x-compatibility-promises` (with `.x`) returns 404; the correct path is `v1-compatibility-promises`. Agent file uses the working URL.
- [CLI Reference](https://developer.hashicorp.com/terraform/cli) — confirmed; 16 main command categories enumerated.

### Official Documentation (OpenTofu — verified at v1.12.x / 1.11.x)

- [OpenTofu Docs](https://opentofu.org/docs/) — confirmed; four primary areas (Getting started / Language / CLI / Internals).
- [What's New (1.11)](https://opentofu.org/docs/intro/whats-new/) — confirmed; documents ephemeral values and the `enabled` lifecycle meta-argument.
- [State and Plan Encryption](https://opentofu.org/docs/language/state/encryption/) — confirmed; documents key providers (PBKDF2, AWS KMS, GCP KMS, Azure Vault, OpenBao, external) and encryption methods (AES-GCM, external, unencrypted).
- [Provider Configuration (incl. for_each)](https://opentofu.org/docs/language/providers/configuration/) — confirmed; OpenTofu allows `for_each` on aliased provider configurations, addressed as `<provider>.<alias>["<key>"]`.
- [Variables](https://opentofu.org/docs/language/values/variables/) — confirmed; documents declaration, type system, defaults, validation, sensitive, ephemeral, nullable, deprecation, assignment methods.
- [Plan command (incl. -exclude)](https://opentofu.org/docs/cli/commands/plan/) — confirmed; `-exclude=ADDRESS` and `-exclude-file=FILENAME` documented as mutually exclusive with `-target`.

URLs that returned **404 during URL verification** (and were excluded from the agent):

- `https://developer.hashicorp.com/terraform/language/v1.x-compatibility-promises` — corrected to `/v1-compatibility-promises` (the dotted-`x` form is wrong).
- `https://developer.hashicorp.com/terraform/language/check` — corrected to `/checks` (plural).
- `https://opentofu.org/docs/main/language/providers/iteration/` — correct path is `/language/providers/configuration/` (provider iteration is documented within the configuration page, not a separate iteration page).
- `https://opentofu.org/docs/language/expressions/early-evaluation/` — no dedicated page exists at this path; early evaluation is currently covered in the variables/locals reference and the 1.8 release notes rather than a stable doc URL. Agent points to https://opentofu.org/docs/intro/whats-new/ as the entry point.

### Registry and Source Channels

- [Terraform Registry](https://registry.terraform.io/) — provider and module discovery. Provider resource documentation lives at `/providers/<namespace>/<provider>/<version>/docs/resources/<name>`; agent instructs to always fetch from the registry for provider arguments (volatile across versions).
- [Terraform GitHub releases](https://github.com/hashicorp/terraform/releases) — verified; current latest stable 1.15.3 (2026-05-13).
- [Terraform GitHub source](https://github.com/hashicorp/terraform).
- [HCL spec](https://github.com/hashicorp/hcl/blob/main/hclsyntax/spec.md) — for deep parser/syntax questions.
- [OpenTofu GitHub releases](https://github.com/opentofu/opentofu/releases) — verified; current latest stable 1.12.0 (2026-05-14).
- [OpenTofu GitHub source](https://github.com/opentofu/opentofu).

## Volatile vs. Stable Classification

**Embedded (stable across v1.x — unlikely to change without a major)**:

- HCL2 language fundamentals (block/argument/expression model, type system primitives, for/splat/conditional syntax, dynamic blocks).
- Resource graph and plan/apply lifecycle (refresh → plan → apply, dependency derivation from references vs explicit `depends_on`).
- `count` vs `for_each` semantics including the "keys-known-at-plan-time" constraint and its implications.
- `lifecycle` meta-argument behaviors (`create_before_destroy`, `prevent_destroy`, `ignore_changes`, `replace_triggered_by`, pre/postcondition).
- Provider configuration model (defaults, aliases, `configuration_aliases`, module passing, the "no provider block in a module" anti-pattern).
- Module source schemes (local / registry / git / s3 / generic https).
- State concept (mapping, locking, remote backends as a requirement at team scale, workspace caveats).
- Plan output symbol vocabulary (`+`/`-`/`~`/`-/+`/`+/-`/`<=`).
- `-target` vs `-replace` vs refresh-only role distinctions.
- Refactoring blocks at the conceptual level (`moved`/`removed`/`import` and why they replace imperative state surgery).
- `terraform_data` as the `null_resource` replacement.
- HCP Terraform usage shape (cloud block, workspaces, VCS).
- OpenTofu fork relationship and the high-level set of divergent features.
- Built-in function categories (which kinds of functions exist).
- v1.x compatibility-promise scope.

**Always fetch (volatile — version-sensitive)**:

- Specific built-in function signatures and argument shapes (`templatefile`, `cidrsubnet`, `try`, etc. — exact parameter order matters).
- Provider-defined function namespaces (`provider::<name>::<fn>`) — discoverable only at provider docs.
- **All** provider resource arguments — provider releases ship new arguments / deprecate old ones continuously.
- Backend config keys (especially `s3` backend — `use_lockfile`, `dynamodb_table`, `assume_role`, region/profile resolution).
- `lifecycle` sub-argument additions (HashiCorp has shipped new arguments in minor releases — `replace_triggered_by` came in 1.2, `precondition`/`postcondition` in 1.2).
- Ephemeral / write-only argument support (1.10+; specific provider adoption varies).
- `import` block features (`for_each` 1.7+; `identity` attribute; `generate_config_out` CLI flag).
- CLI flag changes between minor versions (e.g. `-replace` semantics, new flags like `-or-create` on `workspace select` in 1.4+).
- OpenTofu's divergent feature surface — currently moving fast, with new features in nearly every minor release. Always pin OpenTofu answers to a specific version.
- HCP Terraform configuration block keys and Sentinel/OPA integration shape.

## Design Notes

- **OpenTofu treatment as fork-peer, not separate agent.** Most Terraform questions are 1:1 applicable to OpenTofu, and most users don't draw a strong line between them. Splitting into two agents would create constant routing friction. Instead, the agent default-answers Terraform, treats OpenTofu as a peer fork, and has a dedicated divergent-features subsection in Core Concepts plus a column in the table. The Approach section explicitly tells the agent to confirm which CLI the user is on for any question that touches the divergent surface.
- **Sub-sectioned Core Concepts, but kept flat for everything else.** Terraform is moderately broad but coherent — the language, the lifecycle, providers, modules, state, and refactoring all interlock. Splitting the Documentation Sources table into language/CLI + registry/releases + OpenTofu was useful because the three groups have different fetch patterns. Core Concepts uses inline `###` headings without a sub-domain wrapper because the concepts read better as a flowing reference than as artificially-segmented sub-ecosystems.
- **Registry-first for provider questions.** The single most common "Terraform" question that isn't really a Terraform question is "what's the right argument for `aws_X` / `azurerm_Y` / `google_Z`?" The agent explicitly defers provider deep-dive expertise but commits to *fetching from the registry* for any specific argument lookup. This is the right boundary — don't try to memorize 5,000+ AWS provider resources, but always look them up authoritatively.
- **`for_each` over `count` evangelism.** Embedded explicitly in Core Concepts. The shifting-index pain of `count` is one of the most common foot-guns for new Terraform users, and the fix is one-liner-simple. Agent should actively steer toward `for_each` unless the user has a specific reason.
- **`moved`/`removed`/`import` blocks as the modern refactoring story.** Imperative `terraform state mv` / `rm` / `import` still work but produce no diff, no review, no rollback path. The declarative blocks are the modern way and the agent embeds them as first-class — the CLI versions are cited only as a fallback.
- **Plan-time vs apply-time data sources.** This is a subtle source of confusion (especially around `depends_on` on data sources causing cascading `(known after apply)`). Embedded because it's not obvious from the docs and trips users repeatedly.
- **Anti-pattern callouts inline.** Two explicit ones: `provider` block in a child module, and `lifecycle.ignore_changes` with `for_each`. Both are common, hard-to-debug mistakes; calling them out in Core Concepts saves the user from needing to ask about the symptoms later.
- **HCP Terraform scoped at usage-level only.** Architecture and policy authoring belong to Architecture/Security peers; the agent owns the cloud block, workspace addressing, and basic VCS wiring. Same pattern as the Payload agent's Next.js deferral — name the boundary explicitly so the agent doesn't drift.
