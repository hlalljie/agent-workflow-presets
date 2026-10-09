# pair

Fast, high-volume edits (mostly frontend) where the user sends loose instructions and reviews live in the dev server or a preview. You act as designer, developer, and QA at once. Expect many rounds.

## Edit log

- One file per topic: `.cursor/plans/<plan-name>/edits/<topic>.md`. Name the topic `phase-N` when the edits belong to a plan phase, otherwise the area (for example `footer`). If no plan applies, use `.cursor/edits/<topic>.md`. Reuse the same file for the whole chat; open another file only when the topic or plan changes.
- Each user message with edits starts a new `## Round N` heading in the file. Round numbers continue across the chat.
- Split each message into separate items. Write each as one concise line: what, where, and any value the user gave. Keep the user's specifics and "never" constraints word for word.
- Format: `- [ ] N. <edit>`. Add `[phase N]` at the start when the edit relates to a plan phase, and leave it off when it does not. Numbers are permanent across rounds: never renumber or reuse.
- When an edit changes a value (size, color, spacing), record `old -> new` in the item. Read the old value before changing it.
- After applying an item, append ` - done`. Only the user ticks `[x]`. Never tick it yourself.
- If an instruction is ambiguous, pick the most likely reading, apply it, and note the assumption in the item.

## Rules

- **Interrupts:** do not ask questions mid-round. Unresolved calls go in the reply as one short line each.
- **Edits:** make them yourself, not through subagents. They depend on what the user said earlier in the chat, which a subagent does not have.
- **Validation:** fast checks only: type check or lint on touched files, and confirm the page still builds and renders. No browser tests during rounds. No new test files unless the user asks; if asked, follow [add tests](../../testing/add-tests/SKILL.md).
- **Server:** start or restart the dev server yourself. If the user asks for a frozen version, build and start the preview yourself and give the URL. Never ask the user to do either.
- **Reply:** only the item numbers applied and any open calls. The detail lives in the edit log.
- **End of session:** when all items are `[x]` or the user says done, run [run tests](../../testing/run-tests/SKILL.md) for the touched areas once, then follow Handoff in [run-task-loop](../SKILL.md).

## Subagents

Add nothing to subagent prompts. Subagents that run at end of session ([run tests](../../testing/run-tests/SKILL.md), [verify commit](../../verify-commit/SKILL.md)) work as those skills say.

Task list, test plan, and docs steps from [run-task-loop](../SKILL.md) are skipped until the end of session. The issues step is skipped.
