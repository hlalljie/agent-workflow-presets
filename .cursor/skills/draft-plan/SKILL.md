---
name: draft-plan
description: Create or update a project plan. Use only when the user explicitly asks to plan or invokes this skill. Never start implementation from this skill.
---

# Draft plan

## When to use

Only when the user explicitly asks to create a plan or invokes this skill. Do not auto-launch into planning. If you think something needs a plan but the user hasn't asked, you can suggest "Would you like to create a plan for this?" but only for large multi-phase efforts.

## What a plan produces

A plan file, and potentially open questions and research docs. **Never code, never create tasks.** Task lists are a separate skill ([create task list](../create-task-list/SKILL.md)) invoked later when the user is ready to work on a phase.

## Process

1. Read relevant context: codebase, conversation history, existing research, existing open questions.
2. If the codebase can answer a question, explore it instead of asking the user.
3. Ask questions to resolve unknowns — one or two at a time, not a wall of questions. Work through the decision tree branch by branch. For each question, provide your recommended answer.
4. Create open questions for anything that needs research or will block work later.
5. For questions that need research, spawn a subagent using `[MODEL:researcher]` following [research skill](../research/SKILL.md).
6. Write the plan only after enough questions are answered to define phases.
7. Present to user for review.

## Plan format

Each phase is self-contained. A reader looking at one phase should find everything relevant to that phase without scrolling elsewhere. Research, open questions, and details are linked or listed under the phase they belong to, not in separate sections at the bottom.

```
# Plan: <name>

## Overview
2-3 sentences on what and why.

## Phase 1: <name>

Short description of what this phase delivers.

- Detail or decision relevant to this phase
- Detail with link to [research](research/some-doc.md) if needed
- Blocked by open question 3

## Phase 2: <name>

Short description.

- Detail
- Detail

## Backlog

Phases that are known but not ready to be worked on yet. Same format as active phases but may have less detail.
```

Details under a phase are not tasks — they are decisions, constraints, or information that will later be translated into tasks when the user is ready to work on that phase. A phase that needs more detail gets it here; a simple phase might just have the short description.

## Workflow (how plans get used over time)

Plans are living docs. As the user works through phases:
1. Before starting a phase, review it for accuracy given any changes since creation.
2. Make edits if needed.
3. Create tasks from the phase using [create task list](../create-task-list/SKILL.md).
4. After completing a phase, the user moves to the next and repeats.

## Rules

- Plans are concise. Each phase description is 1-2 sentences. Details below are bullets, not paragraphs.
- Phases produce a working or verifiable state.
- Plans link to research — they do not duplicate it.
- Plans reference open questions by number.
- Never start implementation. Never create task lists. Never write code.
- If the user gives feedback, update the plan file directly.
- Follow `.cursor/rules/markdown-formatting.mdc`.
