#!/usr/bin/env bash
set -euo pipefail

skill="skills/review-code/skill.md"

if [[ ! -f "$skill" ]]; then
  printf 'FAIL: review-code skill is missing\n' >&2
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

require "name: review-code" "skill name is missing"
require "description: Use when reviewing newly implemented or changed code against its feature specification" "skill trigger is missing"
require "## Overview" "overview is missing"
require '**Announce at start:** "I'\''m using the `review-code` skill to review the recent changes."' "start announcement is missing"

require "<HARD-GATE>" "specification hard gate is missing"
require 'docs/specs/<feature>/spec.md' "feature specification path is missing"
require 'docs/specs/<feature>/api.md' "API specification path is missing"
require 'docs/specs/<feature>/impact-map.md' "impact map path is missing"
require "read the full current content" "complete specification read rule is missing"
require "If no spec exists for a feature" "missing specification handling is missing"
require "code-quality grounds only" "code-quality fallback is missing"
require "flagging the missing spec as a finding" "missing specification finding is missing"

require "## Step 1: Determine Scope" "scope step is missing"
require "for each, the changed line ranges" "changed line range requirement is missing"
require "Only the changed lines and their immediate surrounding context are in scope" "changed-line scope boundary is missing"
require "If the diff is empty or no changes are found, report that and stop." "empty diff behavior is missing"

require "## Step 2: Identify Affected Feature(s) and Read Specs" "feature identification step is missing"
require "Do not infer spec content from memory or from the code itself" "spec inference prohibition is missing"
require "## Step 3: Spec Conformance Check" "spec conformance step is missing"
require "Functional requirements" "functional requirement check is missing"
require "API contract" "API contract check is missing"
require "undocumented dependency" "dependency documentation check is missing"
require "flag it as a **discrepancy**" "spec discrepancy handling is missing"
require "without guessing which is the source of truth" "source-of-truth restraint is missing"

require "## Step 4: Code Quality and Correctness" "correctness step is missing"
require "Security and robustness" "security review is missing"
require "## Step 5: Legacy/Existing-Code Reuse Check" "reuse step is missing"
require "search the codebase for existing utilities" "existing-code search is missing"
require "cite the existing method/utility (file + name)" "reuse evidence requirement is missing"
require "Do not flag stylistic differences that are not actual duplication" "false duplication guard is missing"

require "## Step 6: Style/Syntax Improvement Suggestions" "style suggestion step is missing"
require "Suggest exactly 2-3 specific syntax or style improvements" "style suggestion limit is missing"
require "if fewer than 2 genuinely useful suggestions exist" "style filler prohibition is missing"

require "### Files Reviewed" "files reviewed report section is missing"
require "### Specs Consulted" "specs consulted report section is missing"
require "### Spec Conformance" "spec conformance report section is missing"
require "### Bugs & Potential Issues" "bugs report section is missing"
require "### Legacy/Reuse Issues" "reuse report section is missing"
require "### Style/Syntax Suggestions (2-3)" "style report section is missing"
require "### Open Questions" "open questions report section is missing"

require "Do not modify source code, tests, or spec files as part of this review." "read-only boundary is missing"
require "Do not silently resolve spec/code discrepancies" "silent discrepancy resolution prohibition is missing"
require "Do not review unchanged code beyond what's needed" "unchanged-code scope boundary is missing"

printf 'PASS: review-code skill contract\n'
