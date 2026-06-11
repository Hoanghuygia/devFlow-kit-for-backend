#!/usr/bin/env bash
set -euo pipefail

router="skills/skill-router/skill.md"

require() {
  rg -q --fixed-strings "$1" "$router" || {
    printf 'FAIL: %s\n' "$2" >&2
    exit 1
  }
}

reject() {
  if rg -q --fixed-strings "$1" "$router"; then
    printf 'FAIL: %s\n' "$2" >&2
    exit 1
  fi
}

require "<HARD-GATE>" "hard gate is missing"
require "Task Type:" "task type analysis is missing"
require "Intent:" "intent analysis is missing"
require "Complexity:" "complexity analysis is missing"
require "Risk:" "risk analysis is missing"
require "Missing Information:" "missing-information analysis is missing"
require "Selected Workflow: [workflow name]" "workflow output is missing"
require "Reason: [one short sentence explaining why this workflow fits]" "workflow reason is missing"
require "Outcome: [desired result]" "router handoff outcome is missing"
require "Constraints: [user and repository constraints]" "router handoff constraints are missing"
require "Assumptions: [none | stated assumptions]" "router handoff assumptions are missing"
require "Direct Answer" "Direct Answer route is missing"
require "Implementation Feature" "Implementation Feature route is missing"
require "Bug Fixing" "Bug Fixing route is missing"
require "Review" "Review route is missing"
require "Refactor" "Refactor route is missing"
require "skills/direct-answer/skill.md" "Direct Answer target is missing"
require "skills/implementation/skill.md" "Implementation Feature target is missing"
require "skills/review/skill.md" "Review target is missing"
require "placeholder" "placeholder workflow boundary is missing"
reject '```dot' "diagram must be removed"
reject "## Examples" "examples must be removed"

words="$(wc -w < "$router")"
if (( words > 500 )); then
  printf 'FAIL: router has %s words; maximum is 500\n' "$words" >&2
  exit 1
fi

printf 'PASS: skill-router contract\n'
