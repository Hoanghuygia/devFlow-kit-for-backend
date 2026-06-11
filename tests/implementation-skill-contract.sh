#!/usr/bin/env bash
set -euo pipefail

implementation="skills/implementation/skill.md"
router="skills/skill-router/skill.md"
code_review="skills/code-review/skill.md"

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
require "## Expected Router Handoff" "$implementation" "router handoff contract is missing"
require "Selected Workflow: Implementation Feature" "$implementation" "implementation workflow handoff is missing"
require "Outcome: [desired result]" "$implementation" "handoff outcome is missing"
require "Constraints: [user and repository constraints]" "$implementation" "handoff constraints are missing"
require "Assumptions: [none | stated assumptions]" "$implementation" "handoff assumptions are missing"
require "Complexity: [low | medium | high]" "$implementation" "handoff complexity is missing"
require "Risk: [low | medium | high]" "$implementation" "handoff risk is missing"
require "**Announce at start:** \"I'm using the \`implementation\` skill to implement task.\"" "$implementation" "start announcement is missing"
require "Propose 2-3 viable approaches" "$implementation" "high path does not require multiple approaches"
require "User approves the design?" "$implementation" "high path approval gate is missing"
require "Revise and present the design again" "$implementation" "design rejection loop is missing"
require "**REQUIRED SUB-SKILL:** Use \`writing-plan\`" "$implementation" "writing-plan handoff is missing"
require "**REQUIRED SUB-SKILL:** Use \`using-git-worktrees\`" "$implementation" "worktree handoff is missing"
require "Only the high-complexity path invokes \`using-git-worktrees\` by default." "$implementation" "high-only worktree rule is missing"
require "Red-Green-Refactor" "$implementation" "TDD cycle is missing"
require "TDD is mandatory only when the task introduces or changes observable behavior." "$implementation" "conditional TDD rule is missing"
require "Documentation-only, configuration-only, file moves, renames, and other non-behavioral changes do not require a failing test." "$implementation" "non-behavioral verification rule is missing"
require "docs/implementation-notes/YYYY-MM-DD-<feature-name>.md" "$implementation" "implementation-note path is missing"
require "Do not create an empty implementation-note file." "$implementation" "conditional note creation is missing"
require "stop and ask the user" "$implementation" "blocking uncertainty rule is missing"
require "## Verify Before Completion" "$implementation" "verification gate is missing"
require "**REQUIRED SUB-SKILL:** Use \`code-review\`." "$implementation" "code-review gate is missing"
require "Low complexity does not invoke \`code-review\`." "$implementation" "low-complexity review exemption is missing"
require "Invoke \`code-review\` after verification and before Summary Change." "$implementation" "code-review ordering is missing"
require "Return to Summary Change and report that code review was unavailable." "$implementation" "placeholder review does not return to summary"
require "Modify only files related to the requested task." "$implementation" "task-related file scope rule is missing"
require "Do not fix unrelated errors or potential bugs." "$implementation" "unrelated issue edit prohibition is missing"
require "Unrelated Issues" "$implementation" "unrelated issue summary note is missing"
require "## Summary Change" "$implementation" "change summary is missing"
require "name: code-review" "$code_review" "code-review placeholder name is missing"
require "Not implemented yet." "$code_review" "code-review placeholder status is missing"
require "Route to \`skills/implementation/skill.md\`." "$router" "router implementation handoff is missing"
require "Selected Workflow: [workflow name]" "$router" "selected workflow screen output is missing"
require "Reason: [one short sentence explaining why this workflow fits]" "$router" "workflow selection reason is missing"
reject "Placeholder for a future implementation workflow skill." "$implementation" "implementation is still a placeholder"
reject "## Responsibilities" "$implementation" "duplicated responsibilities section remains"
reject "## Checklist" "$implementation" "duplicated checklist section remains"
reject "## Process Flow" "$implementation" "duplicated process diagram remains"

printf 'PASS: implementation skill contract\n'
