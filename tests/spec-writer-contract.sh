#!/usr/bin/env bash
set -euo pipefail

skill="skills/spec-writer/skill.md"

if [[ ! -f "$skill" ]]; then
  printf 'FAIL: spec-writer skill is missing\n' >&2
  exit 1
fi

require() {
  local pattern="$1"
  local message="$2"

  if ! rg -q --fixed-strings "$pattern" "$skill"; then
    printf 'FAIL: %s\n' "$message" >&2
    exit 1
  fi
}

reject() {
  local pattern="$1"
  local message="$2"

  if rg -q --fixed-strings "$pattern" "$skill"; then
    printf 'FAIL: %s\n' "$message" >&2
    exit 1
  fi
}

require "name: spec-writer" "skill name is missing"
require "## Overview" "overview is missing"
require "**Announce at start:**" "start announcement is missing"
require "docs/specs/<feature>/spec.md" "feature spec path is missing"
require "docs/specs/<feature>/api.md" "API spec path is missing"
require "docs/specs/<feature>/impact-map.md" "impact map path is missing"
require "docs/architecture/dependency-map.md" "dependency map path is missing"

require "### Goal" "spec goal section is missing"
require "### Actors" "spec actors section is missing"
require "### User Stories" "spec user stories section is missing"
require "### Functional Requirements" "functional requirements section is missing"
require "### Non-Functional Requirements" "non-functional requirements section is missing"
require "### Acceptance Criteria" "acceptance criteria section is missing"
require 'Do not put database schemas, implementation details, internal architecture, or code in `spec.md`.' "spec content prohibition is missing"

require "### Endpoints" "API endpoints section is missing"
require "### Request Schema" "request schema section is missing"
require "### Response Schema" "response schema section is missing"
require "### Validation Rules" "validation rules section is missing"
require "### Error Responses" "error responses section is missing"
require 'Keep `api.md` implementation-agnostic.' "implementation-agnostic API rule is missing"

require "### Depends On" "depends-on section is missing"
require "### Affects" "affects section is missing"
require "### Owned APIs" "owned APIs section is missing"
require "### Key Behaviors" "key behaviors section is missing"
require "### Change Impact" "change impact section is missing"

require "## Handling Discrepancies" "discrepancy handling section is missing"
require "compare the current specification against the actual implementation" "spec-to-implementation comparison is missing"
require "not caused by the current requested change" "unrelated discrepancy scope is missing"
require "Do not silently rewrite the specification to match the implementation." "silent spec rewrite prohibition is missing"
require "Do not silently change the implementation to match the specification." "silent implementation change prohibition is missing"
require "Report the discrepancy explicitly" "discrepancy reporting rule is missing"
require "Treat the discrepancy as a separate finding from the current task's impact analysis." "separate finding rule is missing"
require "Ask the user which is the source of truth before resolving it" "source-of-truth escalation rule is missing"

require 'Use only `- ` (dash followed by one space) for each level.' "dependency map dash format is missing"
require "Indent nested levels with exactly two spaces." "dependency map indentation rule is missing"
require "Do not use box-drawing characters." "box-drawing prohibition is missing"
reject "├─ depends on" "dependency map example uses a box-drawing dependency branch"
reject "└─ depends on" "dependency map example uses a box-drawing dependency branch"
reject "├─ independent" "dependency map example uses a box-drawing independent branch"
reject "└─ independent" "dependency map example uses a box-drawing independent branch"

require "## Create Workflow" "create workflow is missing"
require "## Update Workflow" "update workflow is missing"
require "Before editing an existing feature, read all four specification files:" "hard-gate four-file read rule is missing"
require "Read all four specification files before editing." "read-before-edit rule is missing"
require "Determine what behavior changes, what contracts change, and what dependencies are affected." "change analysis is missing"
require "Update every affected specification file." "cross-file update rule is missing"

require "## Consistency Checks" "consistency checks are missing"
require '`spec.md` and `api.md` agree.' "spec and API consistency check is missing"
require '`impact-map.md` reflects current feature dependencies.' "impact-map consistency check is missing"
require '`dependency-map.md` reflects current feature relationships.' "dependency-map consistency check is missing"
require "Acceptance criteria remain valid." "acceptance criteria check is missing"
require "Never leave specifications out of sync." "source-of-truth completion rule is missing"

printf 'PASS: spec-writer skill contract\n'
