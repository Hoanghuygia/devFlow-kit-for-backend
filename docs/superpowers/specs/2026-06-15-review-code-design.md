# Review Code Skill Design

## Goal

Replace the `code-review` placeholder with a `review-code` skill that reviews
changed code against current feature specifications before merge.

## Scope

Create `skills/review-code/skill.md`, remove `skills/code-review/skill.md`, add
`tests/review-code-contract.sh`, and update the implementation workflow and its
contract test to invoke `review-code`.

The change must not modify `skill-router` or unrelated workflow files.

## Review Boundary

Review only the selected diff: a user-provided range, branch, commit, pull
request diff, or the current branch against its base. Findings must concern
changed lines or behavior introduced by those changes. Unchanged code may be
read only to understand the changed behavior or identify existing reusable
logic.

The review is read-only. It must not modify code, tests, or specifications.

## Specification Gate

Before reviewing code, identify every affected feature and read the complete
current `spec.md`, `api.md`, and `impact-map.md` under
`docs/specs/<feature>/`.

If a changed file has no applicable feature specification, report the missing
coverage as a finding and review that file on code-quality grounds only. Do not
infer specification content from code or memory.

## Review Checks

The skill must check:

- Functional and non-functional requirement conformance
- API fields, validation, status codes, and error identifiers
- Undocumented dependencies relative to `impact-map.md`
- Correctness, security, robustness, and production risks
- Existing utilities, abstractions, and patterns that new code duplicates or
  bypasses
- Two or three concrete, non-blocking style or syntax improvements when useful

Reasonable behavior omitted from a specification is a discrepancy, not an
automatic code defect. The report must show both sides without selecting a
source of truth.

## Report

The report must contain:

- Files Reviewed, including changed line ranges
- Specs Consulted
- Spec Conformance
- Bugs & Potential Issues
- Legacy/Reuse Issues
- Style/Syntax Suggestions
- Open Questions

Findings must include file and line references when available. Reuse findings
must cite the existing file and symbol that should be reused. If a findings
section is empty, state that explicitly.

## Verification

The focused contract test will enforce the skill name, announcement, hard
spec-reading gate, diff boundary, discrepancy handling, reuse search, read-only
rule, and report headings.

The implementation contract will enforce the `review-code` handoff for medium-
and high-complexity work and reject stale `code-review` references.
