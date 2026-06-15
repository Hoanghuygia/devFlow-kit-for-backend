---
name: implementation
description: Use when the router selects Implementation Feature for creating or changing product behavior.
---

# Implementation

<HARD-GATE>
Require the complete router handoff. Use its Complexity without silently reclassifying it. Do not skip required approval or begin implementation before the selected complexity path reaches implementation.
</HARD-GATE>

## Overview

**Announce at start:** "I'm using the `implementation` skill to implement task."

## Expected Router Handoff

```text
Selected Workflow: Implementation Feature
Reason: [why this workflow fits]
Outcome: [desired result]
Constraints: [user and repository constraints]
Assumptions: [none | stated assumptions]
Complexity: [low | medium | high]
Risk: [low | medium | high]
```

If a field is missing or blocking information remains, return to `skill-router`. Do not repeat its task analysis.

## Common Execution

After completing exactly one complexity path:

1. Implement only the approved task scope.
2. Apply TDD only to behavior-changing work.
3. Update all affected specifications before completion.
4. Record genuine non-blocking uncertainty when present.
5. Verify with fresh project-appropriate checks.
6. For medium and high complexity, invoke `review-code`.
7. Write Summary Change.

Modify only files related to the requested task. Do not fix unrelated errors or potential bugs. Record them under Unrelated Issues in Summary Change.

## Low Complexity

- Proceed directly to implementation.
- Do not require a separate design proposal, written spec, implementation plan, or worktree.
- Low complexity does not invoke `review-code`.

## Medium Complexity

1. **REQUIRED SUB-SKILL:** Use `spec-writer` to write or update the authoritative feature specifications.
2. Confirm the `spec-writer` consistency checks passed.
3. **REQUIRED SUB-SKILL:** Use `writing-plan`.
4. Execute Common Execution.

Do not create a worktree by default for medium complexity. An explicit user or repository instruction may still require isolation.

## High Complexity

1. Propose 2-3 viable approaches with trade-offs and a recommendation.
2. Present the design.
3. Ask: User approves the design?
4. If no or changes are requested: Revise and present the design again.
5. Continue only after explicit approval.
6. **REQUIRED SUB-SKILL:** Use `spec-writer` to write or update the authoritative feature specifications.
7. Confirm the `spec-writer` consistency checks passed.
8. **REQUIRED SUB-SKILL:** Use `writing-plan`.
9. **REQUIRED SUB-SKILL:** Use `using-git-worktrees`.
10. Execute Common Execution.

Only the high-complexity path invokes `using-git-worktrees` by default.
Must invoke `review-code` after verification and before Summary Change.

## Design Approval

High-complexity work must compare real alternatives before implementation.

For each approach, state:

- The core design
- Important trade-offs
- Expected impact on the existing system
- Testing or migration implications

Recommend one approach and explain why it best fits the task. Present the design clearly enough for the user to approve or correct it.

Do not treat silence as approval. If the user rejects the design or requests changes, revise the design and present it again. Do not continue to the spec until the user explicitly approves.

## Writing Or Updating The Spec

Medium- and high-complexity work requires an authoritative spec before planning.

- Use `spec-writer` as the single owner of feature specification structure and consistency.
- Do not create a separate dated design spec when the repository uses the `spec-writer` four-file structure.
- Return to `implementation` after the specification consistency checks pass, then invoke `writing-plan`.
- If the repository defines another authoritative specification system, follow that repository instruction instead of creating a duplicate.

## Implementation

Implementation must remain within the approved outcome, spec, and plan. Do not add unrelated refactors or speculative features.

For each task in plan:
1. Mark it `in_progress`.
2. Follow its steps exactly.
3. Run its specified verification.
4. Mark it `completed`.

### Red-Green-Refactor

TDD is mandatory only when the task introduces or changes observable behavior.

1. Write one focused failing test.
2. Run it and confirm it fails for the expected missing behavior.
3. Write the minimum implementation needed to pass.
4. Run the focused test and relevant broader tests.
5. Refactor only while tests remain green.

Repeat for each behavior change.

Documentation-only, configuration-only, file moves, renames, and other non-behavioral changes do not require a failing test. Use appropriate verification such as contract checks, syntax validation, builds, formatting, or focused inspection.

## Update Related Specs

Implementation may reveal details that make an approved behavior or contract more precise.

- Update the authoritative related spec when behavior, inputs, outputs, errors, compatibility, or constraints change.
- Keep the implementation plan aligned when execution changes the planned file or verification steps.
- Do not rewrite a spec to hide an implementation deviation. Surface material scope changes to the user.

## Implementation Notes

When any genuine unresolved uncertainty remains, even a small one, create:

`docs/implementation-notes/YYYY-MM-DD-<feature-name>.md`

Do not create an empty implementation-note file.

Each implementation note must state:

- **Uncertain Point** - what is not fully confirmed
- **Decision Or Assumption** - what the implementation currently uses
- **Possible Impact** - what may change if the assumption is wrong
- **Resolution** - how to verify or resolve it later

Implementation notes are for residual, non-blocking uncertainty. If uncertainty is blocking, unsafe, or could materially change the requested outcome, stop and ask the user.

## Verify Before Completion

Run fresh project-appropriate tests, build, lint, formatting, or documentation contract checks.

Before claiming completion:

1. Identify the commands that prove the change works.
2. Run the complete commands.
3. Read the output and exit status.
4. Fix failures caused by the change.
5. Report actual results.

Inspection alone is not verification. Do not claim success from expected results or an earlier run.

## Code Review

Medium- and high-complexity work requires review after verification and before Summary Change.

**REQUIRED SUB-SKILL:** Use `review-code`.

Resolve blocking review findings before Summary Change. Report non-blocking
findings, spec discrepancies, and open questions without silently changing code
or specifications outside the approved implementation scope.

## Summary Change

The final summary must state:

- What behavior or files changed
- Which specs or implementation notes changed
- What verification ran and its result
- Any remaining uncertainty, limitation, or follow-up
- **Unrelated Issues** - errors or potential bugs discovered outside the task scope; state `none` when no such issue was found

Keep the summary proportional to the change. Do not create an implementation note when no unresolved uncertainty remains.

## Red Flags

Stop when:

- Complexity is missing from the router handoff
- High-complexity design has not been explicitly approved
- Medium- or high-complexity work has no reviewed spec
- The required implementation plan is missing
- A high-complexity worktree has not been handled by `using-git-worktrees`
- A behavior-changing test was not observed failing before implementation
- Blocking uncertainty is being hidden in an implementation note
- Completion is about to be claimed without fresh verification
- Medium- or high-complexity work reached Summary Change without invoking `review-code`
- An unrelated error or potential bug is being modified instead of reported
