# Upgrading

What existing projects must do when the harness changes. `/blueprint-apply` shows the entries added since a project's locked commit before it updates anything.

## How this file works

- Add an entry under **Unreleased** in the same commit that changes harness files (`.cursor/rules/`, `.cursor/skills/`, `docs/`).
- Write an entry only when a project must act or behavior visibly changes: a rename, a removed file, a new rule that needs project input, a changed workflow. Wording tweaks and internal fixes need none.
- Changes under `.cursor/skills/blueprint/` are not delivered to projects. If one needs the machine's copy refreshed, say so in the entry and point at the install command in the README.
- Format: `- <what changed>. Action: <what a project does, or "none">.`
- To release: rename **Unreleased** to `v<major>.<minor>.<patch> (YYYY-MM-DD)`, add a new empty **Unreleased** above it, commit, then tag that commit `v<major>.<minor>.<patch>`. Bump major for breaking changes, minor for new rules or skills, patch otherwise.
- Projects do not track versions. They track a commit in `.cursor/blueprints.md`, and the tags are for people.

## Unreleased

- New `plan-issues` skill creates GitHub issues for a plan or its phases and links them in an `Issues:` line in the plan or under a phase heading. `run-task-loop` now runs it by itself, without asking, before starting a phase when neither the phase nor the plan has an `Issues:` line (a line under the plan title covers every phase, so a plan that is one issue gets one; skipped when the repo has no GitHub remote or `gh` is not signed in; `careful` mode still asks first). Commits now use `Refs #N` for partial work on an issue as well as `Closes #N`. Action: this writes to GitHub on its own, so for plans or projects that should not create issues, add `Issues: none` under the plan title. The skill arrives with the next `/blueprint-apply workflow=harness@presets`. Sub-issues need `gh` 2.94.0 or later.
- Completed plan phases now get a `Completed: YYYY-MM-DD` line under the heading, and archiving a plan adds the hash of the commit that finished each phase. Action: none; it arrives with the next `/blueprint-apply workflow=harness@presets`. Phases completed earlier have no date line; add one by hand if you want it.
- New `archive-plan` skill moves a finished plan from `.cursor/plans/` to `.cursor/plans-archive/`, and the commit skill triggers it after a plan's last phase. Phase headings now end with ` — complete` when done, agents check the archive when a plan path is missing, and nothing outside `.cursor/plans/` should link to a plan. Action: none; it arrives with the next `/blueprint-apply workflow=harness@presets`. To archive plans you already finished, run `mv .cursor/plans/<name> .cursor/plans-archive/<name>` and fix any links into them.
- New `catch-me-up` skill summarizes where you left off, mainly from recent chats, backed by commits, plans, and tasks. Action: none; it arrives with the next `/blueprint-apply workflow=harness@presets`.
- Commit subjects now use a Conventional Commits prefix (`type(scope): subject`, scope optional, `harness` scope suggested for rules and skills), and commits that complete an issue include `Closes #N`. Action: none; existing history is not rewritten.
- Harness is now a blueprint part (`parts/workflow/harness`). Action: none for existing projects; run `/blueprint-apply workflow=harness@presets` once to adopt it and start receiving updates.

## v0.1.0 (baseline)

- First tracked version. Projects copied by hand before this have no lock line. Action: adopt with `/blueprint-apply workflow=harness@presets`; it compares each file and suggests changes.
