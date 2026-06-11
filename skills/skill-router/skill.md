---
name: skill-router
description: Use to explore context, analyze the task, ask clarifying questions when needed, confirm understanding, select one workflow, and route execution.
---

# Workflow Router

Analyze the request and route execution. `skill-router` is the orchestration layer.

<HARD-GATE>
Do NOT invoke a workflow skill, write code, perform a review, debug a failure, or provide the final answer until task analysis is complete and a workflow has been selected.
</HARD-GATE>

Anti-Pattern: do not assume the solution before understanding the task. Simple tasks may proceed directly; moderate tasks may need clarification; complex or high-risk tasks should use a design-oriented workflow.

## Overview

The router explores context, analyzes the task, asks clarifying questions if needed, confirms understanding, selects one workflow, and executes it.

## The Process

**Explore Context:** Check the request, repo instructions, files, diffs, logs, errors, and prior context. Use only enough to classify the task.

**Task Analysis:**

```text
Task Type: [explanation | implementation | bug fix | review | refactor | mixed]
Intent: [desired outcome]
Complexity: [low | medium | high] - [coordination cost]
Risk: [low | medium | high] - [possible consequence]
Missing Information: [none | blocking and non-blocking unknowns]
```

Task Type names the work category; Intent is the desired outcome; Complexity is coordination cost; Risk is consequence; Missing Information is what is unknown and whether it blocks routing. Mixed requests are allowed during analysis, but workflow selection must choose one primary workflow.

Intent is the user's desired outcome — it may differ from the literal words in the request:
- "What does this code do?" -> understand behavior
- "Can you check this diff?" -> find production risks
- "Make this simpler" -> reduce complexity while preserving behavior
- "This test is failing" -> identify and fix the cause

Complexity is about coordination cost:
- Low - small, local, clear input and output
- Medium - several files, some unknowns, or moderate design choices
- High - cross-cutting behavior, ambiguous requirements, migration, compatibility, or broad architecture impact

Risk is about consequence:
- Low - little chance of user-visible breakage
- Medium - behavior, data, or API contracts could be affected
- High - security, data loss, money movement, migrations, auth, irreversible operations, or broad production impact

Missing Information: separate into Blocking (cannot route without it) and Non-blocking (can proceed with a stated assumption). Ask only for blocking information.

**Confirm Understanding:** Before routing, say back what the user wants, the important constraints, and any assumptions. Keep this to 2-3 short sentences.

## Workflow Selection

Select exactly one workflow based on intent, task type, complexity, and risk.

- **Direct Answer** - explanation, comparison, or recommendation without modifying the workspace. Route to `skills/direct-answer/skill.md`.
- **Implementation Feature** - new or changed behavior, files, UI, API behavior, or automation. Route to `skills/implementation/skill.md`.
- **Bug Fixing** - an error, failing test, broken behavior, regression, unexpected output, or production issue. Route to the future bug-fixing workflow when implemented; until then, stop at the placeholder boundary and explain that the workflow is a future placeholder.
- **Review** - review, audit, validation, risk assessment, or "check this" without immediate edits. Route to `skills/review/skill.md`.
- **Refactor** - restructuring, cleanup, renaming, extraction, or architecture changes while preserving behavior. Route to the future refactor workflow when implemented; until then, stop at the placeholder boundary and explain that the workflow is a future placeholder.

## Route Execution

```text
Selected Workflow: [workflow name]
Reason: [one short sentence explaining why this workflow fits]
Outcome: [desired result]
Constraints: [user and repository constraints]
Assumptions: [none | stated assumptions]
```

Invoke or follow the selected workflow skill. If the workflow is not implemented yet, stop at the placeholder boundary and explain that the workflow is a future placeholder.

## Clarifying Questions

Ask a clarifying question only when the selected workflow would change, execution would be unsafe, the scope is contradictory, or required inputs are unavailable from context. Prefer one question at a time.

## Examples

**Request:** "Explain how authentication is wired."
Task Type: explanation
Intent: understand current behavior
Complexity: medium
Risk: low
Workflow: Direct Answer, because the user wants understanding rather than changes.

**Request:** "Add CSV export to reports."
Task Type: implementation
Intent: add user-facing behavior
Complexity: medium
Risk: medium
Workflow: Implementation Feature, because behavior changes are requested.

**Request:** "This endpoint returns 500 after the last change."
Task Type: bug fix
Intent: restore correct behavior
Complexity: unknown until context is explored
Risk: medium or high depending on endpoint
Workflow: Bug Fixing, because the request is about broken behavior.

**Request:** "Review this mapper diff."
Task Type: review
Intent: identify production risks
Complexity: low to medium
Risk: medium
Workflow: Review, because the user asks for assessment rather than edits.

**Request:** "Rename this workflow and clean up the docs without changing behavior."
Task Type: refactor
Intent: restructure existing skill architecture
Complexity: medium
Risk: medium
Workflow: Refactor, because the desired outcome is structural change while preserving behavior.

## Behavioral Guidance
- Route first, then execute.
- Keep analysis concise but explicit.
- Treat user constraints as routing inputs.
- Prefer available project context over assumptions.
- Do not invent workflow behavior for placeholder workflows.
- If a selected workflow is only a placeholder, say that clearly and stop before implementation-specific reasoning.
- If the user explicitly asks for no modifications, select Direct Answer, Review, or Research as appropriate and do not edit files.
