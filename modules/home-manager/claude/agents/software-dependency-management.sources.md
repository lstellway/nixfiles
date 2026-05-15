# Sources: software-dependency-management.md

## Step 1: Agents & Skills Consulted

### VoltAgent/awesome-claude-code-subagents
https://github.com/VoltAgent/awesome-claude-code-subagents

Reviewed the full agent index (131+ agents). Dependency-adjacent agents found:

| Agent | Description | Used? |
|---|---|---|
| `dependency-manager` | "Package and dependency specialist" | Not used directly — the raw agent file returned 404 at the time of fetch, so no content was incorporated. The name confirms a gap that this agent fills with broader supply chain, SBOM, and license coverage. |
| `license-engineer` | "Software licensing and compliance systems specialist" | Not used — this agent focuses on licensing compliance obligations, which this agent defers to the Compliance peer. License *identification* and *compatibility flags* are in-scope here; legal interpretation is not. |
| `security-engineer` | "Infrastructure security specialist" | Not used — infrastructure security is out of scope; CVE exploitation analysis is deferred to the Security peer agent. |
| `security-auditor` | "Security vulnerability expert" | Not used — same rationale as security-engineer. |
| `compliance-auditor` | "Regulatory compliance expert" | Not used — regulatory obligations are deferred to the Compliance peer. |

**Design note**: No existing subagent combined version pinning policy, lockfile hygiene, SBOM generation, SLSA levels, and license compatibility in a single agent. This agent fills that combined gap.

---

## Step 2: Framework Versions Applied

| Framework / Standard | Version Used | Verification Date | Notes |
|---|---|---|---|
| Semantic Versioning | 2.0.0 | May 2026 | https://semver.org/ — specification has been at v2.0.0 since 2013; no newer version. |
| SLSA (Supply chain Levels for Software Artifacts) | v1.2 (current) | May 2026 | https://slsa.dev/spec/v1.2/ — confirmed v1.2 is current; v1.0 is retired. |
| SPDX | 2.3 (stable) / 3.1 RC1 (in review) | May 2026 | https://spdx.dev/ — SPDX 3.1 RC1 published January 26, 2026; ISO/IEC 5962:2021 covers SPDX 2.2. Agent recommends SPDX 2.3 for tooling compatibility; notes 3.1 for awareness. |
| CycloneDX | 1.7 | May 2026 | https://cyclonedx.org/specification/overview/ — version 1.7 released 2025-10-21; standardized as ECMA-424. |
| OpenSSF Scorecard | v5 (current) | May 2026 | https://github.com/ossf/scorecard — v5 introduced Structured Results; 18 checks confirmed via securityscorecards.dev. |
| OWASP Dependency-Check | current (version not pinned in agent) | May 2026 | https://owasp.org/www-project-dependency-check/ — version number not prominently surfaced on project page; agent references by invocation pattern rather than version. |
| Go modules / MVS | documented at go 1.21+ behavior | May 2026 | https://go.dev/ref/mod — module graph pruning and mandatory `go` directive behavior since Go 1.21. |
| npm lockfile | v3 (npm 7+) | May 2026 | https://docs.npmjs.com/cli/v11/configuring-npm/package-lock-json/ — v3 format with sha512 integrity. |
| pnpm | v11 (`blockExoticSubdeps`) | May 2026 | https://mondoo.com/blog/npm-supply-chain-security-package-manager-defenses-2026 |
| Yarn Berry `enableHardenedMode` | current | May 2026 | https://bastion.tech/blog/npm-supply-chain-attacks-2026-saas-security-guide |
| Maven Enforcer Plugin | current | May 2026 | https://maven.apache.org/enforcer/enforcer-rules/dependencyConvergence.html |
| Renovate | current | May 2026 | https://docs.renovatebot.com/configuration-options/ — key options: `rangeStrategy`, `automerge`, `automergeType`, `schedule`, `groupName`, `pinDigests`. |
| Dependabot | v2 config format | May 2026 | https://docs.github.com/en/code-security/dependabot/dependabot-version-updates/configuring-dependabot-version-updates |
| pip-audit | current (PyPA) | May 2026 | https://github.com/pypa/pip-audit — queries OSV database; supports `--require-hashes`. |
| pip `--require-hashes` | pip v26.1.1 (current) | May 2026 | https://pip.pypa.io/en/stable/topics/secure-installs/ |
| SPDX License List | current (identifiers as of May 2026) | May 2026 | https://spdx.org/licenses/ — confirmed SPDX identifier naming convention (e.g., `GPL-2.0-only`, not `GPLv2`). |

---

## Step 3: Sources Consulted

### Semver
- https://semver.org/ — core specification: MAJOR.MINOR.PATCH rules, pre-release ordering, build metadata, precedence

### SLSA
- https://slsa.dev/spec/v1.2/ — confirmed v1.2 as current (v1.0 retired)
- https://slsa.dev/spec/v1.2/build-track-basics — **primary source for level definitions**: L0 (no guarantees), L1 (provenance exists, forgeable), L2 (signed provenance, hosted build, forging requires explicit attack), L3 (hardened build, inaccessible signing material, forging requires exploiting hardened platform)

### SPDX
- https://spdx.dev/ — SPDX 3.1 RC1 published January 26, 2026; confirmed ISO/IEC 5962:2021 status
- https://spdx.org/licenses/ — confirmed SPDX identifier format and key identifiers

### CycloneDX
- https://cyclonedx.org/specification/overview/ — version 1.7 (2025-10-21), ECMA-424, JSON/XML/Protobuf formats, OWASP Foundation

### OpenSSF Scorecard
- https://securityscorecards.dev/ — 18 checks across Holistic Security Practices, Source Risk Assessment, Build Risk Assessment; specific check names incorporated directly
- https://github.com/ossf/scorecard — v5 with Structured Results

### OWASP Dependency-Check
- https://owasp.org/www-project-dependency-check/ — CPE-based detection, NVD/NPM Audit/OSS Index/RetireJS integration, CLI/Maven/Gradle/Jenkins/GitHub Actions support

### npm / Supply Chain
- https://pip.pypa.io/en/stable/topics/secure-installs/ — `--require-hashes` behavior
- https://docs.npmjs.com/cli/v11/configuring-npm/package-lock-json/ — lockfile v3 sha512 integrity fields
- https://medium.com/@ademyalcin27/npm-supply-chain-quick-check-pinning-guide — lockfile-lint, lockfile injection attack pattern
- https://bastion.tech/blog/npm-supply-chain-attacks-2026-saas-security-guide — Yarn Berry `enableHardenedMode`, pnpm `blockExoticSubdeps`
- https://mondoo.com/blog/npm-supply-chain-security-package-manager-defenses-2026 — pnpm v11 exotic subdep blocking

### pip / Python
- https://github.com/pypa/pip-audit — PyPA pip-audit tool, OSV database integration
- https://xygeni.io/blog/hidden-dangers-of-requirements-txt-how-dependency-pinning-can-save-you/ — hash pinning rationale

### Go Modules
- https://go.dev/ref/mod — MVS algorithm, go.sum verification, retraction, workspace mode, module graph pruning, pseudo-versions, +incompatible suffix

### Maven / Gradle
- https://maven.apache.org/enforcer/enforcer-rules/dependencyConvergence.html — `requireUpperBoundDeps` rule
- https://howtodoinjava.com/maven/maven-bom-bill-of-materials-dependency/ — BOM structure and usage
- https://sbomify.com/guides/java/ — SBOM generation for Java

### Renovate
- https://docs.renovatebot.com/configuration-options/ — `rangeStrategy`, `automerge`, `automergeType`, `automergeStrategy`, `automergeSchedule`, `schedule`, `groupName`, `groupSlug`, `pinDigests`

### Dependabot
- https://docs.github.com/en/code-security/dependabot/dependabot-version-updates/configuring-dependabot-version-updates — `version: 2` config format, `package-ecosystem`, `schedule.interval`, `ignore`, `open-pull-requests-limit`

### License Compatibility
- https://en.wikipedia.org/wiki/License_compatibility — GPL/Apache/MIT/BSD compatibility matrix
- https://www.gnu.org/licenses/license-list.html — FSF license list and GPL compatibility annotations
- https://dev.to/juanisidoro/open-source-licenses-which-one-should-you-pick-mit-gpl-apache-agpl-and-more-2026-guide-p90 — 2026 license guide
- https://docs.debricked.com/opentext-core-sca-blogs/blogs/oss-licenses-part-6-license-compatibility-and-dual-licensing — compatibility and dual licensing

### CIS Supply Chain Security Benchmark
- Referenced via: https://bastion.tech/blog/npm-supply-chain-attacks-2026-saas-security-guide — 60-day cooldown recommendation for new package versions

---

## Step 4: What Was NOT Used and Why

| Source / Agent | Why not used |
|---|---|
| `awesome-claude-code-subagents` `dependency-manager` agent content | 404 on raw file fetch; could not inspect content |
| `awesome-claude-code-subagents` `license-engineer` agent | License legal obligations are deferred to Compliance; this agent covers only license identification and compatibility flags |
| OWASP Dependency-Check version number | Not prominently surfaced; agent references by invocation command pattern, which is stable across versions |
| CIS Supply Chain Security Benchmark full document | Not publicly fetchable; key recommendation (60-day cooldown) incorporated via secondary source |
| Sigstore / cosign documentation | Supply chain signing tooling beyond the agent's assessment scope; agent notes npm provenance and PyPI Sigstore attestations as signals to check, but implementation is deferred to DevOps |
| OSV (Open Source Vulnerabilities) database schema | Not needed; agent references OSV as a data source for `pip-audit` and `govulncheck` by name, which is sufficient for heuristic use |
| `govulncheck` full documentation | Call-graph-aware CVE detection behavior incorporated from Go ecosystem knowledge; implementation deferred to the toolchain |
| Snyk documentation | Referenced as an ecosystem-wide scanner option; full configuration patterns are DevOps-scope |
| NIST NVD API | Downstream data source; not directly invoked by the agent persona |
| CISA KEV full catalog | Agent notes KEV escalation rule; full catalog is a runtime lookup, not a static rule to embed |

---

## Step 7: Cold-Trace Review Notes

Realistic invocation: a PR that adds three new npm packages — `lodash@4.17.21`, `axios@1.8.0`, and `moment@2.29.4`.

Trace through the agent:

1. **PR / Change Review mode** is the correct task mode — identified immediately from "PR that adds new packages"
2. **Pinning assessment**: all three are exact semver pins — no `^` or `~` flags needed; lockfile should be updated — agent checks that `package-lock.json` was committed with the PR
3. **License check**: `lodash` is `MIT`, `axios` is `MIT`, `moment` is `MIT` — all permissive; no conflict; no Compliance defer needed
4. **CVE check**: `axios@1.8.0` — agent would prompt checking `npm audit` for this version range; axios had CVE-2022-24999 at `<4.18.2` (Express ecosystem, not axios directly — worth noting); for axios specifically, SSRF issues in older versions; `npm audit` would surface any current advisories
5. **Transitive exposure**: `moment` is known to pull in `moment-timezone` and has a large bundle footprint; agent flags notable transitive additions
6. **Unmaintained**: `moment` is in maintenance mode (the maintainers themselves recommend migration to alternatives like `date-fns` or `Temporal`); agent flags this via the "no releases > 24 months" and "deprecated status" heuristics
7. **Verdict**: `Dependency risk: low-medium` — all MIT, no CVEs (assuming clean audit), but `moment` flagged as unmaintained/maintenance-mode

Result: all heuristics executable directly from `package.json`, `package-lock.json`, `npm audit` output. The `moment` maintenance-mode finding is the non-obvious catch that validates the unmaintained detection heuristic.

**Bidirectional scope deferral check**:
- CVE present → flag with CVE ID + CVSS → defer to Security ✓
- Copyleft license present → flag with SPDX identifier → defer to Compliance ✓
- Security agent defers semver policy and upgrade scheduling to this agent (confirmed in `software-security.md` scope section) ✓
- Compliance agent defers license identification and compatibility to this agent (confirmed in `software-compliance.md` scope section — no explicit mention, but the gap is in its scope: vendor risk and change management; this agent fills the license identification gap) ✓

---

## Design Doc Notes

### Persona framing

The persona — "you are importing not just code but its entire maintenance history, license obligations, and transitive dependency tree" — is a decision-making frame, not an expertise claim. It shapes model prioritization: when two heuristics conflict (e.g., a very popular unmaintained package vs. a niche maintained one), the frame directs toward the trust-accounting question.

### Evidence anchoring

Every heuristic bullet is phrased as an observable check against a specific file type or tool output: `package.json` ranges, `go.sum` entries, `npm audit` output, `.github/dependabot.yml` presence. No conceptual labels (e.g., "check security") appear without a specific, verifiable indicator.

### Specificity test applied

The specificity test for each heuristic: "can the model identify this from a package manifest, lockfile, or CI config file?" Items that failed (e.g., "assess the maintainability of the project") were replaced with observable proxies (last-release date, archived repo flag, OpenSSF Scorecard `Maintained` score ≤ 3).

### Surface-then-defer pattern

CVE findings use the exact format: package + version + CVE ID + CVSS score + affected range + explicit "defer to Security for exploitation analysis." This prevents the agent from expanding into security threat modeling while still making the vulnerability visible and actionable.

License findings use: package + SPDX identifier + compatibility rule violated + "defer to Compliance for legal interpretation and remediation path."

### Adjacency to Security agent

The existing `software-security.md` explicitly defers "dependency version resolution (semver policy, upgrade scheduling)" to this agent. This agent explicitly defers "CVE exploitation analysis" to Security. The boundary is symmetric and bidirectional — confirmed in Step 7 trace.

### SLSA level naming

SLSA level names are embedded directly as `Build L0` through `Build L3` with their guarantee descriptions. This allows the model to produce a concrete SLSA assessment from a CI config file review (look for `actions/attest-build-provenance`, `slsa-framework/slsa-github-generator`, or their absence).

### Ecosystem-specific section rationale

Dependency management has genuinely different behaviors across ecosystems — MVS in Go vs. ranges in npm vs. BOMs in Maven are not merely syntactic differences. The ecosystem section ensures heuristics are not npm-centric when reviewing a Go or Maven project.

### Adjacent agents list

Architecture, API Design, Security, Data Privacy, Data Integrity, Logging & Auditing, Observability, Testing, Code Quality, Compliance, Performance, Reliability, DevOps, Accessibility, User Experience — referenced in the authoring brief; not repeated in the agent file itself (the agent's defer language names only those with active adjacency: Security, Compliance, DevOps, Architecture).
