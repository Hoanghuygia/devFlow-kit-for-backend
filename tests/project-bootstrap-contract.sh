#!/usr/bin/env bash
set -euo pipefail

skill="skills/project-bootstrap/skill.md"

if [[ ! -f "$skill" ]]; then
  printf 'FAIL: project-bootstrap skill is missing\n' >&2
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

require "name: project-bootstrap" "skill name is missing"
require "## Overview" "overview is missing"
require "**Announce at start:**" "start announcement is missing"
require 'only creates or updates `AGENTS.md`' "AGENTS-only ownership is missing"
require 'extends the standard `/init` workflow' "standard init extension is missing"
require "Preserve useful existing guidance" "existing AGENTS guidance preservation is missing"

require 'docs/specs/<feature>/spec.md' "feature spec path is missing"
require 'docs/specs/<feature>/api.md' "API spec path is missing"
require 'docs/specs/<feature>/impact-map.md' "impact map path is missing"
require 'docs/architecture/dependency-map.md' "dependency map path is missing"

require "Identify the feature or domain affected by the task." "feature discovery step is missing"
require 'Find the matching directory under `docs/specs/<feature>/`.' "spec directory discovery step is missing"
require 'Read `spec.md`, `api.md`, and `impact-map.md` when present.' "feature spec read guidance is missing"
require 'Read `docs/architecture/dependency-map.md` when present' "dependency map read guidance is missing"
require "Report missing specification guidance" "missing specification reporting rule is missing"
require "Do not invent business rules" "business-rule fabrication prohibition is missing"

require 'Do not create or modify files under `docs/specs/`.' "spec scaffolding prohibition is missing"
require 'Do not create or modify `docs/architecture/dependency-map.md`.' "dependency map creation prohibition is missing"
require 'Use the `spec-writer` skill' "spec-writer handoff is missing"

reject "## Implementation Workflow" "implementation workflow leaked into bootstrap"
reject "### Step 3: Create Specification Structure" "spec structure creation step leaked into bootstrap"
reject "### Step 4: Create Dependency Map" "dependency map creation step leaked into bootstrap"
reject "After business behavior changes:" "post-implementation workflow leaked into bootstrap"

printf 'PASS: project-bootstrap skill contract\n'
