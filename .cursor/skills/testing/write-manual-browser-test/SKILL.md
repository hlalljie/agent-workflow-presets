---
name: write-manual-browser-test
description: >-
  Author or update Markdown browser checklists under tests/manual using TEMPLATE.md.
  Use when UI, shell, or MCP-only paths need a human/agent procedure—not for Vitest.
---

# Write manual browser test

## Job

Create or revise **`tests/manual/<area>-<slug>.md`** so an agent or human can **run** the same flow later via [run manual browser test](../run-manual-browser-test/SKILL.md).

Automated tests live in **`tests/*.test.ts`**. This skill is **only** the browser checklist doc.

## Steps

1. Copy **[TEMPLATE.md](TEMPLATE.md)** if new file.
2. **Start state** — exact server command + env, URL, agent notes. Incomplete = invalid.
3. **Procedure** — numbered steps; **pass / fail** observable.
4. Optional **Vitest prerequisite** — shell to run **before** browser (not part of browser steps).
5. Add a bullet under **`tests/manual/README.md`** if new **area**.

## Naming

**`tests/manual/<area>-<short-slug>.md`**

## Called from

[run task loop](../../run-task-loop/SKILL.md), [verify commit](../../verify-commit/SKILL.md), [add tests](../add-tests/SKILL.md).
