---
name: commit
description: Prepare and propose a commit. Use when the user asks to commit, prepare a commit, or similar. Never commits without explicit approval.
---

# Commit

## Process

1. Run `git diff --staged` and `git status` (if nothing staged, note unstaged changes).
2. **Security review** — no secrets, credentials, or env files staged; sensitive paths ignored.
3. **Loose ends** — only if something needs a follow-up. If there are none, **omit** this (do not write "none", do not explain what you are not doing).
4. **Propose** — commit message, files to stage, `Ready to commit (y/n):`, **stop**. Do not run `git add` or `git commit`.
5. Wait for explicit approval.
6. Only then run `git add` and `git commit`.

## Starting vs approving

- **`/commit`**, **"prepare a commit"**, **"go ahead and /commit"**, **"run the commit skill"** mean: run steps **1–4** (including the **full proposed commit message** and files to stage), print **`Ready to commit (y/n):`**, then **stop**. That is **not** permission to run `git commit` yet.
- **Approval** is a **separate** message **after** that proposal: e.g. **`y`**, **"yes"**, **"approved"**, or a short edit ("use that message" / tweak subject only). Never treat **"go ahead"** in the **same** message as `/commit` as approval to commit unseen.
- The user must be able to **read the proposed subject and body** before approving.

**Proposal output:** short and scannable. **If** this commit finishes the **last open** task for a plan phase: state that clearly in the proposal to the user **and** in the commit message (subject or bullet); include updating that phase's `###` line in `plan.md` with ` — complete` (same commit as task checkboxes — see the "Phases" section at the top of that plan). **If** it does not complete a phase, say nothing about phases — do not list non-events.

This applies no matter how the user phrases it — "commit this", "create a commit", "prepare a commit", "/commit", "go ahead and /commit" all mean **propose first** (steps 1–4), **commit only after** a clear follow-up approval (step 6).

## Commit message format

**Subject:** State **what changed for the user or product** (outcome / intent), not a dump of file moves. Someone reading only the subject should understand the change **without** opening the diff.

- Put the **main or motivating change first** (e.g. the feature or bug class readers care about). Secondary work can follow in the same subject (semicolon or second clause) or in the body—not buried as the only mention of a headline item.
- Do **not** make the subject a list of paths or "add file X" unless the path *is* the whole story.
- If the commit has **two substantive themes** (e.g. ported legacy roster **and** added an issues tracker), **both** belong in the subject (compound sentence or semicolon)—do not leave a major theme only in the body.

**Body:** A few bullets on **substance**. Prefer **what it does or fixes** over **how the code is structured**.

- **Avoid** bullets that only list mechanics (`new file X`, `function now does Y`) with no stated benefit. **Use** outcome language first; add a **short "by …"** only when the fix or feature would be unclear without it.
- For **bugfixes**, use **fixed [symptom] by [approach]** (one clause or two short ones).
- Implementation-only detail belongs in the body **after** the outcome, and only if it helps the next reader; it must not be the only content of a bullet.

```
Short subject describing the outcome

- What it does or fixes
- What it does or fixes

chat: <conversation-uuid>
```

Subject length: **~50 chars is a soft target**; clarity beats padding or cramming unrelated edits into one vague line.

When the commit finishes a plan phase, add a bullet (e.g. `Completes Phase 2`). Omit that bullet otherwise.

Get the conversation UUID:
```bash
ls -t ~/.cursor/projects/*/agent-transcripts/ | head -1
```

Note: the path above may need adjusting per project. The UUID links the commit to the chat where it was made.

## After committing

- If the commit completes work tracked in a task list, update the task checkboxes in the same commit (see `.cursor/rules/workflow.mdc`).
- If that was the final task for a plan phase, the phase heading in `plan.md` should already show ` — complete` in that same commit, and the commit message should state phase completion.
- Delete checked open questions that already existed in git before this commit. Checked questions that are new (never committed) stay — they need to be committed first so there's a record.

## Pull requests

Use the [pr skill](../pr/SKILL.md) for pull requests.
