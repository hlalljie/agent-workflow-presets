---
name: archive-plan
description: Move a completed plan from .cursor/plans/ to .cursor/plans-archive/ so only active plans stay in the main folder, or restore one. Use when the commit skill finishes a plan's last phase, or when the user asks to archive or restore a plan.
---

# Archive plan

## Where plans live

- Active: `.cursor/plans/<plan-name>/`
- Archived: `.cursor/plans-archive/<plan-name>/`

The whole folder moves, with the same name and contents, so links inside the plan (tasks to `plan.md`, plan to `research/`) keep working. Location is the only state: there is no index and no status field. Moving a plan by hand in either direction is always valid.

## When to use

- The [commit skill](../commit/SKILL.md) finishes a plan's last phase and hands off here.
- The user asks to archive or restore a plan.

## Archive

1. **Pick the plan.** Use the plan the user or the commit skill named. If none was named, list the plans in `.cursor/plans/` whose phases are all complete and ask which.
2. **Check it is complete.** Every `## Phase N:` heading in `plan.md` ends ` — complete`, and the Backlog section is empty or absent. If not, list the open phases and stop, unless the user asked to archive it anyway.
3. **Check the target.** If `.cursor/plans-archive/<plan-name>/` already exists, stop and ask for a different name. Never overwrite or merge.
4. **Find references.** Search the repo, excluding `.git/` and the plan's own folder, for `plans/<plan-name>`, matching the whole name (`foo` must not match `foo-bar`). Also search the other plans for relative links to it (`../<plan-name>/`).
5. **Move.**
   - macOS / Linux: `mkdir -p .cursor/plans-archive && mv .cursor/plans/<plan-name> .cursor/plans-archive/<plan-name>`
   - Windows: `New-Item -ItemType Directory -Force .cursor\plans-archive; Move-Item .cursor\plans\<plan-name> .cursor\plans-archive\<plan-name>`

   Use a plain move, not `git mv`. `git mv` stages the change, and staging belongs to the commit skill ([git-safety.mdc](../../rules/git-safety.mdc)).
6. **Fix references.** In other plans, rewrite a path link to the plan as its name only. For every other hit (docs, code comments, README, tests), do not edit: list `file:line` and say whether to remove the link or move the content it relies on into `docs/`.
7. **Propose the commit** through the [commit skill](../commit/SKILL.md), as its own commit with subject `chore(plans): archive <plan-name>`, never mixed into other work. Stage both `.cursor/plans/<plan-name>` (the removal) and `.cursor/plans-archive/<plan-name>`. Add to the proposal only what needs a decision: unchecked `- [ ]` items still in the plan folder (open questions, tasks, edit logs) and any reference hits from step 6. If the user declines, move the plan back.

## Restore

Check that `.cursor/plans/<plan-name>/` does not exist, then move the folder back the same way. Nothing else needs updating.
