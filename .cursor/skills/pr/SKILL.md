---
name: pr
description: Prepare and propose a pull request. Use when the user asks to create a PR, open a PR, or similar. Never opens a PR without explicit approval.
---

# Pull Request

## Process

1. Find last merge: `git log --oneline | grep "Merge pull request"`
2. Get commits being merged: `git log <last-merge-sha>..HEAD --oneline`
3. Base PR title and body **only** on those commits — do not include work from previous PRs.
4. Propose the title and body. Then **stop**.
5. Wait for explicit approval.
6. Only then run `gh pr create`.

## PR body format

```
## Summary
- What changed
- What changed

## Test plan
- [ ] Verification step
- [ ] Verification step
```

## Rules

- Never open a PR without explicit approval.
- If there are uncommitted changes, suggest running `/commit` first.
