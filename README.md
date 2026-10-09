# agent-workflow-presets

A portable `.cursor/` setup for agent-assisted development. Drop into any project and fill in the project-specific sections.

## What's included

**`.cursor/rules/`** — Always-on behavioral guards for the agent. Cover communication style, task scope, git safety, engineering standards, and more.

**`.cursor/skills/`** — Invocable procedures: planning, task execution, committing, PRs, testing. The agent reads these when you invoke them by name or trigger phrase.

**`docs/folder-structure.md`** — A template for documenting your project's folder layout. This is the most-referenced doc in the system — fill it in first.

## Setup for a new project

1. Get the harness into your project root. Preferred, once the blueprint skills are installed (see **Blueprints** below): run `/blueprint-apply workflow=harness@presets`. It copies the rules and skills, adds the setup starting points, and records the version so the project can update later. Manual fallback: copy `.cursor/` and `docs/`, leaving out `.cursor/skills/blueprint/`.
   - macOS / Linux: `rsync -a --exclude 'skills/blueprint' .cursor/ <project>/.cursor/`
   - Windows: `robocopy .cursor <project>\.cursor /E /XD blueprint`
2. In that project, ask the agent to run the **`setup` skill** (`.cursor/skills/setup/SKILL.md`). It will walk you through every `<!-- TODO: -->` marker, asking questions and writing the answers back into the right files.
3. After setup completes, delete `.cursor/skills/setup/` — it's a one-time bootstrap tool.

For a manual alternative (no agent): `grep -rn "TODO:" .cursor/ docs/` lists every fill-in; work through them in the order the setup skill describes.

## Rules overview

- **`communication.mdc`** — answer before code, address all points, one change-set at a time
- **`task-scope.mdc`** — one plan task per message by default; no scope creep
- **`workflow-mode.mdc`** — keeps the active workflow mode (careful, pair, afk) across long chats
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
- **`run-task-loop`** — drive a task to completion end-to-end; modes `careful`, `pair`, `afk` change how (see `workflow-mode.mdc`)
- **`catch-me-up`** — short summary of where you left off, mainly from recent chats, backed by commits, plans, and tasks; read-only
- **`archive-plan`** — move a finished plan from `.cursor/plans/` to `.cursor/plans-archive/` so only active plans remain, or restore one; the commit skill triggers it after a plan's last phase
- **`plan-issues`** — create GitHub issues for a plan or its phases on its own (`Issues: none` opts out) and link them in the plan with a loose many-to-many mapping
- **`research`** — deep research producing a standalone reference doc
- **`verify-commit`** — pre-commit gate: tests, build, docs freshness, scoped review
- **`testing/add-tests`** — write a test plan and create all test artifacts
- **`testing/run-tests`** — execute tests in plan order
- **`testing/write-manual-browser-test`** — author browser checklists
- **`testing/run-manual-browser-test`** — execute browser checklists with MCP browser
- **`blueprint/apply`** — scaffold a project from parts (api, database, cache, branding, plan) taken from a catalog or another project; pull later updates
- **`blueprint/generate`** — save parts from a project into a catalog; list what in a project is worth pushing back

## Blueprints

The blueprint skills are installed once per machine, not copied into projects. They only run when invoked (`/blueprint-apply`, `/blueprint-generate`). Format and workflow are in `.cursor/skills/blueprint/FORMAT.md`.

Install or update (macOS / Linux):

```bash
mkdir -p ~/.cursor/skills && rsync -a --delete .cursor/skills/blueprint/ ~/.cursor/skills/blueprint/
```

Install or update (Windows PowerShell):

```powershell
Copy-Item -Recurse -Force .cursor\skills\blueprint $HOME\.cursor\skills\
```

Catalogs of saved parts live in separate git repos (one personal, one per client). Register them in `~/.blueprints/sources.md`; the skills create it on first use.

## Updating a project's harness

This repo is itself a catalog: `parts/workflow/harness` lists the rules and skills projects receive. Register it once in `~/.blueprints/sources.md` under Catalogs:

```markdown
- presets: ~/Projects/workflow/agent-workflow-presets | https://github.com/hlalljie/agent-workflow-presets.git
```

Then in any project run `/blueprint-apply workflow=harness@presets` (or `/blueprint-apply` to update every locked part). It shows what [`UPGRADING.md`](UPGRADING.md) says since the project's last update, then suggests per-file changes and conflicts. Projects copied by hand are adopted the same way, with a two-way compare.

## Versioning

Releases are git tags (`v0.1.0`) on this repo. Every harness change adds an `UPGRADING.md` entry when projects need to act; the commit skill prompts for it. Projects track a commit, not a version number.
