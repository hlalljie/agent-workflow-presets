# afk

Long-running work from a detailed plan while the user is away. Ask everything first, then run without stopping.

## Phase 1: preflight (once, before any edits)

1. Read the plan, task file, and `open-questions.md`. Research what the repo and docs can answer.
2. Send one message with three lists:
   - **Questions** the research could not answer.
   - **Permissions needed:** data writes, dependency installs, external services, destructive commands, anything [data-safety.mdc](../../../rules/data-safety.mdc) or [dependency-safety.mdc](../../../rules/dependency-safety.mdc) gates.
   - **Done means:** the test commands and checks that prove completion.
3. Stop and wait for answers. If all three lists are empty, write `Preflight clear` and go to Phase 2.

## Phase 2: run

- **Interrupts:** none. Do not ask questions.
- **Blocked:** anything needing a permission not granted in preflight, or an owner-only decision, is blocked. Add it to a `## Blocked` list in the task file, skip it, and continue with the remaining tasks. Do the same for blockers that subagents report.
- **Order:** work every task in sequence per [run-task-loop](../SKILL.md).
- **Validation:** write tests per [add tests](../../testing/add-tests/SKILL.md). Run the full [run tests](../../testing/run-tests/SKILL.md) order, including manual browser checks on the preview build. On a failure, try up to 3 different fixes, then mark the item blocked.
- **Stop only when** every task is done or every remaining task is blocked.

## Subagents

When you spawn any subagent, add this to its prompt: "Do not ask questions. If something blocks you, finish what you can and list the blocker in your final reply. The user approved in advance: <the permissions approved in preflight, or 'nothing beyond normal development'>."

## Finish

Follow Handoff in [run-task-loop](../SKILL.md). Put the `## Blocked` list in the summary.
