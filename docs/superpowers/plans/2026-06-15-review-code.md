# Review Code Implementation Plan

> **Execution owner:** Return this plan to the `implementation` workflow for task-by-task execution. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the `code-review` placeholder with a specification-aware `review-code` skill and enforce its workflow with contract tests.

**Architecture:** Keep the skill self-contained in one Markdown file. Use one focused Bash contract for the review workflow and update the existing implementation contract so medium- and high-complexity implementation routes invoke the renamed skill.

**Tech Stack:** Markdown skills, Bash contract tests, `rg --fixed-strings`

---

### Task 1: Add The Review Code Contract

**Files:**
- Create: `tests/review-code-contract.sh`

- [ ] **Step 1: Write the failing contract**

Create a Bash contract using `set -euo pipefail`, a `require` helper, and
`rg --fixed-strings`. Require the approved skill name, announcement, spec hard
gate, diff line ranges, discrepancy rule, existing-code reuse search, read-only
boundary, and all report headings.

- [ ] **Step 2: Run the contract to verify it fails**

Run: `rtk bash tests/review-code-contract.sh`

Expected: FAIL because `skills/review-code/skill.md` does not exist.

### Task 2: Implement The Review Code Skill

**Files:**
- Create: `skills/review-code/skill.md`
- Delete: `skills/code-review/skill.md`

- [ ] **Step 1: Create the skill**

Use the approved `review-code` frontmatter and preserve these required
behaviors: current-diff scope, complete feature-spec reads before review,
spec/code discrepancy reporting, correctness and security checks, existing
logic reuse searches, two or three useful style suggestions, and read-only
output.

- [ ] **Step 2: Remove the old skill**

Delete `skills/code-review/skill.md` after its relevant current-diff and
evidence standards have been retained in `review-code`.

- [ ] **Step 3: Run focused contracts**

Run:

```bash
rtk bash tests/review-code-contract.sh
rtk bash tests/skill-announcement-contract.sh
```

Expected: both print `PASS`.

### Task 3: Update The Implementation Handoff

**Files:**
- Modify: `skills/implementation/skill.md`
- Modify: `tests/implementation-skill-contract.sh`

- [ ] **Step 1: Update the contract first**

Replace the old skill path and required `code-review` phrases with
`review-code`. Reject stale `code-review` references and require that the old
placeholder file no longer exists.

- [ ] **Step 2: Run the contract to verify it fails**

Run: `rtk bash tests/implementation-skill-contract.sh`

Expected: FAIL because `skills/implementation/skill.md` still references
`code-review`.

- [ ] **Step 3: Update the implementation workflow**

Replace `code-review` with `review-code`, remove placeholder-unavailable
instructions, and retain the ordering after verification and before Summary
Change.

- [ ] **Step 4: Run the contract to verify it passes**

Run: `rtk bash tests/implementation-skill-contract.sh`

Expected: `PASS: implementation skill contract`.

### Task 4: Verify The Repository

**Files:**
- Verify only

- [ ] **Step 1: Run all contract scripts**

Run:

```bash
for test in tests/*-contract.sh; do
  rtk bash "$test"
done
```

Expected: every contract prints `PASS`.

- [ ] **Step 2: Run syntax and whitespace checks**

Run:

```bash
for test in tests/*-contract.sh; do
  rtk bash -n "$test"
done
rtk git diff --check
```

Expected: all commands exit successfully with no whitespace errors.

- [ ] **Step 3: Inspect final scope**

Run: `rtk git status --short`

Expected: review-code files and documentation are changed; unrelated existing
changes remain untouched.
