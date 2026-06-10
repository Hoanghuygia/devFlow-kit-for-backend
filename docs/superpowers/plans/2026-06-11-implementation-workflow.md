# Implementation Workflow Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use subagent-driven-development (recommended) or executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the placeholder implementation skill with the approved complexity-aware workflow and verify its contract automatically.

**Architecture:** Keep `skill-router` responsible for classification and routing, while `implementation` owns the low, medium, and high execution paths. Reuse `writing-plan` and `using-git-worktrees` through explicit required-skill references, and add a shell contract test that validates the documentation's required gates without duplicating workflow prose.

**Tech Stack:** Markdown skill documents, Bash contract test, `rg`, Git

---

### Task 1: Add The Implementation Skill Contract Test

**Files:**
- Create: `tests/implementation-skill-contract.sh`
- Test: `tests/implementation-skill-contract.sh`

- [ ] **Step 1: Write the failing contract test**

```bash
#!/usr/bin/env bash
set -euo pipefail

implementation="skills/implementation/skill.md"
router="skills/skill-router/skill.md"

require() {
  local pattern="$1"
  local file="$2"
  local message="$3"

  if ! rg -q --fixed-strings "$pattern" "$file"; then
    printf 'FAIL: %s\n' "$message" >&2
    exit 1
  fi
}

reject() {
  local pattern="$1"
  local file="$2"
  local message="$3"

  if rg -q --fixed-strings "$pattern" "$file"; then
    printf 'FAIL: %s\n' "$message" >&2
    exit 1
  fi
}

require "## Low Complexity" "$implementation" "low-complexity path is missing"
require "## Medium Complexity" "$implementation" "medium-complexity path is missing"
require "## High Complexity" "$implementation" "high-complexity path is missing"
require "Propose 2-3 viable approaches" "$implementation" "high path does not require multiple approaches"
require "User approves the design?" "$implementation" "high path approval gate is missing"
require "Revise and present the design again" "$implementation" "design rejection loop is missing"
require "**REQUIRED SUB-SKILL:** Use \`writing-plan\`" "$implementation" "writing-plan handoff is missing"
require "**REQUIRED SUB-SKILL:** Use \`using-git-worktrees\`" "$implementation" "worktree handoff is missing"
require "Only the high-complexity path invokes \`using-git-worktrees\` by default." "$implementation" "high-only worktree rule is missing"
require "Red-Green-Refactor" "$implementation" "TDD cycle is missing"
require "docs/implementation-notes/YYYY-MM-DD-<feature-name>.md" "$implementation" "implementation-note path is missing"
require "Do not create an empty implementation-note file." "$implementation" "conditional note creation is missing"
require "stop and ask the user" "$implementation" "blocking uncertainty rule is missing"
require "## Verify Before Completion" "$implementation" "verification gate is missing"
require "## Summary Change" "$implementation" "change summary is missing"
require "Route to \`skills/implementation/skill.md\`." "$router" "router implementation handoff is missing"
reject "Placeholder for a future implementation workflow skill." "$implementation" "implementation is still a placeholder"

printf 'PASS: implementation skill contract\n'
```

- [ ] **Step 2: Make the test executable**

Run:

```bash
chmod +x tests/implementation-skill-contract.sh
```

Expected: command exits with status `0`.

- [ ] **Step 3: Run the test and verify RED**

Run:

```bash
./tests/implementation-skill-contract.sh
```

Expected: `FAIL: low-complexity path is missing`.

- [ ] **Step 4: Commit the failing contract test**

```bash
git add tests/implementation-skill-contract.sh
git commit -m "test: define implementation skill contract"
```

### Task 2: Implement The Complexity-Aware Workflow

**Files:**
- Modify: `skills/implementation/skill.md`
- Test: `tests/implementation-skill-contract.sh`

- [ ] **Step 1: Replace the placeholder frontmatter and overview**

Use:

```markdown
---
name: implementation
description: Use when the router selects Implementation Feature for creating or changing product behavior.
---

# Implementation

Carry an implementation task from the router's complexity classification through the required design, specification, planning, implementation, verification, and change summary.

<HARD-GATE>
Use the Complexity already established by `skill-router`. Do not silently reclassify the task or skip a required gate.
</HARD-GATE>
```

- [ ] **Step 2: Add the top-level workflow and complexity flowchart**

Add an overview that states:

```markdown
1. Read the router handoff.
2. Follow exactly one complexity path.
3. Implement with TDD.
4. Update related specs.
5. Record genuine unresolved uncertainty.
6. Verify before completion.
7. Summarize the changes.
```

Add a DOT flowchart with:

- Low -> Implement
- Medium -> Write/Update Spec -> Self-Review -> Invoke Writing Plan -> Implement
- High -> Propose Multiple Approaches -> Present Design -> User Approval loop -> Write/Update Spec -> Self-Review -> Invoke Writing Plan -> Invoke Using Git Worktrees -> Implement
- All paths -> Verify Before Completion -> Summary Change

- [ ] **Step 3: Add the low-complexity path**

Add:

```markdown
## Low Complexity

Proceed directly to implementation when the router classified the task as low complexity.

- Do not require a separate design proposal, written spec, implementation plan, or worktree.
- Follow Red-Green-Refactor.
- Update an existing related spec when behavior or a contract changes.
- Record residual uncertainty only when one exists.
- Verify the work, then write the change summary.
```

- [ ] **Step 4: Add the medium-complexity path**

Add:

```markdown
## Medium Complexity

1. Write or update the feature spec.
2. Self-review the spec.
3. **REQUIRED SUB-SKILL:** Use `writing-plan`.
4. Implement the plan with Red-Green-Refactor.
5. Update related specs when implementation clarifies behavior.
6. Record residual uncertainty only when one exists.
7. Verify the work, then write the change summary.

Do not create a worktree by default for medium complexity.
```

- [ ] **Step 5: Add the high-complexity path and approval loop**

Add:

```markdown
## High Complexity

1. Propose 2-3 viable approaches with trade-offs and a recommendation.
2. Present the design.
3. Ask: User approves the design?
4. If no or changes are requested: Revise and present the design again.
5. Continue only after explicit approval.
6. Write or update the feature spec.
7. Self-review the spec.
8. **REQUIRED SUB-SKILL:** Use `writing-plan`.
9. **REQUIRED SUB-SKILL:** Use `using-git-worktrees`.
10. Implement the plan with Red-Green-Refactor.
11. Update related specs when implementation clarifies behavior.
12. Record residual uncertainty only when one exists.
13. Verify the work, then write the change summary.

Only the high-complexity path invokes `using-git-worktrees` by default.
```

- [ ] **Step 6: Add spec-writing and self-review rules**

Specify:

- Save new specs to `docs/superpowers/specs/YYYY-MM-DD-<feature-name>-design.md` unless the user or repository defines another location.
- Update an existing authoritative spec instead of creating a duplicate.
- Self-review for placeholders, contradictions, ambiguity, and oversized scope.
- Fix self-review findings before invoking `writing-plan`.

- [ ] **Step 7: Add the TDD implementation rules**

Add a `## Implement With TDD` section containing:

```markdown
### Red-Green-Refactor

1. Write one focused failing test.
2. Run it and confirm it fails for the expected missing behavior.
3. Write the minimum implementation needed to pass.
4. Run the focused test and relevant broader tests.
5. Refactor only while tests remain green.
```

State that exceptions require explicit user approval and that implementation must stay within the approved spec and plan.

- [ ] **Step 8: Add implementation-note behavior**

Add a `## Implementation Notes` section containing:

```markdown
When any genuine unresolved uncertainty remains, even a small one, create:

`docs/implementation-notes/YYYY-MM-DD-<feature-name>.md`

Do not create an empty implementation-note file.
```

Require each note to include:

- Uncertain point
- Decision or assumption used
- Possible impact
- Later verification or resolution

State: if uncertainty is blocking, unsafe, or could materially change the outcome, stop and ask the user.

- [ ] **Step 9: Add verification and summary rules**

Add:

```markdown
## Verify Before Completion

Run fresh project-appropriate tests, build, lint, formatting, or documentation contract checks. Read the output and report actual results; inspection alone is not verification.

## Summary Change

State:

- What behavior or files changed
- Which specs or implementation notes changed
- What verification ran and its result
- Any remaining uncertainty or limitation
```

- [ ] **Step 10: Run the contract test**

Run:

```bash
./tests/implementation-skill-contract.sh
```

Expected: `PASS: implementation skill contract`.

- [ ] **Step 11: Commit the implementation skill**

```bash
git add skills/implementation/skill.md
git commit -m "feat: implement complexity-aware workflow"
```

### Task 3: Verify The Router Handoff

**Files:**
- Verify: `skills/skill-router/skill.md`
- Test: `tests/implementation-skill-contract.sh`

- [ ] **Step 1: Preserve the existing router behavior**

Keep the current task analysis, complexity classification, confirmation, and one-workflow selection rules unchanged.

- [ ] **Step 2: Verify the Implementation Feature description**

Confirm the existing router contains:

```markdown
Route to `skills/implementation/skill.md`.
```

Confirm no implementation-specific text describes this workflow as a future placeholder. Do not copy implementation-path logic into the router.

- [ ] **Step 3: Run the contract test**

Run:

```bash
./tests/implementation-skill-contract.sh
```

Expected: `PASS: implementation skill contract`.

- [ ] **Step 4: Confirm the router was not modified by this task**

Run:

```bash
git diff -- skills/skill-router/skill.md
```

Expected: output contains only the user's pre-existing modification; this implementation task adds no router diff.

### Task 4: Verify The Complete Skill Change

**Files:**
- Verify: `skills/implementation/skill.md`
- Verify: `skills/skill-router/skill.md`
- Verify: `tests/implementation-skill-contract.sh`
- Verify: `docs/superpowers/specs/2026-06-11-implementation-workflow-design.md`

- [ ] **Step 1: Run the contract test**

Run:

```bash
./tests/implementation-skill-contract.sh
```

Expected: `PASS: implementation skill contract`.

- [ ] **Step 2: Check Markdown and shell whitespace**

Run:

```bash
git diff --check
```

Expected: no output and exit status `0`.

- [ ] **Step 3: Check the shell script syntax**

Run:

```bash
bash -n tests/implementation-skill-contract.sh
```

Expected: no output and exit status `0`.

- [ ] **Step 4: Verify no placeholder remains**

Run:

```bash
rg -n "Placeholder for a future implementation workflow skill|Not implemented yet" skills/implementation/skill.md
```

Expected: no matches and exit status `1`.

- [ ] **Step 5: Review the final scoped diff**

Run:

```bash
git diff HEAD~2 -- skills/implementation/skill.md skills/skill-router/skill.md tests/implementation-skill-contract.sh docs/superpowers/specs/2026-06-11-implementation-workflow-design.md
```

Expected: changes match the approved spec, and unrelated user changes remain intact.

- [ ] **Step 6: Report implementation notes**

Do not create `docs/implementation-notes/2026-06-11-implementation-workflow.md` unless a genuine unresolved uncertainty remains after verification. If one exists, record the uncertain point, assumption, impact, and follow-up before the final summary.
