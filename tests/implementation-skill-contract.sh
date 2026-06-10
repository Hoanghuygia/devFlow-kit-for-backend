#!/usr/bin/env bash
set -euo pipefail

implementation="skills/implementation/skill.md"
router="skills/skill-router/skill.md"

require() {
  local pattern="$1"
  local file="$2"
  local message="$3"

  if ! rg -q --fixed-strings "$pattern" "$file"; then
    printf 'FAIL: %s\n' "$message" >&2
    exit 1
  fi
}

reject() {
  local pattern="$1"
  local file="$2"
  local message="$3"

  if rg -q --fixed-strings "$pattern" "$file"; then
    printf 'FAIL: %s\n' "$message" >&2
    exit 1
  fi
}

require "## Low Complexity" "$implementation" "low-complexity path is missing"
require "## Medium Complexity" "$implementation" "medium-complexity path is missing"
require "## High Complexity" "$implementation" "high-complexity path is missing"
require "Propose 2-3 viable approaches" "$implementation" "high path does not require multiple approaches"
require "User approves the design?" "$implementation" "high path approval gate is missing"
require "Revise and present the design again" "$implementation" "design rejection loop is missing"
require "**REQUIRED SUB-SKILL:** Use \`writing-plan\`" "$implementation" "writing-plan handoff is missing"
require "**REQUIRED SUB-SKILL:** Use \`using-git-worktrees\`" "$implementation" "worktree handoff is missing"
require "Only the high-complexity path invokes \`using-git-worktrees\` by default." "$implementation" "high-only worktree rule is missing"
require "Red-Green-Refactor" "$implementation" "TDD cycle is missing"
require "docs/implementation-notes/YYYY-MM-DD-<feature-name>.md" "$implementation" "implementation-note path is missing"
require "Do not create an empty implementation-note file." "$implementation" "conditional note creation is missing"
require "stop and ask the user" "$implementation" "blocking uncertainty rule is missing"
require "## Verify Before Completion" "$implementation" "verification gate is missing"
require "## Summary Change" "$implementation" "change summary is missing"
require "Route to \`skills/implementation/skill.md\`." "$router" "router implementation handoff is missing"
reject "Placeholder for a future implementation workflow skill." "$implementation" "implementation is still a placeholder"

printf 'PASS: implementation skill contract\n'
