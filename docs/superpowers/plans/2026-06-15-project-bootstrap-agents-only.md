# Project Bootstrap AGENTS-Only Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Restrict `project-bootstrap` to creating or updating `AGENTS.md` with specification discovery guidance.

**Architecture:** A focused Bash contract defines the skill boundary. The skill extends standard `/init` output with repository-specific spec navigation but delegates spec creation and maintenance to `spec-writer`.

**Tech Stack:** Markdown skills, Bash contract tests, `rg --fixed-strings`

---

### Task 1: Define The Bootstrap Contract

**Files:**
- Create: `tests/project-bootstrap-contract.sh`
- Modify: `tests/spec-writer-contract.sh`

- [ ] **Step 1: Write the failing contract**

Require the skill to state that it only creates or updates `AGENTS.md`, includes
the four specification paths, explains feature-based discovery, preserves
existing guidance, and reports missing specifications. Reject instructions that
create spec files, dependency maps, or an implementation workflow.

- [ ] **Step 2: Run the contract to verify it fails**

Run: `rtk bash tests/project-bootstrap-contract.sh`

Expected: FAIL because the current skill still creates specification files and
contains an implementation workflow.

- [ ] **Step 3: Remove the obsolete cross-skill creation assertion**

Keep the `spec-writer` contract responsible for validating `spec-writer`.
Remove its loop that requires `project-bootstrap` to create specification files.

### Task 2: Rewrite Project Bootstrap

**Files:**
- Modify: `skills/project-bootstrap/skill.md`

- [ ] **Step 1: Implement the minimal AGENTS-only workflow**

Keep repository analysis and `AGENTS.md` preservation. Add the expected spec
tree and concrete discovery instructions. State that missing specs are reported
and that no spec or dependency-map files are created or modified.

- [ ] **Step 2: Run focused contracts**

Run:

```bash
rtk bash tests/project-bootstrap-contract.sh
rtk bash tests/spec-writer-contract.sh
```

Expected: both commands print `PASS`.

### Task 3: Verify Repository Contracts

**Files:**
- Verify only

- [ ] **Step 1: Run all contract scripts**

Run: `for test in tests/*-contract.sh; do rtk bash "$test"; done`

Expected: every contract prints `PASS`.

- [ ] **Step 2: Check shell syntax and whitespace**

Run:

```bash
rtk bash -n tests/project-bootstrap-contract.sh
rtk git diff --check
```

Expected: both commands exit successfully without output.
