---
name: testing-run-tests
description: >-
  Run tests in order per test plan: Vitest, smoke scripts, manual browser, build.
  During the loop, dev server is fine for quick manual checks; production build + start
  (preview) before calling work done—verify-commit repeats preview. See skill body.
---

# Run tests

## Job

Execute automated + manual steps **aligned with the test plan** ([add tests](../add-tests/SKILL.md)), without ad-hoc skips unless the plan marks N/A.

**Strong default:** If the diff changes **UI** or **could regress what users see** on a route (shared shell, layout, widgets, styles, client navigation), treat **manual browser** checklists as **expected**, not optional—add or extend **`tests/manual/*.md`** when no checklist exists yet ([write manual browser test](../write-manual-browser-test/SKILL.md)).

## Before running

1. Open the **test plan** — **`### Test plan`** in the task file and/or **`tests/plans/*.md`**.
2. If missing but tests exist, run **`npm test`** and note **plan gap** in the report.

## Dev vs preview (Next.js)

- **`npm run dev`** — Fast iteration; Turbopack, HMR. Good **while building** the slice (including quick manual smoke if the checklist allows a temporary dev URL).
- **`npm run build`** + **`npm run start`** — **production-like** behavior. Anything that can differ between dev and prod (bundling, SSR, env) should be **checked here** before the slice is "done."

**During [run task loop](../../run-task-loop/SKILL.md):** Vitest always; manual steps **may** use dev first for speed, but **before handoff** run the same checklist (or critical path) against **preview** if the doc's Start state uses `start`—otherwise align the doc.

**During [verify commit](../../verify-commit/SKILL.md):** Automated checks already run **`build`**; **manual browser** passes should use **preview** (Start state in the doc), and **spot-check in dev only as extra**, not instead of preview.

## Order (default)

1. **Targeted Vitest** — `npx vitest run <paths…>` for files listed in the plan (fast signal).
2. **Full Vitest** — **`npm test`** when the slice can affect shared code or you need full regression.
3. **Feature smoke** — project-specific regression scripts (see **`package.json`**). Run any that cover the areas you touched.
4. **Manual browser** — each **`tests/manual/*.md`** tied to the plan: [run manual browser test](../run-manual-browser-test/SKILL.md) (Start state, then procedure). For **UI- or shell-related** work, skipping this step is **not** a default win—report **BLOCKED** only when the environment truly prevents it (no server, no browser tool, auth wall).
5. **Build** — **`npm run build`** when verifying types/integration.

Add **`npm run lint`** when the change is style/ESLint-sensitive.

## Report

List **commands run**, **PASS/FAIL**, and any **BLOCKED** manual (with a short reason). If manual was skipped on a UI-touching slice and the environment was not blocking, say that plainly in the report.

**Scope:** This step is **run and report** only. Failing tests or a failed manual pass are reported as **FAIL**; fixing the app or tests happens in a **separate** implementation pass, not inside this skill.

## Called from

[run task loop](../../run-task-loop/SKILL.md), [verify commit](../../verify-commit/SKILL.md), or after [add tests](../add-tests/SKILL.md).
