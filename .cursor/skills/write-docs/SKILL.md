---
name: write-docs
description: Decide which docs a change needs and write or update them. Use when run-task-loop reaches its docs step, when verify-commit lists docs to update, when archive-plan places architecture information, or when the user asks to create, update, or audit project docs.
---

# Write docs

Where each kind of information lives is in [documentation.mdc](../../rules/documentation.mdc), which is always on. This skill is the procedure and the templates.

## When to use

- [run-task-loop](../run-task-loop/SKILL.md) reaches its docs step.
- [verify-commit](../verify-commit/SKILL.md) listed "Docs to update".
- [archive-plan](../archive-plan/SKILL.md) has architecture information to place.
- The user asks to create, update, or audit docs.

## What does this change need?

Map what the change did to the doc that covers it. A change that matches none needs no doc update; say nothing about it.

- **Moved, renamed, or deleted files or folders; a new folder** — `docs/folder-structure.md`
- **A decision made or reversed** — `docs/decisions.md`, in the format from [workflow.mdc](../../rules/workflow.mdc). If there is a plan, record it in the plan's `decisions.md` first.
- **A flow, a boundary between parts, a contract, or a constraint changed** — `docs/architecture.md`
- **A deploy, rollback, restore, or other ops step changed** — `docs/runbooks/<task>.md`
- **An env var added, removed, or renamed** — `.env.example`: the name, one comment line, and a placeholder value, never a real one
- **What the project is, its status, or how to run it changed** — `README.md`

## Process

1. **List what the change touched** from `git diff` or the task: files moved or deleted, public names changed, flows or boundaries changed, env vars, ops steps, decisions.
2. **Map each item** with the list above.
3. **Read the doc, then edit it in place.** Replace what changed; do not append a "changes" note. Delete what is no longer true. State current behavior only. Reasons belong in `docs/decisions.md`, not in `architecture.md`.
4. **Create a doc only if its kind does not exist yet.** Use the template for that kind (below), and add it to `docs/folder-structure.md` in the same change. Do not create empty docs.
5. **Fix stale references.** If files, exports, or types moved, were renamed, or were deleted, grep `docs/`, `tests/manual/`, `.cursor/rules/`, and `README.md` for the old paths and names, and fix every hit.
6. **Do not link to plans.** If a plan holds information the docs need, move that information into the doc.

## Templates

- **architecture.md** — [ARCHITECTURE-TEMPLATE.md](ARCHITECTURE-TEMPLATE.md)
- **runbooks/<task>.md** — [RUNBOOK-TEMPLATE.md](RUNBOOK-TEMPLATE.md)
- **README.md** — keep it to this and nothing else:

```markdown
# <Project name>

One or two sentences: what it is and who it is for.

**Status:** <live, in development, or paused>

## Run it

The commands to install, run, test, and build, taken from `package.json` scripts.

## Docs

The map of the code and the docs is in [docs/folder-structure.md](docs/folder-structure.md).
```

## Audit

When the user asks for an audit: read every doc listed in `docs/folder-structure.md`. Check each path, name, env var, and flow it states against the code. Fix what is wrong, delete what is gone, and report what you could not verify.

## Rules

- Each fact lives in one doc. Link instead of copying.
- Never add a new kind of doc. If information fits none of the kinds in [documentation.mdc](../../rules/documentation.mdc), say so in your report.
- A Mermaid diagram only when a flow crosses three or more parts, drawn as a plain flowchart.
- Follow [markdown-formatting.mdc](../../rules/markdown-formatting.mdc).
