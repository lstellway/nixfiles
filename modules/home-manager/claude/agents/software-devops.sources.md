# Software DevOps Agent — Sources

References that informed the heuristics in `software-devops.md`.

## Version / Date Pinning Table

| Reference | Edition / Version | Date |
|---|---|---|
| DORA State of DevOps Report | 2024 (most recent as of authoring) | October 2024 |
| DORA metrics model | Five-metric model (Deployment Rework Rate added) | 2024 |
| DORA metrics model | Failed Deployment Recovery Time replaced MTTR | 2023 |
| Accelerate (Forsgren, Humble, Kim) | First edition | 2018 |
| The DevOps Handbook (Kim, Humble, Debois, Willis) | Second edition | 2023 |
| OpenGitOps Principles | v1.0.0 | 2021 |
| Twelve-Factor App | No versioned edition; original 2011; open-sourced November 2024 | 2011 / 2024 |
| SLSA framework | v1.1 (three Build Levels: 1, 2, 3) | 2024 |

---

## Existing Agents & Skills Reviewed

### Used

None of the VoltAgent awesome-claude-code-subagents agent files were directly used. The repository was reviewed (Step 1) and the following were identified as relevant:

- **devops-engineer** — file returned 404 at the direct raw URL. The listing page confirmed it exists. Given the 404, no content was incorporated; heuristics were authored independently from primary sources.
- **deployment-engineer** — file returned 404 at the direct raw URL. Same handling.
- **terraform-engineer** — confirmed exists in the listing. Not fetched; Terraform IaC heuristics were sourced from primary Terraform documentation and DORA/Accelerate frameworks instead.
- **kubernetes-specialist** — confirmed exists. Not fetched; Kubernetes deployment strategy heuristics were sourced from Kubernetes upstream documentation and Argo Rollouts documentation instead.
- **platform-engineer** — confirmed exists. Not fetched; scope does not overlap with the primary DevOps pipeline and delivery focus of this agent.

### What Was Not Used and Why

The VoltAgent agents follow a minimal templating pattern (role declaration + tool permissions list) with limited heuristic depth. They are useful as invocation stubs but do not provide the executable, evidence-anchored check patterns required by this agent family's design principles. All substantive heuristics were derived from the primary frameworks listed below.

---

## Frameworks & Standards

- [DORA — Five Software Delivery Metrics (dora.dev)](https://dora.dev/guides/dora-metrics-four-keys/) — Authoritative current metric definitions: deployment frequency, lead time for changes, change failure rate, failed deployment recovery time, deployment rework rate. Metric names used verbatim.
- [DORA — History of DORA's Software Delivery Metrics](https://dora.dev/insights/dora-metrics-history/) — Evolution timeline: original four metrics (2014–2015), MTTR renamed to failed deployment recovery time in 2023 (scoped to software-caused failures, not external infrastructure), deployment rework rate added in 2024; throughput vs. stability categorization.
- [DORA State of DevOps Report 2024](https://dora.dev/research/2024/dora-report/) — Current edition; confirmed as most recent. Elite/high/medium/low performance band benchmarks are published in the DORA Quick Check tool rather than the main report narrative.
- [Accelerate: The Science of Lean Software and DevOps — Forsgren, Humble, Kim (IT Revolution, 2018)](https://itrevolution.com/product/accelerate/) — Scientific grounding for the four key metrics (original DORA four); evidence base linking software delivery performance to organizational outcomes; deployment frequency and lead time as throughput measures; change failure rate and MTTR as stability measures.
- [The DevOps Handbook, Second Edition — Kim, Humble, Debois, Willis (IT Revolution, 2023)](https://itrevolution.com/product/the-devops-handbook-second-edition/) — The Three Ways (Flow, Feedback, Continual Learning and Experimentation); deployment pipeline as a first-class product; integrating security and compliance into the pipeline.
- [OpenGitOps Principles v1.0.0 — open-gitops/documents](https://github.com/open-gitops/documents/blob/main/PRINCIPLES.md) — Four principles: Declarative (desired state expressed declaratively), Versioned and Immutable (state stored with version history), Pulled Automatically (agents pull desired state), Continuously Reconciled (agents apply desired state continuously). Informs IaC modularity and drift detection heuristics.
- [The Twelve-Factor App — Heroku (2011; open-sourced 2024)](https://12factor.net/) — Factor III (Config: store config in environment variables, not code); Factor V (Build, release, run: strict separation of build, release, and run stages); Factor X (Dev/prod parity: keep development, staging, and production as similar as possible). Directly informs environment parity and build reproducibility sections.
- [SLSA — Supply-chain Levels for Software Artifacts v1.1 (slsa.dev)](https://slsa.dev/spec/v1.2/about) — Build Level 1 (provenance generated), Build Level 2 (hosted build platform, build script in VCS), Build Level 3 (hermetic build, no network access during build). Informs build reproducibility and supply chain integrity section.
- [Trunk-Based Development — trunkbaseddevelopment.com](https://trunkbaseddevelopment.com/) — Short-lived branches (< 1 day), continuous integration on trunk, feature flags as a mechanism to merge incomplete work, DORA research correlation between trunk-based development and high deployment frequency.

---

## Articles & Documentation

- [CD Foundation Blog — The DORA 4 key metrics become 5 (October 2025)](https://cd.foundation/blog/2025/10/16/dora-5-metrics/) — Confirms deployment rework rate as the fifth metric; explains its distinction from change failure rate (rework rate measures the ratio of unplanned deployments caused by incidents, not just the ratio of failed deploys).
- [GitHub Actions — Attest Build Provenance](https://docs.github.com/en/actions/security-for-github-actions/using-artifact-attestations/using-artifact-attestations-to-establish-provenance-for-builds) — Implementation reference for SLSA Build Level 1 provenance generation in GitHub Actions pipelines.
- [GitHub Actions — Hardening for GitHub Actions](https://docs.github.com/en/actions/security-for-github-actions/security-guides/security-hardening-for-github-actions) — Pinning third-party Actions to commit SHAs, OIDC federation for short-lived cloud credentials, environment protection rules for production secrets.
- [Argo Rollouts — Progressive Delivery Documentation](https://argoproj.github.io/argo-rollouts/) — Canary `AnalysisTemplate` and blue/green deployment mechanics in Kubernetes; automated promotion and abort based on metric thresholds. Cited as a named implementation tool for canary strategy.
- [Terraform — State Backend Documentation](https://developer.hashicorp.com/terraform/language/backend) — Remote state with locking; S3 + DynamoDB backend configuration; state encryption at rest.
- [SLSA — Threats and Mitigations](https://slsa.dev/spec/v1.0/threats) — Build L1/L2/L3 threat model including insider threat, build platform compromise, dependency confusion.

---

## Adjacent Agents (Cross-Reference)

The following peer agents were read to verify bidirectional scope boundary alignment:

- **software-observability.md** — already defers "pipeline mechanics" (Collector topology, exporter deployment) to DevOps, and expects DevOps to handle DORA metrics definition and instrumentation. This agent's scope reflects that agreement: DevOps stays for DORA signal *emission* from pipelines; Observability owns metric *collection infrastructure* and alerting.
- **software-security.md** — covers pipeline supply chain security (dependency CVEs, SAST/DAST tool selection, secrets in code). This agent's surface-then-defer language flags pipeline secrets hygiene and directs to Security for depth, matching Security's stated scope.
- **software-testing.md** — explicitly defers "CI pipeline configuration, test execution infrastructure, parallelism strategy" to DevOps. This agent owns those topics exactly.

---

## Design Doc Notes

Three patterns emerged during authoring that are relevant for future agent files:

1. **DORA metric names have evolved and must be version-pinned.** The metrics changed in 2023 (MTTR → Failed Deployment Recovery Time) and 2024 (four → five metrics with Deployment Rework Rate). Any agent that references DORA metrics should pin to the specific edition and use the exact current names, not the original four-metric names from the Accelerate book. The five current names are: *deployment frequency*, *lead time for changes*, *change failure rate*, *failed deployment recovery time*, *deployment rework rate*.

2. **Surface-then-defer is more useful than one-way defer for cross-cutting concerns.** Secrets in pipelines is simultaneously a DevOps topic (pipeline hygiene, credential scope) and a Security topic (supply chain attack surface, OIDC design). Rather than deferring the entire topic, this agent surfaces the pipeline-visible signal ("flag any `AWS_ACCESS_KEY_ID` in a pipeline job") and explicitly directs to the Security agent for the threat modeling depth. This pattern keeps the agent actionable for in-context pipeline reviews without requiring a Security agent invocation for every finding.

3. **Deployment strategy heuristics require named config fields to be executable.** "Review your rollback plan" is not executable. "Check that `kubectl rollout undo deployment/<name>` or Argo Rollouts abort has been tested in the past 30 days" is. The deployments strategy section names specific Kubernetes fields (`maxSurge`, `maxUnavailable`), specific tools (Argo Rollouts `AnalysisTemplate`, Flagger), and specific commands — making heuristics applicable directly from a YAML manifest or pipeline config without additional lookup.
