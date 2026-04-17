---
name: verify-commit
description: >-
  Pre-commit gate: test plan order or npm test + build + lint; manual browser on
  preview, not dev-only; scoped review. PASS/FAIL only—no commit or fixes.
---

# Verify commit

## Role

**Check only.** Prefer **[run tests](../testing/run-tests/SKILL.md)** when a **test plan** or **`tests/plans/*.md`** exists so command order matches the slice. Otherwise: **`npm test`**, **`npm run build`**, **`npm run test:…`** / **`npm run lint`** from **`package.json`**. **Manual:** [run manual browser test](../testing/run-manual-browser-test/SKILL.md). **Does not** fix code or **`git commit`**.

The **invoker** (e.g. [run task loop](../run-task-loop/SKILL.md)) runs [commit skill](../commit/SKILL.md) after **PASS**.

## Scope

- **Files:** `git diff` / `git status` since last commit or user-named paths.
- **Manual:** Matching **`tests/manual/*.md`** per plan or diff. **Run with Start state that uses production build + `start`** so verification matches ship shape; **dev-only is insufficient** unless the checklist explicitly documents dev and you also pass preview for the same paths. Blocked env → report **browser not run (blocked)**.

## 1. Automated + manual

- If test plan present → follow [run tests](../testing/run-tests/SKILL.md) then ensure **`npm run build`** (and lint if needed).
- Else → **`npm test`**, **`npm run build`**, relevant **`npm run test:…`** / **`npm run lint`**.

## 2. Docs freshness

If the diff moved, renamed, or deleted files/exports/types: grep `docs/`, `tests/manual/`, `.cursor/rules/` for stale paths. **FAIL** if any active doc references a path or symbol that no longer exists. Key docs to check: **`docs/folder-structure.md`** and **`.cursor/rules/repository-layout.mdc`**, plus any domain docs listed there. Skip when the diff only changed logic without touching file paths or public names.

## 3. Scoped review (changed code only)

Light fit-in-repo pass.

- **Layer**, **surface**, **duplication** ([check-shared-before-scoped.mdc](../../rules/check-shared-before-scoped.mdc)), **tests**, **noise**; optional **`Task`** **`explore`** on large diffs.

## 4. Report

**PASS** / **FAIL** with failures and must-fix items. **Stop** — no [commit skill](../commit/SKILL.md) here.

## Not in scope

Full architecture overhaul, PR/CI, **`npm install`** without [dependency-safety.mdc](../../rules/dependency-safety.mdc).
