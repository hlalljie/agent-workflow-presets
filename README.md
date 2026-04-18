# agent-workflow-presets

A portable `.cursor/` setup for agent-assisted development. Drop into any project and fill in the project-specific sections.

## What's included

**`.cursor/rules/`** — Always-on behavioral guards for the agent. Cover communication style, task scope, git safety, engineering standards, and more.

**`.cursor/skills/`** — Invocable procedures: planning, task execution, committing, PRs, testing. The agent reads these when you invoke them by name or trigger phrase.

**`docs/folder-structure.md`** — A template for documenting your project's folder layout. This is the most-referenced doc in the system — fill it in first.

## Setup for a new project

1. Copy `.cursor/` and `docs/` into your project root.
2. In that project, ask the agent to run the **`setup` skill** (`.cursor/skills/setup/SKILL.md`). It will walk you through every `<!-- TODO: -->` marker, asking questions and writing the answers back into the right files.
3. After setup completes, delete `.cursor/skills/setup/` — it's a one-time bootstrap tool.

For a manual alternative (no agent): `grep -rn "TODO:" .cursor/ docs/` lists every fill-in; work through them in the order the setup skill describes.

## Rules overview

- **`communication.mdc`** — answer before code, address all points, one change-set at a time
- **`task-scope.mdc`** — one plan task per message by default; no scope creep
- **`workflow.mdc`** — open questions, decisions, plan format conventions
- **`engineering-standards.mdc`** — show options, security defaults, think through failure modes
- **`dependency-safety.mdc`** — research before proposing, approval gate before install
- **`git-safety.mdc`** — never run git commands directly; use commit/pr skills
- **`data-safety.mdc`** — no destructive operations without explicit permission
- **`research-before-suggesting.mdc`** — verify APIs exist; read the codebase before creating
- **`conservative-file-creation.mdc`** — check before creating; prefer less code
- **`check-shared-before-scoped.mdc`** — check shared code before scoped overrides
- **`repository-layout.mdc`** — canonical map of repo folders (fill in per project)
- **`markdown-formatting.mdc`** — editor-readable markdown conventions
- **`shell-environment.mdc`** — zsh on macOS, PowerShell on Windows
- **`code-documentation.mdc`** — document why, not what
- **`nextjs.mdc`** — Next.js version awareness (fill in version or remove)

## Skills overview

- **`setup`** — one-time bootstrap for a newly-copied preset; delete after running
- **`commit`** — propose + approve flow; never commits without explicit approval
- **`pr`** — propose + approve flow for pull requests
- **`draft-plan`** — create phase-level project plans
- **`create-task-list`** — break a plan phase into concrete tasks
- **`run-task-loop`** — drive a task to completion end-to-end
- **`research`** — deep research producing a standalone reference doc
- **`verify-commit`** — pre-commit gate: tests, build, docs freshness, scoped review
- **`testing/add-tests`** — write a test plan and create all test artifacts
- **`testing/run-tests`** — execute tests in plan order
- **`testing/write-manual-browser-test`** — author browser checklists
- **`testing/run-manual-browser-test`** — execute browser checklists with MCP browser
