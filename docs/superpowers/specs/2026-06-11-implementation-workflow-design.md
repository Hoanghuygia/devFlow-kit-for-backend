# Implementation Workflow Design

## Goal

Replace the placeholder `implementation` skill with a complexity-aware workflow that carries an implementation task from the router's classification through design, specification, planning, implementation, verification, and change summary.

## Scope

This change implements `skills/implementation/skill.md` and updates only directly related workflow text where needed. It preserves `skill-router` as the orchestration layer and reuses the existing `writing-plan` and `using-git-worktrees` skills instead of duplicating their instructions.

## Inputs

The implementation workflow receives:

- The task outcome and constraints confirmed by `skill-router`
- The router's `Complexity` classification: `low`, `medium`, or `high`
- Relevant repository context already discovered or referenced by the request

The workflow must use the router's complexity classification. It must not silently reclassify the task.

## Complexity Paths

### Low

Low-complexity work proceeds directly to implementation:

1. Implement with TDD.
2. Update related specifications when behavior or contracts change.
3. Record any residual implementation uncertainty.
4. Verify the completed work.
5. Summarize the changes.

Low-complexity work does not require a separate design proposal, written spec, implementation plan, or worktree.

### Medium

Medium-complexity work requires specification and planning:

1. Write or update the feature spec.
2. Self-review the spec for placeholders, contradictions, ambiguity, and scope.
3. Invoke `writing-plan`.
4. Implement the approved plan with TDD.
5. Update related specifications as implementation clarifies behavior.
6. Record any residual implementation uncertainty.
7. Verify the completed work.
8. Summarize the changes.

Medium-complexity work does not create a worktree unless another explicit instruction requires one.

### High

High-complexity work requires design approval, specification, planning, and isolation:

1. Propose two or three viable approaches with trade-offs and a recommendation.
2. Present the design.
3. Ask for user approval.
4. If approval is denied or changes are requested, revise and present the design again.
5. After approval, write or update the feature spec.
6. Self-review the spec for placeholders, contradictions, ambiguity, and scope.
7. Invoke `writing-plan`.
8. Invoke `using-git-worktrees`.
9. Implement the approved plan with TDD.
10. Update related specifications as implementation clarifies behavior.
11. Record any residual implementation uncertainty.
12. Verify the completed work.
13. Summarize the changes.

Only the high-complexity path invokes `using-git-worktrees` by default.

## Implementation Notes

During implementation, the agent must write down any genuine unresolved uncertainty, even when confidence is high and the uncertainty is small.

- Save notes to `docs/implementation-notes/YYYY-MM-DD-<feature-name>.md`.
- Create the file only when at least one unresolved uncertainty exists.
- Do not create an empty implementation-note file.
- Each note must identify the uncertain point, the decision or assumption used, its possible impact, and how it can be resolved or verified later.
- Implementation notes do not replace blocking clarification. If uncertainty makes implementation unsafe or could materially change the requested outcome, stop and ask the user.

## Cross-Skill Boundaries

### `skill-router`

The router remains responsible for context exploration, task analysis, complexity classification, confirmation, and selecting the Implementation Feature workflow. It must no longer describe `implementation` as a placeholder.

### `writing-plan`

The implementation workflow invokes `writing-plan` for medium and high complexity. The planning skill remains responsible for plan structure, task decomposition, TDD steps, and plan self-review.

### `using-git-worktrees`

The implementation workflow invokes `using-git-worktrees` only for high complexity by default. The worktree skill remains responsible for detecting existing isolation, obtaining consent where required, creating isolation, setup, and baseline verification.

## TDD And Verification

Implementation must follow red-green-refactor:

1. Write a focused failing test.
2. Run it and confirm the expected failure.
3. Write the minimum implementation needed to pass.
4. Run the focused test and relevant broader tests.
5. Refactor only while tests remain green.

Before reporting completion, the agent must run fresh verification appropriate to the project and report actual results. It must not claim success from inspection alone.

## Summary Change

The final summary must state:

- What behavior or files changed
- Which specs or implementation notes changed
- What verification ran and its result
- Any remaining uncertainty, limitation, or follow-up recorded in implementation notes

## Validation Criteria

The skill documentation is ready when checks confirm:

- All three complexity paths are explicit.
- High complexity includes multiple approaches and an approval loop.
- Medium and high complexity invoke `writing-plan`.
- Only high complexity invokes `using-git-worktrees` by default.
- Every implementation path requires TDD, related-spec updates, verification, and a change summary.
- Implementation notes are conditional and use the agreed path.
- Blocking uncertainty still requires user clarification.
- Router placeholder wording is removed without moving implementation logic into the router.
- Existing uncommitted work in related skills is preserved.
