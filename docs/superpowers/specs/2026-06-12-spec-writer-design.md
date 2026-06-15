# Spec Writer Skill Design

## Goal

Add a `spec-writer` skill that maintains feature specifications as the source of truth in specification-first repositories.

## Scope

Create one self-contained skill at `skills/spec-writer/skill.md` and one focused contract test at `tests/spec-writer-contract.sh`.

The skill must:

- Create and update `docs/specs/<feature>/spec.md`
- Create and update `docs/specs/<feature>/api.md`
- Create and update `docs/specs/<feature>/impact-map.md`
- Maintain `docs/architecture/dependency-map.md`
- Keep business requirements, API contracts, and dependency information consistent
- Perform impact analysis before completing an update

The skill must not introduce templates, scripts, router changes, or unrelated workflow changes.

## Document Boundaries

`spec.md` contains business requirements only: Goal, Actors, User Stories, Functional Requirements, Non-Functional Requirements, and Acceptance Criteria. It excludes database schemas, implementation details, internal architecture, and code.

`api.md` contains implementation-agnostic API contracts: Endpoints, Request Schema, Response Schema, Validation Rules, and Error Responses.

`impact-map.md` contains feature-level dependency information: Depends On, Affects, Owned APIs, Key Behaviors, and Change Impact.

`dependency-map.md` contains concise, feature-oriented, high-level system dependencies.

## Workflow

For an existing feature, read the three feature specification files and the system dependency map before editing. Determine behavior, contract, and dependency changes, then update every affected specification file as one consistency boundary.

Before completion, verify that `spec.md` and `api.md` agree, both dependency maps reflect current relationships, and acceptance criteria remain valid.

## Verification

The contract test will require the expected paths, headings, update sequence, consistency checks, and `spec.md` prohibitions. It will also enforce the repository start-announcement convention.
