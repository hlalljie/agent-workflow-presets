# Folder structure

<!-- TODO: Fill in this file for your project. This is the most-referenced doc in the agent system.
  Rules and skills that check it: repository-layout.mdc, research-before-suggesting.mdc,
  conservative-file-creation.mdc, run-task-loop, add-tests.

  Describe every meaningful folder from the repository root. Be specific about what lives where
  and why. Agents use this to know where to read before creating anything new.
-->

Paths from **repository root** (directory with `package.json`).

## `src/` — Application

<!-- TODO: Describe your src/ structure. Example shape below — replace with your actual layout. -->

- **`src/app/`** — Next.js App Router. Routes, pages, API handlers.
- **`src/components/`** — UI components. Shared shell, layout primitives, feature widgets.
- **`src/lib/`** — External API clients and queries.
- **`src/services/`** — Server-side data pipelines (fetch + transform).
- **`src/utils/`** — Internal pure utilities.

## Tests

<!-- TODO: Describe your test folder layout. -->

- **`tests/`** — All test files. Mirror `src/` structure for unit/integration tests.
- **`tests/manual/`** — Manual browser checklists (Markdown).
- **`tests/plans/`** — Standalone test plans when no task file exists.

## Other top-level folders

<!-- TODO: Add entries for data/, mocks/, docs/, legacy/, etc. as they exist in your project. -->

## Adding a new [feature type — e.g. route, widget, service]

<!-- TODO: Write a short read-order guide for your most common "add a new X" task.
  This is what agents read before creating anything in that area.
  Example:
    1. src/app/<route>/page.tsx — RSC entry
    2. src/services/<route>/fetch.ts — parallel IO
    3. src/services/<route>/prepare.ts — transforms
    4. src/components/widgets/<route>/client-root.tsx — client shell
    5. src/components/widgets/<route>/derive.ts — filter projection
-->
