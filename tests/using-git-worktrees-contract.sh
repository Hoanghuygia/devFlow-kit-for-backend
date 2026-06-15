#!/usr/bin/env bash
set -euo pipefail

skill="skills/using-git-worktrees/skill.md"

require() {
  rg -q -U --fixed-strings "$1" "$skill" || {
    printf 'FAIL: %s\n' "$2" >&2
    exit 1
  }
}

reject() {
  if rg -q --fixed-strings "$1" "$skill"; then
    printf 'FAIL: %s\n' "$2" >&2
    exit 1
  fi
}

require "## 1. Detect Isolation" "isolation detection step is missing"
require "git rev-parse --git-dir" "git directory detection is missing"
require "git rev-parse --git-common-dir" "common git directory detection is missing"
require "git rev-parse --show-superproject-working-tree" "submodule guard is missing"
require "Do not create another worktree." "nested worktree protection is missing"
require "Prefer a native worktree capability when one is available." "native worktree preference is missing"
require "git worktree add" "git fallback is missing"
require "git show-ref --verify --quiet" "existing branch handling is missing"
require "git check-ignore" "project-local ignore safety check is missing"
require "## 3. Set Up the Project" "project setup step is missing"
require "## 4. Verify the Baseline" "baseline verification step is missing"
require "## 5. Report Readiness" "readiness reporting step is missing"
require "Stop and report" "failure reporting rule is missing"

reject "~/.config/superpowers/worktrees" "legacy Superpowers path must be removed"
reject "backward compatibility" "backward compatibility logic must be removed"
reject "global directory" "global directory conventions must be removed"
reject "Node.js" "framework-specific setup examples must be removed"
reject "Sandbox fallback" "environment-specific fallback must be removed"

words="$(wc -w < "$skill")"
if (( words > 500 )); then
  printf 'FAIL: worktree skill has %s words; maximum is 500\n' "$words" >&2
  exit 1
fi

printf 'PASS: using-git-worktrees contract\n'
