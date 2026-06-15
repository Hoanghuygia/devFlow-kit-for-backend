# Repository Guidelines Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a concise root-level contributor guide tailored to this repository's skill files, Bash contract tests, Git conventions, CodeGraph usage, and RTK command wrapper.

**Architecture:** This documentation-only change adds one standalone Markdown file at the repository root. Verification checks the document contract directly and runs the existing test scripts; no production behavior or test fixtures change.

**Tech Stack:** Markdown, Bash, Git, ripgrep, RTK

---

### Task 1: Create and verify the contributor guide

**Files:**
- Create: `AGENTS.md`
- Reference: `README.md`
- Reference: `tests/skill-router-contract.sh`
- Reference: `tests/skill-announcement-contract.sh`
- Reference: `tests/implementation-skill-contract.sh`

- [ ] **Step 1: Create the guide**

Write `AGENTS.md` with the title `# Repository Guidelines` and these sections:

- `Project Structure & Module Organization`
- `Build, Test, and Development Commands`
- `Coding Style & Naming Conventions`
- `Testing Guidelines`
- `Commit & Pull Request Guidelines`
- `Agent-Specific Instructions`

Document `skills/<name>/skill.md`, `skills/skill-entry/references/`, `tests/`, `docs/`, the three contract-test commands, two-space Bash indentation, lowercase kebab-case skill directories, Conventional Commit prefixes, focused pull requests, CodeGraph-first structural discovery, and the `rtk` shell-command requirement.

- [ ] **Step 2: Validate the document contract**

Run:

```bash
rtk wc -w AGENTS.md
rtk rg -n '^# Repository Guidelines$|^## ' AGENTS.md
rtk git diff --check
```

Expected: the word count is between 200 and 400, all required headings are present, and `git diff --check` reports no errors.

- [ ] **Step 3: Run repository contract tests**

Run:

```bash
rtk bash tests/skill-router-contract.sh
rtk bash tests/skill-announcement-contract.sh
rtk bash tests/implementation-skill-contract.sh
```

Expected: each script prints `PASS`.

- [ ] **Step 4: Review the final diff**

Run:

```bash
rtk git diff -- AGENTS.md
rtk git status --short
```

Expected: `AGENTS.md` contains only repository-specific contributor guidance, while any unrelated existing changes remain untouched.
