---
name: linear-start
description: Start work on a Linear issue by creating a git worktree with the branch Linear provides. Input: issue ID (e.g. BUI-45) or full Linear URL. Use at the beginning of a work session to get a clean worktree ready without making naming decisions.
---

Set up a git worktree for a Linear issue without leaving the main checkout.

## Steps

### 1. Parse the issue ID

Accept either format as input:
- Bare issue ID: `BUI-45`
- Full Linear URL: `https://linear.app/builtforbackroads/issue/BUI-45/frontend-buyer-guide-domain-layer`

Extract the issue ID from either form. If no input is given, ask for one before proceeding.

### 2. Fetch issue details

Call the Linear MCP `get_issue` tool with the issue ID.

Extract:
- `gitBranchName` — the full branch name Linear provides (e.g. `logan/bui-45-frontend-buyer-guide-domain-layer`)
- `title` — for display
- `status` — for display

If `gitBranchName` is absent from the response, stop and tell the user — do not attempt to derive a branch name.

### 3. Derive the worktree directory name

Take the segment after the last `/` in `gitBranchName`:

```
logan/bui-45-frontend-buyer-guide-domain-layer
→ bui-45-frontend-buyer-guide-domain-layer
```

This keeps the name descriptive without nesting it under a username subdirectory.

### 4. Check existing state

Before running any git commands, check:
- Does the directory already exist? (`ls <dir>`)
- Does the branch already exist locally? (`git branch --list <branch>`)

### 5. Create the worktree

If neither the directory nor branch exists:
```bash
git worktree add <dir> -b <branch>
```

If the branch already exists locally (resuming a prior session):
```bash
git worktree add <dir> <branch>
```

If the directory already exists, stop and report — do not overwrite it.

### 6. Report

Print:
- Issue: `<ID> — <title>` with status
- Worktree directory: the path that was created
- Branch: the full branch name
- `cd <dir>` as the suggested next step
