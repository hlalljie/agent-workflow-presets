---
name: setup
description: Walk through filling in a freshly-copied agent-presets .cursor/ folder. Use once per new project, after copying .cursor/ and docs/ into the repo.
---

# Setup

## When to use

Once per project, right after copying the `agent-presets` contents into a new repository. After this runs, the skill can be deleted from the project — it has no ongoing use.

## Job

Walk the project owner through filling in every `<!-- TODO: -->` marker across `.cursor/` and `docs/`, asking questions as needed, and writing the answers back into the right files. End with a clean, project-specific agent configuration.

## Process

### 1. Survey the project first

Before asking anything, read what the project already has:

- `package.json` — name, framework, runtime versions, scripts
- Top-level folders — what's in `src/`, `tests/`, `docs/`, any others
- Any existing README or architecture docs

You need enough context to make informed suggestions when asking the owner fill-in questions. Do not ask things the codebase already answers.

### 2. Find every TODO

Run:

```bash
grep -rn "TODO:" .cursor/ docs/
```

This is the canonical list of fill-ins. Work through them in this order (dependencies first):

1. `docs/folder-structure.md` — everything else references it
2. `.cursor/rules/repository-layout.mdc` — points at the doc above
3. `.cursor/rules/nextjs.mdc` — or delete if not a Next.js project
4. Any others that appear

### 3. Fill in `docs/folder-structure.md`

This is the most important file. Propose a draft based on the survey in step 1, then confirm with the owner before writing.

For each top-level folder under `src/`, write one bullet explaining what lives there. If the structure is genuinely complex (multiple routes, services, widgets with a shared pattern), include a "read order" guide for the most common "add a new X" task.

If the project is early-stage and the structure is trivial, keep this short. Do not fabricate folders that don't exist yet.

### 4. Fill in `.cursor/rules/repository-layout.mdc`

This rule points at the folder-structure doc plus any domain-specific docs (e.g. `docs/auth.md`, `docs/<domain>/README.md`). It also names the **reference implementation** — the canonical route, module, or component that other features should mirror.

Ask the owner:

1. What domain docs exist or should exist? (list them; it's fine if none yet)
2. What's the reference implementation agents should read before creating new features? (e.g. "the `/home` route" or "the `users` service")

Replace the TODOs with their answers. If the project is too new to have a reference implementation, leave that section with a short note saying so and remove the TODO.

### 5. Fill in or remove stack-specific rules

`.cursor/rules/nextjs.mdc`:

- If Next.js: replace `[VERSION]` with the actual version from `package.json`
- If not Next.js: delete the file

If the project uses a different framework the owner wants version awareness for (e.g. React, Svelte, Django), offer to adapt the Next.js rule to that framework — same shape, different name.

### 6. Clean up the README if it was copied in

If the project already had a `README.md` before the copy, the agent-presets README may have overwritten it. Check git, restore the project's own README, and discard the presets README — it's not meant for the new project.

If the project had no README, the presets README should be replaced with a real project README. Ask the owner for the project's purpose and one-line description, and write that.

### 7. Offer cleanup

At the end, ask the owner if they want to delete `.cursor/skills/setup/` now that setup is done. Most projects should — this skill only runs once.

## Verify

After fill-ins:

```bash
grep -rn "TODO:" .cursor/ docs/
```

Should return nothing (except legitimate in-code TODOs the owner wrote themselves).

Read `docs/folder-structure.md` and `.cursor/rules/repository-layout.mdc` one more time to confirm they make sense together — the rule should point at real content in the doc, and both should describe the same project.

## Rules

- Do not guess project-specific content. Ask the owner.
- Do not invent folders or patterns that aren't in the codebase yet. If the owner plans to add something later, note it inline with `<!-- TODO: -->` and move on.
- Keep fill-ins concise. The agent reads these often — every extra sentence is friction.
- Follow `.cursor/rules/markdown-formatting.mdc` when writing into docs.
