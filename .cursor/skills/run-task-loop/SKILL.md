---
name: run-task-loop
description: >-
  Drive work to completion: blockers, task list, add-tests (plan + test artifacts),
  application code, run-tests, validate, verify-commit.
  Skills chain via cross-links by design; flatten later if navigation hurts.
  Owner sees blockers or finished work—not perpetual oversight.
  Modes: careful, pair, afk (see Modes); no mode = default.
---

# Run task loop

## Goal

Finish the work with **strong coverage**, without owner involvement until **done**, **blocked**, or **out of credible fixes**.

## Modes

The active mode is set by the user and tracked by [workflow-mode.mdc](../../rules/workflow-mode.mdc). Read the mode file and follow it; where it conflicts with this file, the mode file wins.

- **default** (no mode): this file as written. Interrupt only for **Stop only for** items. Test moderately: follow [run tests](../testing/run-tests/SKILL.md), full suite only when shared code is touched. Validate before handing off.
- **[careful](modes/careful.md):** ask immediately, small verified steps, approval before touching real data.
- **[pair](modes/pair.md):** fast high-volume edits with an edit log and light checks while the user reviews live.
- **[afk](modes/afk.md):** ask everything up front, then run unattended until done or blocked.

**Doc shape:** This skill points at other skills (add-tests, run-tests, verify-commit) instead of inlining every instruction—**modular by choice**; if that becomes hard to follow, a future option is one consolidated runbook.

## Stop only for

- **Blocker** — decision, access, ambiguity, or rule that forbids proceeding ([dependency-safety.mdc](../../rules/dependency-safety.mdc), [data-safety.mdc](../../rules/data-safety.mdc), …).
- **Owner-only** items in **`open-questions.md`**, plan, or tasks.
- **No viable path** after reasonable retries.

Otherwise keep going.

## First action: blockers

1. Scan conversation, plan, **`open-questions.md`**, tasks for owner-only items.
2. If blocking → list and **stop**; else proceed.

## Issues

If there is a plan, and neither the phase about to start nor the plan (an `Issues:` line under its title) has an `Issues:` line, create the issue with [plan issues](../plan-issues/SKILL.md) before starting. A plan-level line covers every phase without its own, so a plan that is one issue is handled once. It runs without asking, once (the line it writes stops repeats), and stays quick. Skip without comment when the repo has no GitHub remote or `gh` is not signed in.

## Task list (always a step)

The task file may **already exist** or **not yet**—either way, **this step runs**:

- If there is no task file for the current scope: create one with [create task list](../create-task-list/SKILL.md) under **`.cursor/plans/**/tasks/*.md`**.
- If it exists: open it and work from **`### Task N`** in sequence.

Do not skip this step; scope and checkboxes live there.

## Task cadence

**Overrides** default one-task-per-message in [task-scope.mdc](../../rules/task-scope.mdc): in **this** invocation, implement **Task 1, 2, 3… in order** until the feature is **done**, you hit **Stop only for**, or **Handoff**—not only the first task.

## Build loop

0. **Codebase survey (MANDATORY before any code)** — Before writing **any** file or editing **any** component, **read the existing codebase** for the area you are touching:
   - Read **`docs/folder-structure.md`** for the canonical map of what lives where.
   - Read **`docs/decisions.md`** if it exists. Do not contradict a listed decision without saying so.
   - Read **`docs/architecture.md`** if it exists, for the parts, flows, and constraints your change must respect.
   - Read the **reference implementation** identified in **`.cursor/rules/repository-layout.mdc`** — the closest existing route, module, or component of the same type as what you're building.
   - Read any **shared primitives** (layout, shell, utilities) relevant to the task before creating new ones.
   - **Match the patterns you find.** Do not invent new folder names, new structural conventions, or new abstraction layers unless the task explicitly requires it and you explain why.
   - **This step is not optional and cannot be skipped for speed.** Producing code that doesn't match existing structure creates more rework than doing it right.

1. **Add tests (plan + artifacts)** — Follow [add tests](../testing/add-tests/SKILL.md): write the test plan, implement automated tests, author manual browser tests. *(You may alternate with step **2** while building; both must be done before **Run tests**.)*

2. **Implement application code** — The **feature or fix** under **`src/`** (app, components, lib, services, actions)—**not** test-only files. Minimal change; correct layer; no drive-by refactors.

3. **Run tests** — [run tests](../testing/run-tests/SKILL.md) against the plan. Loop failures or hit **Stop only for**.

4. **Update docs** — After code is stable and tests pass: follow [write-docs](../write-docs/SKILL.md) for what the task changed, and update the docs yourself. Do not leave them for [verify commit](../verify-commit/SKILL.md) to find. Skip silently when the task needs no doc update.

5. **Task checkboxes** — Update **`### Task N`** in the task file when work completes ([workflow.mdc](../../rules/workflow.mdc)).

Spawn subagents for all implementation and exploration work. Subagent models follow [agent-models.mdc](../../rules/agent-models.mdc).

## Constraints

[dependency-safety.mdc](../../rules/dependency-safety.mdc), [engineering-standards.mdc](../../rules/engineering-standards.mdc). **[task-scope.mdc](../../rules/task-scope.mdc)** applies except **Task cadence** above. **No** **`git add` / `git commit`**.

## Handoff

1. **READ and follow [phase-summary](../phase-summary/SKILL.md)** — open the skill file, use its exact output format, then stop. Do not infer the format from memory.
2. If owner says **y** → run [verify commit](../verify-commit/SKILL.md) spawned as a subagent. If it lists **Docs to update**, update them with [write-docs](../write-docs/SKILL.md) first. Then the [commit skill](../commit/SKILL.md) (**propose**; owner approves).
3. If owner says **n** → ask what needs to change before committing.

**run-task-loop** = delivery + task + add-tests + app + run-tests; **verify-commit** = pre-commit gate; **commit** = git.
