# Spec Writer Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a complete `spec-writer` skill that keeps feature and dependency specifications synchronized.

**Architecture:** Use a self-contained Markdown skill with explicit document boundaries, create/update workflows, impact analysis, and a completion consistency gate. Protect the required contract with one Bash test that follows the repository's existing literal assertion style.

**Tech Stack:** Markdown, Bash, `rg`, repository contract tests

---

### Task 1: Define The Contract

**Files:**
- Create: `tests/spec-writer-contract.sh`
- Test: `tests/spec-writer-contract.sh`

- [ ] **Step 1: Write the failing contract test**

Create a Bash test using `set -euo pipefail`, `require`, and `reject` helpers. Require the skill path, required document sections, update workflow, consistency checks, and prohibited `spec.md` content.

- [ ] **Step 2: Run the contract test to verify it fails**

Run: `rtk bash tests/spec-writer-contract.sh`

Expected: FAIL because `skills/spec-writer/skill.md` does not exist.

### Task 2: Add The Skill

**Files:**
- Create: `skills/spec-writer/skill.md`
- Test: `tests/spec-writer-contract.sh`

- [ ] **Step 1: Write the minimal complete skill**

Add YAML frontmatter, Overview, specification structure, per-file content rules, create/update workflows, impact analysis, consistency checks, and completion rules.

- [ ] **Step 2: Run the focused contract**

Run: `rtk bash tests/spec-writer-contract.sh`

Expected: `PASS: spec-writer skill contract`

### Task 3: Verify Repository Contracts

**Files:**
- Verify: `skills/spec-writer/skill.md`
- Verify: `tests/spec-writer-contract.sh`

- [ ] **Step 1: Run all contract tests**

Run:

```bash
rtk bash tests/skill-router-contract.sh
rtk bash tests/skill-announcement-contract.sh
rtk bash tests/implementation-skill-contract.sh
rtk bash tests/spec-writer-contract.sh
```

Expected: every command prints `PASS`.

- [ ] **Step 2: Check whitespace**

Run: `rtk git diff --check`

Expected: no output and exit status 0.
