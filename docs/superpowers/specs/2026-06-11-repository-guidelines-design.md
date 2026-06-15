# Repository Guidelines Design

## Goal

Create a concise root-level `AGENTS.md` that helps contributors work safely and consistently in this repository.

## Content

The guide will be titled "Repository Guidelines" and remain between 200 and 400 words. It will describe:

- The `skills/<name>/skill.md` organization, supporting references, Bash contract tests, and project documentation.
- The repository's lack of a compiled build step and the exact contract-test commands contributors should run.
- Markdown and Bash conventions already demonstrated by the repository.
- Test placement, naming, and expectations for changes to skill contracts.
- Conventional Commit prefixes observed in Git history and focused pull-request requirements.
- Repository-specific agent rules: use `rtk` for shell commands and prefer CodeGraph for structural discovery.

## Constraints

- Do not invent coverage thresholds, package-manager commands, or lint tools that the repository does not use.
- Keep instructions actionable and specific to existing files and workflows.
- Avoid unrelated repository changes.

## Verification

Check the document's word count, required title and sections, Markdown formatting, and repository command accuracy. Run the existing contract tests to ensure the documentation-only change did not disturb repository behavior.
