---
name: testing-add-tests
description: >-
  Plan and add tests for a feature or fix: choose unit, integration, snapshot, smoke,
  or manual; where artifacts live; how to write them.
---

# Add tests

## Job

Write a **test plan** and **create every artifact** it names — Vitest files, snapshot/integration specs, smoke notes, and **`tests/manual/*.md`** when the change is visible to users. Mark each item **`[x]`** when that artifact exists. [run tests](../run-tests/SKILL.md) *executes* what you listed here; this skill *authors* the plan and the tests.

## Step 1 — Write the test plan

Think through the **full, finished change** — not just the current task — and decide what needs to be verified: behavior, edge cases, regressions, and anything a user would see in the browser. Some of those things need unit tests, some need integration or snapshot coverage, some only need a manual browser walkthrough, and some need nothing at all. Choose which categories apply — many things benefit from **more than one** (e.g. a derive function gets a unit test *and* the route using it gets a manual browser pass). Skip or mark **N/A** where a category genuinely does not apply.

Write this as a **`### Test plan`** checklist in the task file (**`.cursor/plans/**/tasks/*.md`**), or in **`tests/plans/<slug>.md`** if there is no task file yet. Each row should name a concrete artifact: a file path under **`tests/`**, a **`tests/manual/*.md`** doc, or a smoke/build command. Use [TEST-PLAN-TEMPLATE.md](TEST-PLAN-TEMPLATE.md) as a starting shape. Leave every item unchecked; you will **`[x]`** them as you finish Steps 2 and 3.

## Step 2 — Implement automated tests

Create or update the unit, integration, snapshot, and smoke files the plan names, in the right places under **`tests/`**. See **Reference** below for naming conventions, suffixes, folder structure, and which category fits which kind of code. **`[x]`** each plan row when its file exists.

## Step 3 — Author manual browser tests

If the change touches what users see — routes, components, shell, layout, charts, filters, navigation — the plan should already have a **`tests/manual/*.md`** row from Step 1. Author that file following [write manual browser test](../write-manual-browser-test/SKILL.md) and its **TEMPLATE.md**, then **`[x]`** the row. Running the checklist in a browser happens later inside [run tests](../run-tests/SKILL.md), not here.

---

## Reference: test categories

**Unit** — Fast, isolated logic; mocks for I/O. **Suffix:** `.test.ts`. **Where:** mirror source path under `tests/` (e.g. `src/utils/format.ts` → `tests/utils/format.test.ts`). **Run:** `vitest run <path>`.

**Integration** — Crosses module boundaries (transform chains, fetch+transform via MSW). **Suffix:** `.integration.test.ts`. **Where:** same mirrored path. MSW in `mocks/handlers.ts`, fixtures `json-data/`.

**Snapshot** — `expect(…).toMatchSnapshot()` for stable serializations. **Suffix:** `.snapshot.test.ts`. Vitest writes `__snapshots__/` co-located with the test file.

**Smoke** — Coarse end-to-end (full pipeline or build). **Suffix:** `.smoke.test.ts`. Also: `npm test`, `npm run build`, project-specific regression scripts in `package.json`.

**Manual browser** — `tests/manual/*.md`. Authored in Step 3.

## Reference: choosing (heuristic)

Test folder layout and naming conventions: **`docs/folder-structure.md` → Tests**.

- **Pure transform / small utility** → unit test mirroring its source path.
- **Transform chain (unwrap → transform → parse)** → integration test in `tests/services/transforms/`.
- **Pipeline (fetch → prepare → derive)** → snapshot or smoke in `tests/<route>/`.
- **UI shell, filters, charts, client navigation** → manual checklist in `tests/manual/`.

## Reference: writing Vitest

- Match style and helpers in the same `tests/<layer>/` folder and `tests/helpers/`.
- Prefer `describe` / `it` names that read as behavior.
