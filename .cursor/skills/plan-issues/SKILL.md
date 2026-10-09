---
name: plan-issues
description: Create GitHub issues for a plan or its phases and link them in the plan. Runs on its own when run-task-loop is about to start a phase and neither the phase nor the plan has an Issues line, and when the user asks to create or link issues. An Issues line saying none opts a plan or phase out.
---

# Plan issues

## How plans and issues map

The mapping is loose and many-to-many. A plan can have no issue, one tracking issue, an issue per phase, or a mix. A phase can have zero, one, or several issues, and one issue can cover several phases. Nothing requires one issue per phase.

A plan that is really one issue gets one plan-level issue that covers every phase. Earlier phase commits `Refs` it, and the commit that finishes the plan's last phase `Closes` it.

The plan owns scope, phases, and tasks. The issue is where discussion happens, and its open or closed state is set by the `Closes #N` commit ([commit skill](../commit/SKILL.md)). Do not copy plan status into an issue or issue status into the plan.

Links live in the plan, in an `Issues:` line: under the plan title for plan-level issues, and under a phase heading for phase-level ones (after `Completed:` if that line exists). A plan-level line covers every phase that has no line of its own. Format: `Issues: [#12](https://github.com/<owner>/<repo>/issues/12), [#13](https://github.com/<owner>/<repo>/issues/13)`. The full URL keeps links portable if the tracker changes.

No `Issues:` line means not decided yet. `Issues: none` means decided: no issue. Under the plan title it covers the whole plan, and under a phase heading it covers that phase. Write it when the user says a plan or phase needs no issue; the user can also write it by hand.

## Approval

Creating issues, and the standard labels they need, runs without asking. The project owner gave standing approval for this, and it covers only creating issues and those labels in the current repo, which is the exception to [data-safety.mdc](../../rules/data-safety.mdc) for this skill alone. In `careful` mode, state what will be created and wait for approval, as that mode requires ([careful](../run-task-loop/modes/careful.md)).

## When to use

- [run-task-loop](../run-task-loop/SKILL.md) is about to start a phase, and neither that phase nor the plan has an `Issues:` line.
- The user asks to create or link issues for a plan, a phase, or several phases.

## Process

1. **Pick the scope.** The plan, one phase, or several phases, as the user named them. If none were named:
   - The plan has a single phase (not counting the Backlog), or the user said the plan is one issue: one plan-level issue.
   - Otherwise: one issue for the phase about to start.
   - If the user names an existing issue for the scope, link it and skip creation.
2. **Check the tools.** Run `gh repo view --json nameWithOwner,url`. If it fails (the repo is not on GitHub, or `gh` is not signed in), stop: say so when the user asked for issues, and skip without comment when run-task-loop triggered this.
3. **Check for duplicates.** Confirm the scope has no `Issues:` link already, then search `gh issue list --state all --search "<title words>" --json number,title,url`. If an open issue clearly covers the same outcome, link it instead of creating one. If unsure, create the new issue and mention the possible duplicate in the report.
4. **Draft each issue.**
   - Title: the outcome of the phase or plan, not "Phase 2".
   - Body: one or two sentences on why (the plan's Overview for a plan-level issue), then the "done when" as a checklist if there is one. Name the plan in plain text. Do not link into `.cursor/plans/`, because plans move when they finish ([workflow.mdc](../../rules/workflow.mdc)).
5. **Create.** First follow Setup in [issue-labels](../issue-labels/SKILL.md); it changes nothing when the labels already exist. Then, per issue: `gh issue create --title "<title>" --label "<type>" --body-file -` with the body on standard input, where `<type>` is the type label that fits the work. It prints the new issue's URL.
   - For a parent and sub-issues, `gh issue create --parent <number>` needs gh 2.94.0 or later. Check `gh --version`. If it is older, create the issues without a parent.
6. **Link.** Add or extend the `Issues:` line in `plan.md` with a markdown link per issue: under the plan title for a plan-level issue, under the phase heading for a phase-level one. The edit stays uncommitted; the [commit skill](../commit/SKILL.md) includes it in the next commit.
7. **Report** one line per issue: the link and title, plus any possible duplicate. Then continue the task.

## Rules

- Keep it quick. Issues are for tracking, not research. Run the commands as written, do not look up `gh` docs or flags, and do not spawn subagents for this.
- It happens once per scope. The `Issues:` line written in step 6 stops it from running again: a plan-level line covers every phase, and a phase-level line covers that phase.
- If a command fails, do not retry or investigate. Say so in one line and continue the task. Write nothing, so the next phase start tries again.
- Never edit, close, or comment on existing issues here.
- One owner per fact: do not mirror phase status into the issue or issue text into the plan.
- Follow [commit skill](../commit/SKILL.md) for `Refs #N` and `Closes #N` once issues are linked.
