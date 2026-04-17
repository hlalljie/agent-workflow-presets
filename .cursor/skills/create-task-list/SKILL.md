---
name: create-task-list
description: Break a plan phase into a concrete task list. Use when the user wants to start working on a specific phase, or asks to create tasks.
---

# Create task list

## When to use

When a plan phase is ready to be worked on and needs concrete implementation steps.

## Process

1. Read the phase from the plan (the phase description and its details are the source of truth).
2. Read linked research and resolved open questions referenced in the phase.
3. Check conversation for context not yet written down.
4. If information is missing: ask the user for quick things, create an open question if it needs research.
5. Write the task list.

## Format

The phase description from the plan goes at the top for context. Then tasks with optional subtasks.

```
# Tasks: <phase name>

<phase description from plan, copied or paraphrased>

### Task 1: Task name

- [ ] Action item
- [ ] Action item

### Task 2: Task name

- [ ] Action item
- [ ] Action item

### Task 3: Larger task name

- [ ] Subtask a
- [ ] Subtask b
- [ ] Subtask c
```

## Writing good tasks

Each task is a concrete action that can be implemented, tested, and verified in one working session. The person doing the task (human or agent) should be able to see the change visually or run tests against it without a large QA burden.

### Checklist lines (`- [ ]`)

- Start every item with an **imperative** (*Write*, *Add*, *Build*, *Run*, *Verify*, *Get approval*, …). Do not use label-only lines.
- If a human must approve before more work: name **project owner**. Do not use **you** (ambiguous for agents).
- Say workflow/meta **once** at the top of the file when needed; do not repeat the same explanation in every task **Note**.
- Optional **Note** under a task title: slice-only facts (ids, scope). Defer domain specifics to linked product docs or the "write dataflow" step—not long **Note** blocks.

- Testable in isolation: after completing a task you should be able to verify it works without needing other incomplete tasks.
- Easy to verify: either visually checkable or has a small focused test. Avoid tasks where QA requires checking many things at once.
- Easy to fix: if something breaks, the scope is small enough to find and fix quickly.
- One task at a time. Move to next only when current is done and verified. See `workflow.mdc` "Executing tasks" for cadence rules.
- If a phase has low verification burden (e.g. pure setup), add `batchable: true` below the phase description to allow batching. Default is one-at-a-time.

## Subtasks

Only use subtasks when a task is not clear enough on its own or is too large for a single working session. Subtasks break a task into smaller verifiable pieces. If every task needs subtasks, the tasks are probably too coarse.

## Rules

- Link the task file to its **plan phase** (e.g. `plan.md`); do not expect the plan to link back to this file.
- Flat checkbox lists. No nested checkboxes — hierarchy comes from Task numbering and subtask labels.
- Order by dependency where possible.
- If a task depends on an unresolved open question, note inline and skip.
- Do not over-implement or add scaffolding for future needs.
- Mark `[x]` immediately after completing, not at end of session.
- Task checkbox updates go in the same commit as the work they track.
- Do not create tasks for blocked items — note the blocker in the phase.

## When tasks complete

See `.cursor/rules/workflow.mdc`.
