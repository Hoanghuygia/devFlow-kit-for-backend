---
name: review-code
description: Use when reviewing newly implemented or changed code against its feature specification, checking for bugs, legacy-code duplication, and style/quality issues before merging.
---

# Review Code

<HARD-GATE>
Before reviewing any code, you MUST identify the affected feature(s) and read the full current content of
`docs/specs/<feature>/spec.md`, `api.md`, and
`impact-map.md` for each affected feature. If no spec exists for a feature,
state that explicitly and review on code-quality grounds only, flagging the missing spec as a finding.
</HARD-GATE>

## Overview

**Announce at start:** "I'm using the `review-code` skill to review the recent changes."

Review the diff of newly implemented or modified code, not the entire codebase.
Check the change against the relevant specification, look for correctness and
quality issues, identify duplicated or legacy logic that should have been
reused, and suggest targeted style improvements.

Print the review report directly in the response. Do not modify code or
specifications.

## Step 1: Determine Scope

Identify the diff to review:

- If the user specifies a range, branch, commit, pull request, or diff, use it.
- Otherwise, default to the diff between the current branch and its base branch
  such as `main` or `master`, or the last commit if no base branch is
  determinable.
- List the changed files and, for each, the changed line ranges, not just file
  names.

Only the changed lines and their immediate surrounding context are in scope for
line-level findings. Read full-file or called-code context only to understand
behavior directly affected by the changes or to identify existing reusable
logic. Report only supported concerns created or exposed by the diff.

If the diff is empty or no changes are found, report that and stop.

## Step 2: Identify Affected Feature(s) and Read Specs

For each changed file, determine which feature or features under
`docs/specs/<feature>/` it belongs to. A single diff may touch multiple
features.

For each affected feature, read:

- `docs/specs/<feature>/spec.md` for business requirements and acceptance
  criteria
- `docs/specs/<feature>/api.md` for request and response shapes, validation
  rules, and error responses
- `docs/specs/<feature>/impact-map.md` for dependencies and affected behavior

If a changed file does not map to an existing feature spec, record that as a
finding for possible missing or outdated specification coverage. Review that
file on code-quality grounds only.

Do not infer spec content from memory or from the code itself. Read the actual
files.

## Step 3: Spec Conformance Check

Compare the diff against the specifications:

- **Functional requirements:** Check whether behavior matches the documented
  requirements and acceptance criteria. Flag missing, extra, undocumented, or
  contradictory behavior.
- **API contract:** When request handling, response handling, validation, or
  errors change, check field names, types, required or optional status, status
  codes, and error identifiers against `api.md`.
- **Dependencies:** If the diff introduces a call to or from another feature
  not listed under `Depends On` or `Affects` in `impact-map.md`, flag it as an
  undocumented dependency.

If the code does something reasonable that the specification does not cover,
do not assume the code is wrong; flag it as a **discrepancy**, report both
sides, and do so without guessing which is the source of truth. Do not edit the
specification or code to resolve it.

## Step 4: Code Quality and Correctness

Review the diff for:

- **Bugs and correctness issues:** Logic errors, off-by-one errors, incorrect
  conditionals, unhandled edge cases, error-handling failures, resource leaks,
  race conditions, and null or undefined handling.
- **Security and robustness:** Missing validation, unsafe deserialization,
  injection risks, sensitive-data exposure, missing authorization or ownership
  checks, unsafe fallback behavior, duplicate processing, and idempotency gaps.
- **Data and reliability risks:** Partial updates, inconsistent state,
  transaction or rollback gaps, concurrency problems, and hidden side effects.
- **Performance risks:** N+1 queries, unnecessary database calls, expensive
  work inside loops, unbounded collection processing, or missing pagination.
- **Consistency with non-functional requirements:** If `spec.md` defines
  performance, reliability, or accessibility constraints, check whether the
  diff plausibly satisfies them.
- **Test coverage:** Flag missing tests for important behavior introduced or
  changed by the diff.

Report only concrete, production-relevant concerns. Explain the likely impact
and a practical correction; do not praise code or add generic advice.

## Step 5: Legacy/Existing-Code Reuse Check

Before claiming that new code should reuse existing logic, search the codebase for existing utilities,
helper functions, base classes, shared modules, or
abstractions that overlap with the diff.

Look for:

- Logic that reimplements an existing support method, utility, base-class
  method, or helper
- A duplicated codebase pattern implemented with inconsistent naming, error
  handling, or return types
- Code that bypasses an established abstraction, such as issuing a direct
  database query where the project convention uses a repository or service
  layer

For each confirmed instance, cite the existing method/utility (file + name)
that should be used or followed.

Do not flag stylistic differences that are not actual duplication. Only report
cases where a reasonably equivalent existing capability was not used.

## Step 6: Style/Syntax Improvement Suggestions

Suggest exactly 2-3 specific syntax or style improvements from the diff when
that many useful suggestions exist.

Suggestions must be:

- Concrete and localized with a file and line or changed snippet
- Idiomatic for the language and framework
- Non-blocking improvements rather than required fixes

Prefer improvements such as a built-in collection operation instead of a
manual loop, async/await instead of a callback chain, a guard clause instead of
deep nesting, or a language feature that improves null safety.

Do not pad the section; if fewer than 2 genuinely useful suggestions exist, report fewer rather than
inventing filler.

## Report Format

Print the review directly in the response using this structure:

```markdown
## Code Review: <scope description, e.g. "feature/xyz vs main">

### Files Reviewed
- path/to/file1 (lines X-Y)
- path/to/file2 (lines X-Y)

### Specs Consulted
- docs/specs/<feature>/spec.md, api.md, impact-map.md
- (or: "No spec found for <file/feature> - flagged below")

### Spec Conformance
- [Match / Mismatch / Discrepancy] findings, one per item, with file:line
  references and the relevant spec section.

### Bugs & Potential Issues
- One per item, with file:line, description, impact, and practical correction.
- If none found, state "No issues found."

### Legacy/Reuse Issues
- One per item: what was duplicated, and the existing method or utility that
  should be used instead (file + name).
- If none found, state "No reuse issues found."

### Style/Syntax Suggestions (2-3)
- One per item, with file:line, current snippet, and suggested improvement.

### Open Questions
- Anything that needs human judgment, such as a spec/code discrepancy whose
  source of truth is unclear, or "none".
```

## Boundaries

- Do not modify source code, tests, or spec files as part of this review.
- Do not silently resolve spec/code discrepancies. Always report them.
- Do not review unchanged code beyond what's needed to understand the context
  of the diff.
- Do not report unsupported, historical, or generic concerns.
- If the diff is empty or no changes are found, report that and stop.
