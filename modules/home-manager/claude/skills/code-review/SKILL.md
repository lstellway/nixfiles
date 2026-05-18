---
name: code-review
description: Multi-agent code review skill. Selects relevant specialist agents based on the target, confirms the set with the user, fans out in parallel, and aggregates findings into a unified prioritized report.
---

## Overview

This skill reviews a target by:
1. Resolving what the user wants reviewed (clarifying if unclear)
2. Proposing a set of specialist agents whose expertise applies
3. Confirming the proposed set with the user
4. Fanning out to the confirmed agents in parallel
5. Aggregating findings into a single prioritized report

---

## Steps

### 1. Resolve target

Parse the user's input to determine what they want reviewed. The target may be code, a diff, a proposed design, an existing system, or anything else the user wants feedback on.

If the target is missing or ambiguous, ask the user to clarify before proceeding.

For concrete targets (files, PRs), gather the content (read the file, fetch the diff) before proposing agents so the proposal is informed by what the target actually contains.

### 2. Propose agents

Scan the agents available in this session — including domain agents (`Software *`) and technology agents (`Technology *`) — and select those whose expertise plausibly applies to the target.

Selection guidance:
- Default to a baseline of broad-coverage domain agents (e.g., security, code quality, testing, architecture) for any code review.
- Add specialist domain agents based on what the target touches (e.g., accessibility for UI, data privacy for PII handling, observability for instrumentation, reliability for failure-mode-sensitive code).
- Add technology agents based on file types, frameworks, or stack hints visible in the target (e.g., the Terraform agent for `.tf` files; the React agent for `.tsx` files; the Kubernetes agent for manifests).
- For proposed designs (vs. implemented code), favor architecture- and API-design-focused agents over implementation-focused ones like testing or performance.
- Err on the side of inclusion when uncertain — the user will prune in the next step.

### 3. Confirm with user

Present the proposed agent set as a text reply, briefly noting why each was chosen. Wait for the user to confirm or adjust before dispatching.

Honor any natural-language modification — for example:
- "drop devops and dependency-management"
- "add accessibility"
- "just security and testing"
- "yes" / "looks good" / "go"

Do not dispatch agents until the user has explicitly confirmed. There is no opt-out for this step.

### 4. Fan out in parallel

Once confirmed, announce dispatch briefly ("Running N agents in parallel — this may take a minute.") and invoke all selected agents simultaneously in a **single parallel Agent tool call** (all `Agent` invocations in one message). Do not call agents sequentially.

Phrase each agent's prompt to match the target type:
- For existing code or a PR diff: "Review the following code."
- For a proposed design or description: "Evaluate the following proposed design."

Prompt template:

```
You are performing a code review. Below is the review target.

**Target**: <description, file path, or PR identifier>

<target content, diff, or description>

Apply your domain expertise. Follow your standard output format:
- If this target does not touch your domain, state that explicitly as your first line: "No findings — this target does not touch [domain]."
- Otherwise: domain-specific sections → Findings (each tagged [Critical], [High], [Medium], or [Info]) → What's Working → Questions
```

### 5. Aggregate

Wait for all agents to return. Note which agents returned "No findings" vs. which returned substantive output.

Produce the unified report following these rules:

**Cross-cutting detection**: If two or more agents cite the same file and location in a finding, mark it as `[Cross-cutting: agent1, agent2]` and deduplicate — show it once at the top of Priority Findings.

**Severity ordering**: Collect all `[Critical]` and `[High]` findings across all agents into the Priority Findings section, regardless of source agent. Cross-cutting findings appear first within their severity tier.

**Per-agent grouping**: `[Medium]` and `[Info]` findings remain grouped under their source agent in the Agent Reports section.

**What's Working**: Merge all agents' "What's Working" observations into a single section.

**Questions**: Merge all agents' "Questions" into a single Open Questions section, prefixed with the source agent name.

---

## Output Format

```markdown
## Review: <target>

**Agents**: <N> invoked (<M> with findings, <K> no findings)

---

### Summary

| Severity | Count |
|----------|-------|
| Critical | N     |
| High     | N     |
| Medium   | N     |
| Info     | N     |

**Agents with findings**: agent1, agent2, ...
**No findings**: agent3, agent4, ...

---

### Priority Findings

> All Critical and High findings across all agents. Cross-cutting findings appear first.

#### [Cross-cutting: Security, Compliance] [High] — `src/auth/session.ts:42`
<finding description>

#### [Security] [Critical] — `src/api/upload.ts:18`
<finding description>

---

### Agent Reports

<details>
<summary>Software Architecture — 2 findings</summary>

#### [Medium] — `src/services/UserService.ts`
<finding>

#### [Info]
<finding>

</details>

<details>
<summary>Software Testing — 1 finding</summary>
...
</details>

<!-- Agents with no findings are omitted from this section -->

---

### What's Working

- (Software Security) Token rotation is implemented correctly.
- (Software Testing) Unit test coverage on the happy path is solid.

---

### Open Questions

- (Software Architecture) Is the service boundary here intentional or incidental coupling?
- (Software Security) What is the session timeout policy for privileged operations?
```

**When all agents return no findings:**

```markdown
## Review: <target>

All <N> invoked agents returned no findings for this target.

**Agents invoked**: agent1, agent2, ...
```
