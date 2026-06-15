# Project Bootstrap AGENTS-Only Design

## Goal

Keep `project-bootstrap` focused on creating or updating the repository's
`AGENTS.md` file while extending standard `/init` guidance with specification
discovery information.

## Scope

The skill analyzes the repository and preserves useful existing `AGENTS.md`
content. It adds concise guidance that tells agents where feature
specifications and the architecture dependency map are expected to live.

The documented specification structure is:

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

## Discovery Guidance

`AGENTS.md` must explain how to:

1. Identify the feature or domain affected by a task.
2. Find the matching directory under `docs/specs/<feature>/`.
3. Read `spec.md`, `api.md`, and `impact-map.md` when present.
4. Read `docs/architecture/dependency-map.md` for high-level relationships.
5. Report missing specification guidance instead of inventing business rules.

## Boundaries

`project-bootstrap` must not:

- Create or modify files under `docs/specs/`.
- Create or modify `docs/architecture/dependency-map.md`.
- Define an implementation workflow.
- Create implementation plans or direct implementation execution.
- Duplicate the responsibilities of `spec-writer`.

## Verification

A focused Bash contract will require the AGENTS-only scope, specification tree,
discovery rules, and preservation behavior. It will reject spec-file creation
and implementation-workflow guidance. The existing `spec-writer` contract will
continue validating shared paths without requiring bootstrap to create them.
