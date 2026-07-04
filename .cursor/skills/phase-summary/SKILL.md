---
name: phase-summary
description: Produce the deliverables summary at the end of a task loop. Always run before preparing a commit.
---

# Phase Summary

## When to use

At the end of every task loop, before proposing a commit. Never skip.

## Output format

Print in the response (not just in the task file):

**1-2 sentences describing what the phase delivered and why it matters.**

| Check | How tested | Result |
| --- | --- | --- |
| What was verified | unit test / `tsc` / API test / browser MCP / human | PASS / FAIL |

If anything requires human verification, add:

**Owner check (human):**
- [ ] Specific thing to open or confirm

Then print: `Ready to prepare commit proposal (y/n):` and stop.

If owner says y → run the [commit skill](../commit/SKILL.md), which will propose the message and wait for a second approval before committing.

## Rules

- "How tested" must be specific: `unit test`, `tsc --noEmit`, `API test`, `browser MCP`, or `human`. Never leave it vague.
- Keep the table short — one row per meaningful check, not one per file or function.
- If there is no human check needed, omit that section entirely. Do not write "none".
- Also write the summary into the `## Deliverables` section at the bottom of the task file.
