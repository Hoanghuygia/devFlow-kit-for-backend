---
name: spec-writer
description: Use when creating or updating feature specifications, API contracts, impact maps, or high-level dependency relationships in a specification-first repository.
---

# Spec Writer

<HARD-GATE>
Treat specifications as the source of truth. Do not finish after changing only one file when the behavior, API contract, or dependency change affects other specifications.

Before editing an existing feature, read all four specification files:

- `docs/specs/<feature>/spec.md`
- `docs/specs/<feature>/api.md`
- `docs/specs/<feature>/impact-map.md`
- `docs/architecture/dependency-map.md`
</HARD-GATE>

## Overview

**Announce at start:** "I'm using the `spec-writer` skill to maintain the feature specifications."

Create and update specifications under:

```text
docs/
├── architecture/
│   └── dependency-map.md
└── specs/
    └── <feature>/
        ├── spec.md
        ├── api.md
        └── impact-map.md
```

Maintain these files as one consistency boundary:

- `docs/specs/<feature>/spec.md`
- `docs/specs/<feature>/api.md`
- `docs/specs/<feature>/impact-map.md`
- `docs/architecture/dependency-map.md`

Use the repository's existing feature name and terminology. Do not create a second specification for a feature that already has an authoritative specification.

## `spec.md`

Write business requirements only. Describe externally meaningful behavior without prescribing storage, code structure, frameworks, or implementation.

Include these sections:

### Goal

State the business outcome and why the feature exists.

### Actors

List the people, roles, or external systems that interact with the feature.

### User Stories

Describe actor goals in user-centered terms.

### Functional Requirements

Define required behavior with clear, testable statements.

### Non-Functional Requirements

Define relevant quality constraints such as security, reliability, performance, accessibility, or compliance.

### Acceptance Criteria

Define observable conditions that prove the business requirements are satisfied.

Do not put database schemas, implementation details, internal architecture, or code in `spec.md`.

## `api.md`

Define the feature's external API contracts. Keep `api.md` implementation-agnostic.

Include these sections:

### Endpoints

List each operation, method, path, purpose, and relevant authorization expectation.

### Request Schema

Define request fields, types, required or optional status, and externally visible constraints.

### Response Schema

Define success response fields, types, nullability, and response status.

### Validation Rules

Define input and cross-field rules that API consumers must satisfy.

### Error Responses

Define error status, stable error identifiers when applicable, and externally visible conditions.

Do not include handler classes, service methods, database models, framework annotations, or internal call flows.

## `impact-map.md`

Document feature-level dependencies so implementation agents know what to review when the feature changes.

Include these sections:

### Depends On

List features or system capabilities this feature requires.

### Affects

List features, consumers, or workflows that may change when this feature changes.

### Owned APIs

List the API contracts owned by this feature.

### Key Behaviors

Summarize the business behaviors other features rely on.

### Change Impact

Describe the specifications, APIs, dependencies, compatibility concerns, and acceptance criteria that must be reviewed for likely changes.

Keep dependencies at feature level. Do not turn the impact map into a class, package, module, or database dependency graph.

## `dependency-map.md`

Maintain `docs/architecture/dependency-map.md` as a concise, feature-oriented view of high-level system dependencies.

Use only `- ` (dash followed by one space) for each level. Indent nested levels with exactly two spaces. Do not use box-drawing characters.

```text
- Auth
  - independent
- User
  - depends on Auth
- Reservation
  - depends on User
- Notification
  - depends on Reservation
```

Represent actual feature relationships only. Keep implementation components and low-level technical dependencies out of this file.

## Create Workflow

When creating a feature specification:

1. Inspect existing feature specifications and terminology.
2. Read `docs/architecture/dependency-map.md` when it exists.
3. Identify the feature goal, actors, business behavior, API surface, dependencies, affected features, and acceptance criteria.
4. Create `docs/specs/<feature>/spec.md`, `api.md`, and `impact-map.md`.
5. Create or update `docs/architecture/dependency-map.md` with the new high-level relationship.
6. Run the Consistency Checks before completion.

If required business behavior or API intent is ambiguous, ask the user instead of inventing a contract.

## Update Workflow

When modifying an existing feature:

1. Read all four specification files before editing.
   - `docs/specs/<feature>/spec.md`
   - `docs/specs/<feature>/api.md`
   - `docs/specs/<feature>/impact-map.md`
   - `docs/architecture/dependency-map.md`
2. Determine what behavior changes, what contracts change, and what dependencies are affected.
3. Identify downstream features, owned APIs, key behaviors, and acceptance criteria that require review.
4. Update every affected specification file.
5. Preserve unaffected requirements and contracts.
6. Run the Consistency Checks before completion.

Do not update an API contract without reviewing its business requirement and impact map. Do not update a dependency without reviewing both dependency maps.

## Handling Discrepancies

Before editing, compare the current specification against the actual implementation, including code, API behavior, and schemas, when accessible.

If a discrepancy is found that is not caused by the current requested change:

- Do not silently rewrite the specification to match the implementation.
- Do not silently change the implementation to match the specification.
- Report the discrepancy explicitly: identify the file and section, then state what the specification says and what the implementation does.
- Treat the discrepancy as a separate finding from the current task's impact analysis.
- Ask the user which is the source of truth before resolving it, unless the user has given a standing instruction for the repository.

## Impact Analysis

For each proposed change:

1. Map the changed behavior to its Functional Requirements and Acceptance Criteria.
2. Determine whether requests, responses, validation rules, errors, endpoints, or authorization expectations change.
3. Review `Depends On`, `Affects`, `Owned APIs`, and `Key Behaviors`.
4. Trace direct feature relationships in `dependency-map.md`.
5. Record the resulting review obligations under `Change Impact`.

Distinguish confirmed impact from unresolved questions. Stop and ask when uncertainty could materially change the feature contract.

## Consistency Checks

Before completion, verify:

- `spec.md` and `api.md` agree.
- `impact-map.md` reflects current feature dependencies.
- `dependency-map.md` reflects current feature relationships.
- Acceptance criteria remain valid.
- Every owned API is represented in `api.md`.
- Every externally visible API behavior is supported by a business requirement.
- Every dependency change appears in both the feature impact map and the high-level dependency map when applicable.
- No specification contains contradictory terminology, statuses, validation rules, or error behavior.

Never leave specifications out of sync.

## Completion

Report:

- Specifications created or updated
- Behavior and contract changes captured
- Dependency relationships changed
- Impacted features or APIs requiring implementation review
- Remaining unresolved questions, or `none`

Do not claim completion until all four specification files have been reviewed for consistency.
