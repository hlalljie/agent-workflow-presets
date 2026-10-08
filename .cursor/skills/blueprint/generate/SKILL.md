---
name: blueprint-generate
description: >-
  Save parts of a project into a blueprint catalog, update existing parts, or list what in the current project
  is worth pushing back to blueprints. Use when the user says generate blueprint, save as blueprint, promote,
  or update blueprints.
disable-model-invocation: true
---

# Blueprint generate

Turn what a project already does into catalog parts, and keep those parts current. Formats, types, sources file, and lock file are in [FORMAT.md](../FORMAT.md). Read it first. Applying parts to a project is [blueprint-apply](../apply/SKILL.md), not this skill.

## Input

`[<type>[/<name>]] [from <project>] [to <catalog alias>] [focus: <type>]`. Default source is the current project. Naming a part means Save. Naming no part means Report.

## Save (create or update one part)

1. **Sources.** Read `~/.blueprints/sources.md` (create it by asking, if missing).
2. **Catalog.** Use `to`. Otherwise pick by permission: anything naming a client, using client assets, or shaped by a private API goes to that client's catalog; anything generic goes to the personal one. If unclear, ask.
3. **Scope.** If the request is too broad to be one part (for example "the stack"), ask which types, and for a type like `frontend` or `deploy`, which pieces. One part is one concern.
4. **Extract** with "Where to look" in FORMAT.md. Record decisions and patterns in the fewest words that work. Whitelist only the files that must be copied as-is. Apply "Never include" strictly, and scan what you wrote for key-like strings before saving.
5. **Write** `parts/<type>/<name>/PART.md` and `files/` in the catalog's working tree. If the catalog is empty, also add the short `README.md` from FORMAT.md. If the part already exists, show what changes as a numbered list first and write only the picked items.
6. **Stop.** Do not commit. Tell the user to commit in the catalog repo. Afterward, running `/blueprint-apply <type>=<name>` in the project records the lock, since the project already matches.

## Judgment

`lock.sh` and `git` only list changes. What counts as a part, what is worth pushing, and generic vs repo-specific are your call, and every label is a suggestion for the user to overrule. Read the actual files before labeling. When unsure, ask.

## Report (no part named)

Compare the current project against every part in `.cursor/blueprints.md`, and scan for things worth adding. Show everything unless `focus` narrows it to one type. Output only this, one numbered line each, most important first, at most about 15 lines (then "and N more"):

- **Push** — the project differs from the part inside its whitelist. Suggest updating the part.
- **Pull** — the part changed upstream since the locked commit (`lock.sh changed`). Suggest `/blueprint-apply`.
- **Conflict** — both changed. Suggest which side wins.
- **Maybe add, generic** — something of a known type that no part covers (a new skill or rule, a new theme token, a config file). Looks reusable.
- **Maybe add, repo-specific** — same, but it names this project's domain, ids, or paths. Probably stays here; listed so nothing is missed.

```
1. Push: workflow/default: rules/task-scope.mdc reworded
2. Maybe add, generic: new skill .cursor/skills/qa-doc, workflow
3. Maybe add, repo-specific: src/lib/shipping.ts, feature, names this store's carriers
```

The user replies with numbers (for example "1,2 push; 3 skip"). Push and Maybe add items are then written as in Save steps 4 to 6. Report never edits project files.
