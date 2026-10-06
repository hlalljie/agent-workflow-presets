# careful

Fragile work: the start of a project (setup, scaffolding), databases, production or external data, and delicate edits.

## Rules

- **Interrupts:** ask the moment a decision, access, or risky action comes up. Do not save questions for the end. Research the repo and docs first; ask only what they do not answer. If a subagent reports a decision or risky action, ask the user right away.
- **Real data:** before any write to a database or external service, or any destructive command, state exactly what it will touch and wait for approval. Run a read-only check first ([data-safety.mdc](../../../rules/data-safety.mdc)).
- **Steps:** one change-set at a time. Verify it (relevant test, type check, or read-only probe) before starting the next.
- **Validation:** follow [run tests](../../testing/run-tests/SKILL.md) as written.
## Subagents

When you spawn any subagent, add this to its prompt: "Do not write to production data, a shared database, or an external service, and run no destructive commands, unless this prompt says the user approved that exact action. If you hit a decision or a risky action, stop and report it instead of proceeding."

Everything else follows [run-task-loop](../SKILL.md).
