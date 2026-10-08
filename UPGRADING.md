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

- Commit subjects now use a Conventional Commits prefix (`type(scope): subject`, scope optional, `harness` scope suggested for rules and skills), and commits that complete an issue include `Closes #N`. Action: none; existing history is not rewritten.
- Harness is now a blueprint part (`parts/workflow/harness`). Action: none for existing projects; run `/blueprint-apply workflow=harness@presets` once to adopt it and start receiving updates.

## v0.1.0 (baseline)

- First tracked version. Projects copied by hand before this have no lock line. Action: adopt with `/blueprint-apply workflow=harness@presets`; it compares each file and suggests changes.
