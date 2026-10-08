---
name: blueprint-apply
description: >-
  Scaffold the current project from blueprint parts (api, database, cache, branding, plan, and so on) taken
  from a catalog or straight from another project, and pull later blueprint updates into it. Use when the user
  says scaffold, apply blueprint, or update from blueprints.
disable-model-invocation: true
---

# Blueprint apply

Bring parts into the current project from a catalog or another project, and later pull updates. Formats, types, sources file, and lock file are in [FORMAT.md](../FORMAT.md). Read it first.

## Input

A scaffold line (or plain words naming the same things), for example `database=postgres-railway@personal, branding=client-x, plan=launch`. With no parts named, update every part in `.cursor/blueprints.md`. `focus: <type>` limits an update to one type.

## Steps

1. **Sources.** Read `~/.blueprints/sources.md`. If it is missing, ask for the catalog path and remote once, then create it.
2. **Resolve each part.**
   - A catalog alias means `parts/<type>/<name>/PART.md` in that catalog. Run `git -C <catalog> pull --ff-only` first; if it fails, continue with the local copy and say so. Clone from the remote if the local path is missing. Read catalog files from `HEAD` (`git -C <catalog> show HEAD:<path>`), not the working tree, so the commit recorded in the lock is exactly what was applied. Mention uncommitted catalog changes if there are any, and ignore them.
   - A project alias or path means extract on demand (step 3).
   - No source given: search catalogs, then project aliases. If nothing or several match, ask.
3. **Extract** (project sources only). Follow "Where to look" in FORMAT.md and build the same fields as a PART.md in memory. Do not write anything into the source project.
4. **Check before touching files.**
   - Every `needs` part is in this run or already in the lock.
   - `touches` overlaps between parts in this run, or with files, packages, or env names already in the project, are listed as collisions with a proposed merge.
   - If the spec assumes a different stack than the project uses (for example Tailwind vs CSS modules), translate it. If you cannot, ask.
5. **Parts already in the lock are updates.** If the catalog has `UPGRADING.md`, first show the entries added since the locked commit (`git -C <catalog> diff <sha> HEAD -- UPGRADING.md`). Catalog parts: `bash <skill-dir>/../scripts/lock.sh changed <catalog> <part> [repo: paths from the part's Files]`; ignore any listed path that the part's `Exclude` covers. Project parts: compare the source's current state to its locked commit with `git -C <project> diff <sha> HEAD`. Then compare the project to the part. Build one numbered list, one line each, and wait for the user's picks before writing anything:
   - **Pull** — the part changed, the project did not. Suggest applying.
   - **Conflict** — both changed. Suggest keep mine, take theirs, or a merged version with the proposed text. For whitelisted files, get the base with `git -C <catalog> show <sha>:<path>` and use `git merge-file -p --diff3`. Never write conflict markers into project files.
   - **Same** — the project already matches the new part. Only the lock needs refreshing; no edit.
   - Nothing changed means "up to date". Skip silently.
   - **No lock line but the target files already exist** (a project copied by hand): there is no base, so compare each file two-way and suggest per file. The lock is recorded when done.
6. **Apply** (new parts, and picked update items).
   - Implement the Spec in the project's own conventions. Read the nearest existing implementation first, as the repo rules require.
   - Copy only whitelisted `Files` (`repo:` entries come from the catalog root; honor `Exclude`). If a target exists, list it as a conflict instead of overwriting.
   - `plan` parts become `.cursor/plans/<name>/plan.md` in the draft-plan format, with no tasks.
   - Packages in `deps`: list them for approval and do not install. Env vars: add names to `.env.example` only; never create `.env` values.
   - Follow the part's `Apply` steps.
7. **Quick check.** Run the project's existing type check or lint if it has one. Do not add tests.
8. **Lock, once, at the end.** For each applied or refreshed part: `bash <skill-dir>/../scripts/lock.sh set <type>/<name> <source> <sha>`, where `<sha>` is `git -C <source dir> rev-parse --short HEAD`. Run it from the project root. Do not touch the lock earlier, and do not commit.

## Judgment

`lock.sh` and `git` only record and list. Adapting a spec to the project, deciding Pull vs Conflict vs Same, merging, and resolving collisions are your call. Read the actual project before deciding. When unsure, ask instead of guessing. Updates never write until the user picks items.

## Reply

- **Done**: one line per part applied, updated, or refreshed.
- **Answers**: what was skipped or translated, one line each.
- **Questions**: collisions, dependencies awaiting approval, and anything unclear, as one numbered list at the end.

Update lists look like this:

```
1. Pull: branding/client-x: new brand color, no project edits, apply
2. Conflict: workflow/default: rules/communication.mdc, both changed, suggest merge (text below)
3. Same: database/postgres-railway: project already matches, refresh lock
```
