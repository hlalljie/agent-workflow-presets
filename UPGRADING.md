# Upgrading

What existing projects must do by hand when the harness changes. `/blueprint-apply` shows the entries added since a project's locked commit, then the commit subjects since then, before it updates anything.

## How this file works

- Add an entry under **Unreleased** in the same commit that changes harness files (`.cursor/rules/`, `.cursor/skills/`, `docs/`), and only when a project must do or decide something that `/blueprint-apply` cannot do for it:
  - edit a project-owned file, since apply never overwrites those (`repository-layout.mdc`, `nextjs.mdc`, `docs/folder-structure.md`)
  - handle a file that was removed or renamed and may still be referenced
  - opt out of behavior that now acts on its own
  - refresh the machine's copy of the blueprint skills, since changes under `.cursor/skills/blueprint/` are not delivered to projects (point at the install command in the README)
- No entry for new skills, new rules, or wording changes. Apply lists the commit subjects, and git history has the rest. Never write an entry whose action is "none".
- Format: `- <what changed>. Action: <what a project does>.`
- To release: rename **Unreleased** to `v<major>.<minor>.<patch> (YYYY-MM-DD)`, add a new empty **Unreleased** above it, commit, then tag that commit `v<major>.<minor>.<patch>`. Bump major for breaking changes, minor for new rules or skills, patch otherwise.
- Projects do not track versions. They track a commit in `.cursor/blueprints.md`, and the tags are for people.

## Unreleased

- New `issue-labels` skill sets the label standard for issues: one type label (`bug`, `feature`, `chore`, `documentation`, `question`) and an optional priority label (`P0-Critical` to `P3-Low`; none means not prioritized). `plan-issues` creates any missing labels in the repo on its own (needs Write access) and renames GitHub's default `enhancement` label to `feature`. Action: if a repo's workflows or issue templates use `enhancement`, change them to `feature`. The skill arrives with the next `/blueprint-apply workflow=harness@presets`.
- `/blueprint-apply` now lists the catalog's commit subjects since a project's last update, after the entries here. Action: refresh the installed blueprint skills (install command in the README).
- `docs/folder-structure.md` is now the one list of a project's docs (new `documentation.mdc` rule). Action: if `repository-layout.mdc` lists domain docs, move that list into a `docs/` section of `docs/folder-structure.md`.
- `run-task-loop` now creates GitHub issues on its own before starting a phase that has no `Issues:` line (new `plan-issues` skill). Action: add `Issues: none` under the plan title of any plan, or in any project, that should not create issues.
- Harness is now a blueprint part (`parts/workflow/harness`). Action: run `/blueprint-apply workflow=harness@presets` once to adopt it and start receiving updates.

## v0.1.0 (baseline)

- First tracked version. Projects copied by hand before this have no lock line. Action: adopt with `/blueprint-apply workflow=harness@presets`; it compares each file and suggests changes.
