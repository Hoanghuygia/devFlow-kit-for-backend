---
name: using-git-worktrees
description: Use when starting work that requires an isolated Git workspace or before executing an implementation plan outside the current checkout
---

# Using Git Worktrees

## Overview

Create or reuse an isolated workspace without nesting worktrees or contaminating the repository.

**Announce at start:** "I'm using the using-git-worktrees skill to prepare an isolated workspace."

## 1. Detect Isolation

Before creating anything, inspect the current checkout:

```bash
git_dir="$(cd "$(git rev-parse --git-dir)" && pwd -P)"
git_common="$(cd "$(git rev-parse --git-common-dir)" && pwd -P)"
superproject="$(git rev-parse --show-superproject-working-tree 2>/dev/null || true)"
```

`git_dir != git_common` can indicate either a linked worktree or a submodule. If `superproject` is non-empty, apply the check to the intended repository rather than treating the submodule as an existing worktree.

If the intended repository is already a linked worktree, use it and continue with setup. Do not create another worktree. Record its path and branch or detached-HEAD state.

## 2. Create an Isolated Workspace

Prefer a native worktree capability when one is available. Use it to create or enter the isolated workspace, then continue with setup.

Otherwise, use Git:

1. Choose a branch name and target path. Follow explicit project or user instructions; otherwise use an existing project-local `.worktrees/` or `worktrees/` directory, defaulting to `.worktrees/`.
2. Confirm the target does not overlap an existing entry in `git worktree list`.
3. For a project-local directory, confirm it is inside the repository root and ignored:

   ```bash
   git check-ignore -q "$worktree_root"
   ```

   If it is not ignored, add the exact directory to `.gitignore` and verify again before continuing.
4. Create the workspace. Use the existing branch if present; otherwise create it:

   ```bash
   if git show-ref --verify --quiet "refs/heads/$branch"; then
     git worktree add "$path" "$branch"
   else
     git worktree add "$path" -b "$branch"
   fi
   ```

5. Enter the new workspace and confirm its path and branch.

Stop and report any detection, safety, or creation failure. Do not continue implementation in a non-isolated workspace unless the user explicitly changes the requirement.

## 3. Set Up the Project

Read the repository instructions and manifests, then run the documented dependency, bootstrap, or generation commands required for a fresh checkout. Report setup failures and stop.

## 4. Verify the Baseline

Run the project's documented validation and test commands before implementation. Check `git status --short` for unexpected tracked changes.

If validation fails or setup changed tracked files unexpectedly, report the commands and failures and ask whether to investigate or proceed. Do not describe the baseline as clean.

## 5. Report Readiness

Report:

- workspace path and branch state
- native capability or Git fallback used
- setup commands completed
- baseline validation result
- whether the workspace is ready for implementation

Only report readiness when isolation, setup, and baseline checks all succeeded.
