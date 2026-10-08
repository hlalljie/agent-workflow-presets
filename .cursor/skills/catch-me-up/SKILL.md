---
name: catch-me-up
description: Summarize where the user is at in a few lines, mainly from recent chat history, backed by commits, uncommitted changes, plans, and tasks. Use when the user says "catch me up", "what did I just do", "where was I", or invokes this skill. Read-only.
---

# Catch me up

## When to use

When the user comes back to a project, or opens a new chat, and wants to get back on track: what was done most recently and, if it is clear, where they stopped. Read-only: write no file and run no git command that changes anything ([git-safety.mdc](../../rules/git-safety.mdc)).

Only look at what was done recently. Do not look up open issues or PRs to find work. An issue number appears only if a chat or commit names it.

## Gather

Chat history is the main source; the rest confirms it. Skip any source that does not exist, without comment. Stop once the picture is clear. This is a recap, not an audit.

1. **Recent chats.** List the 5 newest transcripts using the folder from the [commit skill](../commit/SKILL.md) (chat ID section):
   ```bash
   ls -t ~/.cursor/projects/<project>/agent-transcripts/*/*.jsonl | head -5
   ```
   Transcripts are large; never open them whole. Skip the current chat. For each chat, get its asks, one truncated line each (the first is the goal):
   ```bash
   jq -r 'select(.role=="user") | .message.content[0].text | gsub("\n";" ") | gsub("</?(timestamp|user_query)>";"") | .[0:140]' <file> | rg -v 'Perform any necessary follow-up'
   ```
   Ignore bare approvals (`y`) when reading them. For the newest chat, and any chat that ended without a commit, also read where it stopped, which is the end of the last assistant message:
   ```bash
   jq -r 'select(.role=="assistant") | .message.content[]? | select(.type=="text") | .text' <file> | tail -n 25
   ```
   Without `jq`, use `rg -o '<user_query>.{0,140}' <file>` for asks and the Read tool on the file's last lines. On Windows, use the Glob and Grep tools.

   A chat whose ID is in no commit's `chat:` trailer ended without a commit: exploration or unfinished work.

2. **Commits and uncommitted work.** From the repo root:
   ```bash
   git status -sb
   git log --all -n 10 --date=short --format='%h|%ad|%D|%s|%(trailers:key=chat,valueonly,separator=)'
   ```
   `-sb` shows uncommitted files and whether the branch is ahead of its remote. `--all` catches work on other branches; `%D` shows which branch a commit is on. Use the `chat:` trailer to match each commit to its chat.

3. **Plans and tasks.** If `.cursor/plans/` exists, follow the layout in [draft-plan](../draft-plan/SKILL.md) and [workflow.mdc](../../rules/workflow.mdc). With several plans, use the one whose files changed most recently.
   - Current phase: the first phase heading in `plan.md` not ending in ` — complete`.
   - Current task: the first `### Task N` in that phase's `tasks/*.md` with an unchecked `- [ ]`. Count done and total tasks.
   - `open-questions.md`: count unchecked `- [ ]` lines.

## Output

Print this and stop. Omit any part that is empty; do not write "none".

```
**Where you are:** 1-2 sentences. The thread of work, what was last finished, what is in progress.

**Recent work** (newest first, 3-5 lines)
- <date> `<hash>` <what it did> ([chat title](uuid))
- <date> chat [title](uuid) — <the ask>, no commit

**Uncommitted:** one line. How many files and what they are.

**Next:** one line. Only when it is clear (see Rules).

**Plan:** <plan>, <phase>, Task N of M done. K open questions.
```

## Rules

- Whole reply is about 12 lines at most. Link to commits and chats; do not quote them.
- Give facts from the sources. Do not guess intent.
- **Next** only when there is no doubt, or when the user was in the middle of something. That means the last chat stopped on an unanswered approval or question, or on work it said was not done (for example unpushed commits), or a half-done task, or the next unchecked task follows a finished one. Say what is pending, in the chat's own terms. If it is not clear, omit **Next**; do not work hard to find one.
- Group commits from the same chat into one line.
- Name each chat with a short title (6 words or fewer) written from its first ask, and cite it as `[title](uuid)`.
- If sources disagree (a task checked but never committed, a chat with no commit and a clean tree), say so in one line.
- Follow [communication.mdc](../../rules/communication.mdc) and [markdown-formatting.mdc](../../rules/markdown-formatting.mdc). No tables.
