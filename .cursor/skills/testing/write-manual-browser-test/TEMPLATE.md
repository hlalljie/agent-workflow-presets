# <Title — browser behavior under test>

**Checklist ID:** `<project>-<area>-<001>`

## Start state (mandatory)

Incomplete = do not run steps.

- **App:** `<exact command with env, e.g. npm run start>`
- **URL:** `<http://localhost:3000/...>`
- **Agent:** `<server running; fresh navigate; read MCP browser tool schemas before browser_* calls>`

## Preconditions

- `<build, fixtures, accounts, flags>`

## Vitest prerequisite (optional)

Run in terminal **before** browser — **not** part of the checklist steps.

```bash
<npm test || npx vitest run ... || npm run test:...>
```

## Procedure

1. `<step>`
2. `<step>`

## Pass criteria

- `<observable>`

## Fail criteria

- `<specific>`

## Related

- `<tests/*.test.ts as references only>`
