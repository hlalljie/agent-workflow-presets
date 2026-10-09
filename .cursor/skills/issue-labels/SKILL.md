---
name: issue-labels
description: The label standard for GitHub issues (one type label, an optional priority label) and how to set it up and apply it. Use when creating issues, when the user asks to set up or change labels, or when plan-issues finds labels missing.
---

# Issue labels

## The standard

Every issue has one type label. It has a priority label only when the user has set one; no priority label means not prioritized yet.

**Type** (one per issue; matches the commit types `fix`, `feat`, `chore` or `refactor`, `docs`):
- `bug`: Something isn't working. `d73a4a` (GitHub default).
- `feature`: New capability or improvement to existing behavior. `a2eeef` (GitHub's `enhancement`, renamed).
- `chore`: Maintenance with no user-facing change, such as refactors, dependencies, and CI. `c5def5`.
- `documentation`: Improvements or additions to documentation. `0075ca` (GitHub default).
- `question`: Further information is requested. `d876e3` (GitHub default).

**Priority** (at most one per issue; to change it, replace the label):
- `P0-Critical`: Broken or security, drop everything. `e11d21`.
- `P1-High`: Next up. `eb6420`.
- `P2-Medium`: Soon. `fbca04`.
- `P3-Low`: Nice to have. `009800`.

GitHub's other default labels (`duplicate`, `good first issue`, `help wanted`, `invalid`, `wontfix`) stay as they are. Use labels, not GitHub issue types: types exist only on organization repos, and `gh issue create --type` creates the issue before it can fail.

## Setup (once per repo)

Needs Write access or higher. It runs without asking when [plan-issues](../plan-issues/SKILL.md) triggers it or the user asks for it. In `careful` mode, state what will be created and wait for approval.

1. Run `gh repo view --json viewerPermission --jq .viewerPermission`. If it is not `WRITE`, `MAINTAIN`, or `ADMIN`, skip setup, say so in one line, and continue without labels.
2. Run `gh label list --limit 1000 --json name`. Compare names case-insensitively.
3. If `enhancement` exists and `feature` does not: `gh label edit enhancement --name feature --description "New capability or improvement to existing behavior"`.
4. For every other standard label that is missing: `gh label create "<name>" --color <hex> --description "<description>"`.
5. Never use `--force`, never delete a label, and leave labels outside the standard alone. Once the labels exist, running setup again changes nothing.
6. Report only what was created or renamed, in one line.

## Applying

- Give each issue you create one type label with `--label "<type>"`: the one that fits the work, `feature` if unsure. Add a priority label only when the user named one.
- To change a priority: `gh issue edit <number> --remove-label "<old>" --add-label "<new>"`.
- `gh issue create --label` fails when the label does not exist, so run setup first if any standard label is missing.
- Applying labels needs Triage access or higher. If a label command fails, do not retry: say so in one line and continue.
