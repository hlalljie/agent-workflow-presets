---
name: commit
description: Prepare and propose a commit. Use when the user asks to commit, prepare a commit, or similar. Never commits without explicit approval.
---

# Commit

## Process

1. Run `git diff --staged` and `git status` (if nothing staged, note unstaged changes).
2. **Security review** — no secrets, credentials, or env files staged; sensitive paths ignored.
3. **Loose ends** — only if something needs a follow-up. If there are none, **omit** this (do not write "none", do not explain what you are not doing).
3b. **Upgrade notes** — only if `UPGRADING.md` exists at the repo root and the change touches harness files it names: follow its "How this file works" section and include the proposed entry (or "no entry needed") and the file in the proposal. Skip silently in any other repo.
4. **Propose** — commit message, files to stage, `Ready to commit (y/n):`, **stop**. Before printing, check the subject matches `type(scope)?!?: subject` (see "Commit message format"); fix it if not. Do not run `git add` or `git commit`.
5. Wait for explicit approval.
6. Only then run `git add` and `git commit`.

## Starting vs approving

- **`/commit`**, **"prepare a commit"**, **"go ahead and /commit"**, **"run the commit skill"** mean: run steps **1–4** (including the **full proposed commit message** and files to stage), print **`Ready to commit (y/n):`**, then **stop**. That is **not** permission to run `git commit` yet.
- **Approval** is a **separate** message **after** that proposal: e.g. **`y`**, **"yes"**, **"approved"**, or a short edit ("use that message" / tweak subject only). Never treat **"go ahead"** in the **same** message as `/commit` as approval to commit unseen.
- The user must be able to **read the proposed subject and body** before approving.

**Proposal output:** short and scannable. **If** this commit finishes the **last open** task for a plan phase: state that clearly in the proposal to the user **and** in the commit message (subject or bullet); mark that phase complete in `plan.md` (heading and `Completed:` date, per [workflow.mdc](../../rules/workflow.mdc)) in the same commit as the task checkboxes. Make this edit before printing the proposal, so the user approves what will be committed. **If** it does not complete a phase, say nothing about phases — do not list non-events.

This applies no matter how the user phrases it — "commit this", "create a commit", "prepare a commit", "/commit", "go ahead and /commit" all mean **propose first** (steps 1–4), **commit only after** a clear follow-up approval (step 6).

## Commit message format

**Prefix:** Subjects follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/): `type(scope): subject`.

- **Type** (required, lowercase): `feat` (new capability), `fix` (bug fix), `docs` (documentation only), `refactor` (no behavior change), `perf`, `test`, `build`, `ci`, `chore` (maintenance), `revert`. Pick the one that matches the main change.
- **Scope** (optional, a short noun for the area touched): include it when it helps, omit it when it adds nothing. Never required.
- **Breaking change:** add `!` before the colon (`feat(api)!: ...`) and a `BREAKING CHANGE: <what breaks>` footer.
- For harness files (rules, skills, harness docs), use the scope `harness`: `feat(harness):` or `fix(harness):` for behavior changes, `docs(harness):` for docs only.
- The type and scope are not a substitute for the outcome statement below; the text after the colon still states the outcome.

**Subject:** After the prefix, state **what changed for the user or product** (outcome / intent), not a dump of file moves. Someone reading only the subject should understand the change **without** opening the diff.

- Put the **main or motivating change first** (e.g. the feature or bug class readers care about). Secondary work can follow in the same subject (semicolon or second clause) or in the body—not buried as the only mention of a headline item.
- Do **not** make the subject a list of paths or "add file X" unless the path *is* the whole story.
- If the commit has **two substantive themes** (e.g. ported legacy roster **and** added an issues tracker), **both** belong in the subject (compound sentence or semicolon)—do not leave a major theme only in the body.

**Body:** A few bullets on **substance**. Prefer **what it does or fixes** over **how the code is structured**.

- **Avoid** bullets that only list mechanics (`new file X`, `function now does Y`) with no stated benefit. **Use** outcome language first; add a **short "by …"** only when the fix or feature would be unclear without it.
- For **bugfixes**, use **fixed [symptom] by [approach]** (one clause or two short ones).
- Implementation-only detail belongs in the body **after** the outcome, and only if it helps the next reader; it must not be the only content of a bullet.

```
type(scope): short subject describing the outcome

- What it does or fixes
- What it does or fixes

chat: <conversation-uuid>
```

Subject length: **~50 chars is a soft target** (the prefix counts); clarity beats padding or cramming unrelated edits into one vague line.

When the commit finishes a plan phase, add a bullet (e.g. `Completes Phase 2`). Omit that bullet otherwise.

When the work is for a specific issue, add one bullet per issue at the end of the body, before the `chat:` line. The issue is the one the user named, or one in the `Issues:` line of the phase being worked, or of its plan when the phase has none (see [plan-issues](../plan-issues/SKILL.md)).
- `Closes #<number>` only when this commit actually completes that issue. For a plan-level issue, that is the commit that finishes the plan's last phase.
- `Refs #<number>` for partial work on it. GitHub defines only the closing words, so `Refs` is a convention.
- Omit both when no issue is involved.

The UUID links the commit to the chat where it was made. Use this chat's own ID: it is the folder name of **"Current agent's store"** in the session info, and it matches a transcript at `~/.cursor/projects/<project>/agent-transcripts/<uuid>/<uuid>.jsonl`.

If the ID is not in the session info, take the most recently written transcript for **this project** (run from the repo root):
```bash
ls -t ~/.cursor/projects/$(pwd | sed 's|^/||; s|/|-|g')/agent-transcripts/*/*.jsonl | head -1
```

The UUID is the folder name before the file. If another chat in the same project was active recently, confirm the transcript mentions this conversation before using it. Never leave the placeholder in a commit message.

## After committing

- If the commit completes work tracked in a task list, update the task checkboxes in the same commit (see `.cursor/rules/workflow.mdc`).
- If that was the final task for a plan phase, the phase should already be marked complete in `plan.md` (heading and `Completed:` date) in that same commit, and the commit message should state phase completion.
- Delete checked open questions that already existed in git before this commit. Checked questions that are new (never committed) stay — they need to be committed first so there's a record.
- If this commit left a plan finished (every `## Phase N:` heading ` — complete` and the Backlog empty), follow [archive-plan](../archive-plan/SKILL.md) and propose the archive as its own commit through this skill.

## Pull requests

Use the [pr skill](../pr/SKILL.md) for pull requests.
