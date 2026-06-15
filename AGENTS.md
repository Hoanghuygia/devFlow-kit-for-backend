# Repository Guidelines

## Project Structure & Module Organization

This repository contains reusable agent workflow skills rather than a compiled application.

- `skills/<name>/skill.md` defines each skill. Use lowercase kebab-case directory names, such as `skill-router` or `database-schema-doc`.
- `skills/skill-entry/references/` contains platform-specific tool guidance.
- `tests/` contains Bash contract tests that validate required skill content and workflow boundaries.
- `docs/superpowers/specs/` and `docs/superpowers/plans/` store approved designs and implementation plans.
- `README.md` summarizes the workflow architecture and available routes.

Keep each change focused on the relevant skill and its contract test. Do not modify unrelated workflow files.

## Build, Test, and Development Commands

There is no compilation or dependency-install step. Prefix shell commands with `rtk` as required by the repository tooling.

```bash
rtk bash tests/skill-router-contract.sh
rtk bash tests/skill-announcement-contract.sh
rtk bash tests/implementation-skill-contract.sh
rtk git diff --check
```

The first three commands validate router behavior, skill announcements, and implementation workflow requirements. The final command detects whitespace errors.

## Coding Style & Naming Conventions

Write concise Markdown with descriptive headings, short paragraphs, and explicit instructions. Preserve existing front matter fields such as `name` and `description`. Use lowercase kebab-case for skill names and paths.

Bash scripts must use `#!/usr/bin/env bash`, `set -euo pipefail`, two-space indentation, quoted variables, and clear failure messages. Prefer `rg --fixed-strings` for literal contract assertions.

## Testing Guidelines

Add or update a contract test whenever a required skill phrase, section, route, or size limit changes. Test files follow the `tests/<area>-contract.sh` naming pattern. Run all contract scripts before submitting changes; this repository does not define a coverage percentage.

## Commit & Pull Request Guidelines

Use Conventional Commit-style subjects found in history: `feat:`, `test:`, `docs:`, or `chore:`. Keep commits narrowly scoped.

Pull requests should explain the changed workflow contract, list verification commands and results, and link the relevant issue or design document. Include screenshots only when a change has a visual artifact.

## Agent-Specific Instructions

Use CodeGraph first for structural discovery, symbol relationships, and impact analysis. Use `rg` for literal text searches. Check `git status` before editing and preserve unrelated user changes.
