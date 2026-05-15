---
name: review
description: Multi-agent code review skill. Fans out to specialist agents in parallel and aggregates findings into a unified prioritized report. Use for PR review, file review, design review, or audits.
---

## Overview

This skill accepts a review target and optional configuration, dispatches selected specialist agents in parallel, then aggregates their outputs into a single prioritized report.

---

## Input Parsing

Parse the invocation arguments as follows:

**Target** (required): The first non-flag argument. Can be:
- A file path (e.g., `src/auth/login.ts`)
- A PR number or GitHub URL
- A natural-language description of what to review
- Omitted → ask the user what to review before proceeding

**Flags**:
- `--agents <list>`: Comma-separated short names of agents to invoke (e.g., `--agents security,testing,code-quality`). Overrides the default set.
- `--all`: Invoke all 16 `software-*` agents. Takes precedence over `--agents`.
- `--mode <mode>`: Task mode — `pr-review` (default), `design`, or `audit`. Passed through to each agent as context.

**If no target is provided**: Ask the user "What would you like me to review?" before dispatching any agents.

---

## Agent Registry

### Default set (7 agents)

| Short name             | Agent name                    |
|------------------------|-------------------------------|
| `architecture`         | Software Architecture         |
| `api-design`           | Software API Design           |
| `security`             | Software Security             |
| `testing`              | Software Testing              |
| `code-quality`         | Software Code Quality         |
| `performance`          | Software Performance          |
| `dependency-management`| Software Dependency Management|

### Full set (all 16 `software-*` agents)

| Short name             | Agent name                    |
|------------------------|-------------------------------|
| `accessibility`        | Software Accessibility        |
| `api-design`           | Software API Design           |
| `architecture`         | Software Architecture         |
| `code-quality`         | Software Code Quality         |
| `compliance`           | Software Compliance           |
| `data-integrity`       | Software Data Integrity       |
| `data-privacy`         | Software Data Privacy         |
| `dependency-management`| Software Dependency Management|
| `devops`               | Software DevOps               |
| `logging-auditing`     | Software Logging & Auditing   |
| `observability`        | Software Observability        |
| `performance`          | Software Performance          |
| `reliability`          | Software Reliability          |
| `security`             | Software Security             |
| `testing`              | Software Testing              |
| `user-experience`      | Software User Experience      |

---

## Steps

### 1. Resolve target

If the target is a file path, read the file contents to pass as context. If it is a PR number, fetch the diff. If it is a description, use it as-is.

### 2. Determine agent set

- If `--all` is present: use all 16 agents from the full set.
- If `--agents <list>` is present: use only the named agents from the registry. Warn about any unrecognized names and skip them.
- Otherwise: use the 7-agent default set.

Note expected duration: "Running N agents in parallel — this may take a minute."

### 3. Fan out in parallel

Invoke all selected agents simultaneously in a **single parallel Agent tool call** (all `Agent` invocations in one message). Do not call agents sequentially.

Each agent receives this prompt:

```
You are performing a <MODE> review. Below is the review target.

**Mode**: <mode>
**Target**: <target description or file path>

<target content or diff>

Apply your domain expertise. Follow your standard output format:
- If this target does not touch your domain, state that explicitly as your first line: "No findings — this target does not touch [domain]."
- Otherwise: domain-specific sections → Findings (each tagged [Critical], [High], [Medium], or [Info]) → What's Working → Questions
```

### 4. Collect outputs

Wait for all agents to return. Note which agents returned "No findings" vs. which returned substantive output.

### 5. Aggregate

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

**Mode**: <mode> | **Agents**: <N> invoked (<M> with findings, <K> no findings)

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
