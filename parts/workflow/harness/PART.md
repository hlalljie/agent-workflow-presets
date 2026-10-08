---
name: workflow/harness
summary: The agent-workflow-presets rules and skills, copied as-is.
needs: []
touches:
  files: [.cursor/rules/, .cursor/skills/]
---

## Spec

The agent harness this repo ships: always-on rules and invocable skills. Projects get them unchanged and update them with `/blueprint-apply`.

## Files

- repo:.cursor/rules/ -> .cursor/rules/
- repo:.cursor/skills/ -> .cursor/skills/

Exclude: `.cursor/rules/repository-layout.mdc`, `.cursor/rules/nextjs.mdc`, `.cursor/skills/setup/`, `.cursor/skills/blueprint/`

## Apply

- **New project (no `.cursor/rules/` yet):** also copy the project-owned starting points: `.cursor/rules/repository-layout.mdc`, `.cursor/rules/nextjs.mdc`, `.cursor/skills/setup/`, and `docs/folder-structure.md` (a template). Then run the setup skill.
- **Never copy those starting points** on updates or when adopting an existing project. The project has filled them in or deleted them (setup deletes itself), and copying would overwrite that work.
- **Adopting a project that was copied by hand:** there is no lock line and no known base. Compare each whitelisted file two-way, suggest per file, and record the lock when done.
- **After any apply:** scan new or changed files for `TODO:` fill-ins and resolve them the way the setup skill does.
- **Read `UPGRADING.md`** entries added since the locked commit before applying, and show them first.

## Gotchas

- The blueprint skills are installed per machine (see the README), so they are excluded from project copies.
