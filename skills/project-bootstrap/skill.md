---
name: project-bootstrap
description: Create or update AGENTS.md with repository guidance and specification discovery instructions. Use when running or extending project initialization for a specification-first repository.
---

# Init Project

## Overview

**Announce at start:** "I'm using the `project-bootstrap` skill to initialize the project guidance."

This skill extends the standard `/init` workflow with specification discovery
guidance. It only creates or updates `AGENTS.md`.

Do not create project specifications, dependency maps, implementation plans, or
implementation workflow instructions.

## Analyze The Repository

Inspect the repository to identify:

- Project purpose and business context
- Major modules, domains, and architectural boundaries
- Build, test, formatting, and validation commands
- Coding and naming conventions
- Existing contributor or agent instructions
- Existing specification and architecture documentation

Read the current `AGENTS.md` before editing it. Preserve useful existing guidance,
project-specific commands, and repository conventions. Resolve
conflicts in favor of verified repository behavior rather than replacing the
file wholesale.

## Create Or Update AGENTS.md

Keep `AGENTS.md` concise and repository-specific. Include the standard `/init`
guidance that applies to the repository, such as:

- Project overview and module organization
- Architecture boundaries
- Build and test commands
- Coding conventions
- Testing expectations
- Repository-specific agent instructions

Add a `Specification System` section that documents the repository's expected
specification layout:

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

Reference the exact paths:

- `docs/specs/<feature>/spec.md`
- `docs/specs/<feature>/api.md`
- `docs/specs/<feature>/impact-map.md`
- `docs/architecture/dependency-map.md`

Do not assume every repository or feature already has these files.

## Specification Discovery Guidance

In the `Specification System` section, instruct future agents to:

1. Identify the feature or domain affected by the task.
2. Find the matching directory under `docs/specs/<feature>/`.
3. Read `spec.md`, `api.md`, and `impact-map.md` when present.
4. Read `docs/architecture/dependency-map.md` when present to understand
   high-level feature relationships.
5. Use repository terminology and avoid creating a second specification for an
   existing feature.
6. Report missing specification guidance instead of assuming undocumented
   behavior.

Explain each file's role:

- `spec.md` contains business requirements and acceptance criteria.
- `api.md` contains external API contracts.
- `impact-map.md` contains feature-level dependencies and change impact.
- `dependency-map.md` contains high-level relationships between features.

Do not invent business rules, API contracts, dependencies, or architecture
decisions.

## Ownership Boundaries

- Do not create or modify files under `docs/specs/`.
- Do not create or modify `docs/architecture/dependency-map.md`.
- Do not add an implementation workflow to `AGENTS.md`.
- Do not describe implementation planning or execution steps.

If specification paths are missing, document their expected location and
availability accurately in `AGENTS.md`. Do not scaffold or populate them.

## Completion

Report:

- Whether `AGENTS.md` was created or updated
- Existing guidance that was preserved
- Specification paths that were discovered
- Missing specification guidance
- Unresolved repository-specific questions, or `none`
