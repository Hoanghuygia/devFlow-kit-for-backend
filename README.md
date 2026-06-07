# devFlow-kit-for-backend
memory, retrieval, tool use, orchestration, verification, governance, -> execution layer

Resoning + Memory + Context + Skills + Orchestration + Governance

Memory -> Trustworthy memory
Skill routing -> dispatch true skills and verify

Harness design 

Skill = Instruction cho agent

## Skill Workflow Architecture

The skill system now routes work through:

Explore Context -> Task Analysis -> Clarify Questions, if needed -> Confirm Understanding -> Workflow Selection -> Execute Workflow

`skills/skill-entry/skill.md` is the entry point. It activates the workflow system and hands off to `skills/skill-router/skill.md`.

`skills/skill-router/skill.md` is the orchestrator. It analyzes Task Type, Intent, Complexity, Risk, and Missing Information before selecting one workflow.

Workflow placeholders live under:

- `skills/direct-answer/`
- `skills/brainstorm/`
- `skills/writing-plan/`
- `skills/review/`
- `skills/implementation/`
- `skills/research/`
