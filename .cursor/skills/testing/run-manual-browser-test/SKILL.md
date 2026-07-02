---
name: run-manual-browser-test
description: >-
  Execute a tests/manual Markdown checklist with MCP browser: satisfy Start state,
  optional Vitest prerequisite, then follow Procedure. Use for manual regression,
  verify-commit, or run-task-loop validation—not for authoring the doc.
---

# Run manual browser test

## Job

Always spawn a subagent to execute this skill using `[MODEL:browser-tester]`. When running multiple checklists, spawn one subagent per checklist in parallel. Execute **one** **`tests/manual/*.md`** checklist **as written**. Does **not** change application code or the checklist file (unless the procedure says to note results elsewhere).

## Before any browser tool call

1. **Read** the checklist file end-to-end.
2. **Start state** — start server with **exact** env/command from doc; use **entry URL** from doc. **No** improvised production URLs.
3. **Preconditions** — build, fixtures, flags satisfied.
4. **Vitest prerequisite** — if present, run in terminal **first**, confirm success.
5. **MCP browser** — read project/browser tool schemas; **snapshot** before clicks; **fresh snapshot** after navigation; use refs from latest snapshot only.

## Execution

- Walk **Procedure** steps in order; compare to **pass / fail** criteria.
- **Blocked** (no server, login, prod only) → report **BLOCKED**, do not PASS.
- **Done** → report **PASS** or **FAIL** with which step broke.

## Typical callers

[run task loop](../../run-task-loop/SKILL.md), [verify commit](../../verify-commit/SKILL.md), [run tests](../run-tests/SKILL.md), or standalone QA.

## Related

[write manual browser test](../write-manual-browser-test/SKILL.md) for creating/updating the same files.
