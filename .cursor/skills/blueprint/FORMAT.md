# Blueprint format

Shared by [blueprint-generate](generate/SKILL.md) and [blueprint-apply](apply/SKILL.md). Read only the sections you need.

## Terms

- **Part** — one concern, one folder: `<type>/<name>` (for example `database/postgres-railway`). Parts mix freely across sources.
- **Catalog** — a git repo of saved parts. Split catalogs by permission boundary: one personal, one per client.
- **Project source** — any local project parts can be extracted from on demand, without saving them first.
- **Scaffold line** — what the user types: `type=name[@source]` items, for example `database=postgres-railway@personal, branding=client-x, cache=redis@~/Projects/old-app`. Plain words that name the same things are fine.

## Types

- Stack: `frontend`, `backend`, `database`, `cache`, `api`, `deploy`, `tooling` (lint, format, tests, CI).
- Other: `branding`, `workflow`, `feature`, `plan`.

Add a new type only when none fits, and ask first.

## Sources file

`~/.blueprints/sources.md`, per machine, not in any project. Created on first use.

```markdown
# Blueprint sources

## Catalogs
- personal: ~/Projects/blueprints | git@github.com:<user>/blueprints.git
- client-x: ~/Projects/client-x-blueprints | git@github.com:<user>/client-x-blueprints.git

## Projects
- client-x-site: ~/Projects/client-x-site | branding, auth, api-stripe
```

Catalog lines are `alias: local path | git remote`. Project lines are `alias: local path | what it is good a source for`. A source named in a scaffold line is a catalog alias, a project alias, or a path.

## Catalog layout

```
parts/<type>/<name>/PART.md
parts/<type>/<name>/files/...      (only when files are copied as-is)
README.md                          (5 lines: what this is, the layout, "see blueprint FORMAT.md")
```

## PART.md

Short. A part is a spec plus a whitelist, not a code dump.

```markdown
---
name: database/postgres-railway
summary: Postgres on Railway with Prisma and reversible migrations.
needs: [deploy/railway]
touches:
  env: [DATABASE_URL]
  deps: [prisma, "@prisma/client"]
  files: [prisma/schema.prisma, .env.example]
---

## Spec
Decisions and patterns to reproduce, in the fewest words that work.

## Files
- files/db.ts -> src/lib/db.ts

## Apply
Only steps that are not obvious from the spec.

## Gotchas
Things that broke before.
```

- **`needs`** — parts that must be present. **`touches`** — env var names, packages, and files the part changes. Apply uses it to find collisions between parts.
- **Files** is a whitelist. Only listed files are copied or tracked. Everything else in the project is ignored by sync.
- **Branding** uses fixed `## Spec` headings so every branding part reads the same: Colors, Type, Shape and spacing, Logo and assets, Voice, Components. It is a spec to translate into the target project's CSS or Tailwind. Nothing is copied.

## Lock file

`.cursor/blueprints.md` in each project. One line per applied part, written only by `scripts/lock.sh` at the end of an apply run. Never edit it by hand, and never touch it mid-work.

```markdown
- branding/client-x | client-x | a1b2c3d | 2026-10-08
- database/postgres-railway | personal | 9f8e7d6 | 2026-10-08
- cache/redis | project:~/Projects/old-app | 4c5d6e7 | 2026-10-08
```

Fields: part, source (catalog alias, or `project:<path>`), the source's short commit, date. The commit is the blueprint's version, not the project's, so editing the project never changes this file. Everything else (what changed, what drifted) comes from git history in the source.

Script: `bash scripts/lock.sh set <part> <source> <sha>`, `get <part>`, `list`, `changed <catalog-dir> <part>`. Run it from the project root. `changed` lists files in `parts/<part>` that differ between the locked commit and the catalog's `HEAD`; empty output means unchanged.

## Where to look when extracting

- `frontend` — framework and version, routing and layout shape, component library, data fetching, `package.json` scripts.
- `backend` — framework, route and handler pattern, validation, error shape, auth middleware.
- `database` — ORM or driver, schema and migration tool, connection setup, seeding, env var names.
- `cache` — client library, key naming, TTL and invalidation pattern, env var names.
- `api` — client wrapper, auth method, retry and error handling, webhooks, env var names.
- `deploy` — platform config files, build and start commands, env var names, CI workflows.
- `tooling` — lint, format, type check, and test config; scripts; git hooks.
- `branding` — theme and CSS variables, fonts, logo and asset files, tone of the copy, how components look.
- `workflow` — an explicit list of `.cursor/` rules, skills, and docs templates. Never `skills/blueprint`, `skills/setup`, or files setup fills in per project.
- `feature` — the routes, components, and services of one feature, and the data it needs.
- `plan` — one plan's `plan.md` with project names stripped.

## Never include

- Values from `.env*`, keys, tokens, passwords, customer data. Env var names only.
- Client names, domains, or assets in the personal catalog. Those belong in that client's catalog.
- Large binaries. A logo is fine in a client catalog.
