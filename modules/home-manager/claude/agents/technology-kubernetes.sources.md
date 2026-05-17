# Kubernetes Technology Expert — Sources

References that informed `technology-kubernetes.md`. The agent prioritizes Context7 (LLM-targeted, snippet-style retrieval against the canonical docs) and the official `kubernetes.io` site over secondary material. The Kubernetes API reference is the source of truth for field shapes and is pinned to the current stable minor.

## Version Calibration

- **Kubernetes version pinned**: **1.36** (latest stable: v1.36.1, released 2026-05-13). Source: https://kubernetes.io/releases/ (fetched 2026-05-17).
- **Date confirmed**: 2026-05-17.
- **Supported branches** at calibration time: 1.34 / 1.35 / 1.36. End-of-life for 1.34: 2026-10-27. Support policy: ~1 year of patch support per minor.
- **Gateway API**: latest release confirmed via https://github.com/kubernetes-sigs/gateway-api/releases is v1.5.x line (v1.5.1 cited release notes from early 2025; site index didn't surface a newer tag during authoring). Standard channel `GatewayClass`, `Gateway`, `HTTPRoute` are GA at v1; agent treats Gateway API as production-ready for these resources.
- **Kustomize**: shipped inside `kubectl` (`kubectl kustomize`, `kubectl apply -k`). Standalone CLI tracked via `/kubernetes-sigs/kustomize`; current API version `kustomize.config.k8s.io/v1beta1`.
- **Feature-state callouts verified at v1.36**:
    - **Native sidecar containers** (initContainer with `restartPolicy: Always`) — GA in **v1.33** (per https://kubernetes.io/docs/concepts/workloads/pods/sidecar-containers/). Earlier: beta in 1.29, alpha in 1.28. **Note**: user instructions referenced 1.29 as the GA version; the live docs say 1.33 GA / 1.29 beta-on-by-default. Calibrated to docs.
    - **ValidatingAdmissionPolicy** (CEL-based admission) — GA in **v1.30** (per https://kubernetes.io/docs/reference/access-authn-authz/validating-admission-policy/).
    - **Server-Side Apply** — stable since **v1.22**.
    - **Aggregated discovery** — stable in **v1.30**.
    - **OpenAPI v3** API publishing — stable in **v1.27**.
    - **ReadWriteOncePod** access mode — GA in **v1.29**.
- **Default admission controllers in 1.36** confirmed via https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/ — list includes `ValidatingAdmissionPolicy` by default, matching the Approach section's recommendation.

## Existing Agents and Skills Consulted

- **VoltAgent `awesome-claude-code-subagents`** (https://github.com/VoltAgent/awesome-claude-code-subagents) — referenced only as a scope sanity check, per the skill's guidance. Many community Kubernetes agents flatten Helm, Docker, GitOps, and Kubernetes core into one omnibus "kubernetes-master" persona. That conflicts with this repo's split-by-tool approach. Nothing adopted.
- **Repo-local style references**:
    - `technology-payloadcms.md` — adopted the broad-surface variant with sub-domain groupings and per-domain documentation tables, and the "preferred lookup" pattern naming Context7 as the top row of each domain group.
    - `technology-wordpress.md` — adopted the sub-domain pattern in Core Concepts (Workloads / Networking / etc., parallel to Classic theme / Plugin / Block editor / etc.) and the version-pinned calibration line in the system prompt.
    - `technology-nix.md` — adopted the persona frame (deep expertise + fetch-first) and the layered debugging pattern.
- **Helm peer agent** — being authored in parallel (per user instructions). Scope deliberately defers all Helm, chart templating, values.yaml, and release management to that agent.

## Primary Sources

### Context7 (primary lookup channel)

- **`/websites/kubernetes_io`** — Source Reputation High, benchmark 83.45, **37,318 code snippets**. The broadest snippet coverage of any Kubernetes index. Used in the agent as the default Context7 ID for cross-cutting and concept queries.
- **`/kubernetes/website`** — Source Reputation High, benchmark 84.8, 16,279 snippets, **versioned snapshots** available (`snapshot-final-v1.31`, `snapshot-initial-v1.32`, `snapshot_final_v1_32`). Use when version-pinned answers matter; offers reproducibility but lower snippet count.
- **`/kubernetes/kubernetes`** — Source Reputation High, benchmark 51.11, 16,761 snippets, version-tagged (`v1_32_8` available). Useful when source-level context (the actual k/k Go code) is needed; not the default for narrative docs.
- **`/kubernetes-sigs/kustomize`** — Source Reputation High, benchmark 86.1, 661 snippets. The agent's Kustomize source of truth; verified to return well-formed `kustomization.yaml` examples with `patches`, `patchesJson6902`, `patchesStrategicMerge`, generators, and overlays.
- **`/kubernetes-sigs/gateway-api`** — Source Reputation High, benchmark 86.27, 2,510 snippets, versioned (`v1.2.1` available). The Gateway API source; the agent points network sub-domain queries here.
- **`/kubernetes/api`** — benchmark 67.16, 51 snippets. Lower snippet count; useful only for canonical API type definitions in Go.
- **`/kubernetes/apimachinery`** — benchmark 79, 53 snippets. Same caveat.

### Official Documentation (verified during authoring 2026-05-17)

All URLs in the agent's Documentation Sources tables were fetched. Status:

**Verified, accessible, content matches:**

- https://kubernetes.io/docs/concepts/ — confirmed; the 12-13 concept categories enumerated in the response inform the sub-domain groupings.
- https://kubernetes.io/releases/ — confirmed; gives current stable, EOL dates, support policy.
- https://kubernetes.io/docs/concepts/overview/kubernetes-api/ — confirmed.
- https://kubernetes.io/docs/reference/kubectl/ — confirmed; lists Introduction, Quick Reference, generated reference, kubectl-cmds, JSONPath, conventions, kuberc, Docker-to-kubectl.
- https://kubernetes.io/docs/reference/kubectl/generated/ — confirmed.
- https://kubernetes.io/docs/reference/kubectl/quick-reference/ — confirmed.
- https://kubernetes.io/docs/reference/kubectl/jsonpath/ — confirmed.
- https://kubernetes.io/docs/reference/kubectl/kuberc/ — confirmed.
- https://kubernetes.io/docs/reference/kubernetes-api/ — confirmed; categories: Workload, Service, Config and Storage, Authentication, Authorization, Policy, Extend, Cluster, Common Definitions, Common Parameters.
- https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.36/ — confirmed; documents all v1.36 API groups (admissionregistration, apiextensions, apiregistration, apps, autoscaling, batch, certificates, coordination, core, discovery, flowcontrol, networking, node, policy, rbac, resource, scheduling, storage, storagemigration).
- https://kubernetes.io/docs/concepts/workloads/ — confirmed; lists Pods, Deployments, ReplicaSets, StatefulSets, DaemonSets, Jobs, CronJobs, ReplicationController (legacy), HPA, VPA, plus advanced scheduling (PodGroup, gang scheduling, etc.).
- https://kubernetes.io/docs/concepts/workloads/pods/sidecar-containers/ — confirmed; GA 1.33 verified.
- https://kubernetes.io/docs/concepts/workloads/pods/init-containers/ — confirmed.
- https://kubernetes.io/docs/concepts/services-networking/ — confirmed; lists Service, Ingress, Ingress Controllers, Gateway API, EndpointSlices, NetworkPolicies, DNS, dual-stack, topology-aware routing, etc.
- https://kubernetes.io/docs/concepts/storage/ — confirmed; lists Volumes, PVs, projected/ephemeral, StorageClass, VolumeAttributesClasses, dynamic provisioning, snapshots, capacity, node-volume-limits, local-ephemeral, health monitoring, Windows.
- https://kubernetes.io/docs/concepts/configuration/ — confirmed; lists ConfigMaps, Secrets, probes, resource management, kubeconfig.
- https://kubernetes.io/docs/concepts/scheduling-eviction/ — confirmed; covers scheduler, node assignment, taints/tolerations, topology spread, scheduling framework, pod priority/preemption, eviction.
- https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/ — confirmed.
- https://kubernetes.io/docs/concepts/security/ — confirmed; lists Pod Security Standards, Pod Security Admission, ServiceAccounts, multi-tenancy, hardening guides, security checklist.
- https://kubernetes.io/docs/concepts/policy/ — confirmed; covers LimitRanges, ResourceQuotas, PID limits, plus mentions admission control approaches.
- https://kubernetes.io/docs/reference/access-authn-authz/rbac/ — confirmed; covers API objects (Role, ClusterRole, bindings), default roles, privilege escalation prevention, kubectl helpers, ServiceAccount permissions, ABAC migration.
- https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/ — confirmed; describes built-in admission controllers (default list for 1.36 includes ValidatingAdmissionPolicy + ValidatingAdmissionWebhook + MutatingAdmissionWebhook).
- https://kubernetes.io/docs/reference/access-authn-authz/validating-admission-policy/ — confirmed; GA 1.30; covers ValidatingAdmissionPolicy + Binding + parameter resource, CEL expressions, validation actions.
- https://kubernetes.io/docs/reference/using-api/server-side-apply/ — confirmed; covers `managedFields`, conflict detection, ownership transfer, comparison with `last-applied-configuration`.
- https://kubernetes.io/docs/tasks/manage-kubernetes-objects/declarative-config/ — confirmed; covers `kubectl apply` semantics including merge strategy and prune.
- https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/ — confirmed.
- https://kubectl.docs.kubernetes.io/references/kustomize/ — confirmed; index links to Built-Ins, Commands, Glossary, Kustomization File reference.

**Could not directly verify (returned 404 during authoring) — kept based on parent-page mention:**

- https://gateway-api.sigs.k8s.io/concepts/versioning/ — 404 at time of fetch (page may have been moved/renamed). Worked around by fetching `https://github.com/kubernetes-sigs/gateway-api/releases` for version info instead. The root https://gateway-api.sigs.k8s.io/ exists; the agent points users there as the entry point.
- https://gateway-api.sigs.k8s.io/concepts/api-overview/ — 404 at fetch time. Same workaround.

The Gateway API site appears to have reorganized its navigation since older snapshots; the root URL is stable and Context7 (`/kubernetes-sigs/gateway-api`) is a more reliable lookup path than browsing the live site. The agent's Gateway API row points at the root + Context7 index.

### Source and Release Channels

- https://github.com/kubernetes/kubernetes — main k/k repo. Useful for source-level questions, version tags (`v1.36.1`), and definitive resource definitions in `staging/src/k8s.io/api/`.
- https://github.com/kubernetes-sigs/kustomize — Kustomize source, examples, and reference content. Context7-indexed and verified to return current `kustomization.yaml` examples.
- https://github.com/kubernetes-sigs/gateway-api/releases — release index. Used to confirm Gateway API version status.
- https://kubernetes.io/releases/ — canonical release schedule, EOL dates, version skew policy.

## Volatile vs. Stable Classification

**Embedded (stable across 1.34/1.35/1.36 — unlikely to change without a major paradigm shift)**:

- The API conventions skeleton (`apiVersion / kind / metadata / spec / status`, labels vs annotations, `ownerReferences`, finalizers, `managedFields`).
- The controller hierarchy `Deployment → ReplicaSet → Pod` and the StatefulSet / DaemonSet / Job / CronJob roles.
- Pod lifecycle phases (Pending / Running / Succeeded / Failed / Unknown) and the standard PodConditions.
- QoS classes (Guaranteed / Burstable / BestEffort) and how they're derived from `requests` / `limits`.
- Probe types and what each one controls (liveness restarts, readiness drops from Endpoints, startup gates the other two).
- Service types and the label-selector → EndpointSlice → kube-proxy chain.
- RBAC model (Role / ClusterRole / RoleBinding / ClusterRoleBinding, verb-based rules).
- The PV / PVC / StorageClass triad and the dynamic-provisioning flow.
- The ConfigMap / Secret env-vs-mount semantic difference (env baked at start; mount propagates).
- Scheduling levers (nodeSelector, affinity, taints/tolerations, topology spread, PriorityClass).
- Kustomize concept (base + overlay + patches), the unified `patches:` field, generators, components.
- kubectl idioms (output formats, selectors, dry-run modes, `auth can-i`, `rollout`, `wait`).
- SSA mental model and the implications for `apply` vs `edit` vs `patch`.

**Always fetch (volatile — version-sensitive, ask `kubectl version` first)**:

- Exact field signatures on any resource — fetch the v1.36 generated reference or `kubectl explain`.
- Default values on Pod spec fields (e.g., default `terminationGracePeriodSeconds`, default `restartPolicy` per workload type, default `backoffLimit` for Jobs).
- Default admission controller list (changes minor-to-minor).
- Default kube-proxy mode (iptables/IPVS/nftables varies by distribution and version).
- Feature gate status of any non-GA feature (alpha/beta/GA mapping moves every release).
- kubectl flag set per command — the canonical answer is `kubectl <cmd> --help` on the user's installed binary.
- Kustomize transformer and generator option keys — the unified `patches:` field replaced older fields recently; deprecations move.
- Gateway API channel status (Standard vs Experimental) per resource.
- StorageClass `parameters` per CSI driver — these are driver-specific and out of the agent's authoritative range; defer to driver docs.
- Provider-specific Service LoadBalancer annotations (these belong to cloud-provider agents, not core).
- Pod Security Standard exact rule set per version (`pod-security.kubernetes.io/enforce-version: <version>` matters).

## Design Notes

- **Sub-domain table grouping is essential for Kubernetes.** The flat Documentation Sources table proposed by the basic skill template would have been unusable here — Kubernetes' surface spans Workloads / Networking / Storage&Config / RBAC&Security / Scheduling / Extension / kubectl&Kustomize / API Conventions, and each has its own canonical doc subtree. The broad-surface variant from the skill (sub-headings on the table) was the right call, and the agent's Core Concepts and Approach sections mirror the same partition for cross-referenceability.
- **`kubectl explain` is a first-class lookup mechanism.** Unique to this domain compared to, say, Payload or WordPress: when the user has a cluster, `kubectl explain <resource>.<field>` is *faster and more accurate* than fetching kubernetes.io because it reads the OpenAPI schema directly from their API server (which knows their version, their CRDs, their installed admission controllers). The agent's Approach section names this explicitly and the Documentation Sources section lists local commands as a "prefer for several lookups" block. This pattern is worth carrying forward to other agents that operate against live systems (e.g., a Postgres agent should reach for `psql \d` and `\df`; a Terraform agent should reach for `terraform providers schema`).
- **Helm carve-out is enforceable.** Many Kubernetes questions arrive shaped like "how do I deploy X" and the user has already chosen Helm. The agent's Scope statement names Technology Helm as the peer and the Approach section adds a redirect trigger ("anything templating a chart, managing releases ... route there"). Mirror this in the Helm peer agent (it should know to defer raw-Kubernetes questions back here).
- **Gateway API is the "new shape that's not fully replacing the old shape" hazard.** Ingress is not deprecated; users on existing clusters often still want Ingress answers. The agent covers both rather than nudging everyone to Gateway API — picked phrasing: "Prefer Gateway API for new clusters where the controller supports it. Ingress is not deprecated and stays for compatibility." This pattern (covering both old and new APIs without picking sides for the user) is generally right for Kubernetes' long-lived deprecation timelines.
- **Server-Side Apply matters more than its prominence in docs would suggest.** SSA's `managedFields` model silently affects every `kubectl apply` invocation and is the root cause of a class of "I edited it and my changes vanished" bugs. The agent embeds the mental model in Core Concepts (API Conventions sub-domain) and again in the debugging table ("SSA conflict → read `managedFields`"). This deserves explicit coverage because the symptom is non-obvious from the error message.
- **Calibration discrepancy worth noting in user-facing output.** The user's authoring brief mentioned "native sidecars 1.29 GA" — the live docs at fetch time say 1.33 GA / 1.29 beta-on-by-default. Calibrated the agent to the docs (1.33 GA) and added a note in this file. When the user asserts a version-fact, the agent's job is to verify against current docs rather than accept it on authority.
- **Context7 versioning is partially useful here.** The `/kubernetes/website` snapshots (`snapshot_final_v1_32`) are useful for reproducible v1.32-pinned queries but lag the current stable; for cutting-edge answers, `/websites/kubernetes_io` (no version pinning, broadest snippet pool) is the better default. The agent's table lists both and notes when to use which.
