# Test plan — <slice or phase>

**Where:** `.cursor/plans/**/tasks/*.md` as **`### Test plan`**, or **`tests/plans/<slug>.md`**.

Group by **behavior, risk, or subsystem**—not only by task number. Mark **`[x]`** when done.

## <Coverage area A — e.g. derive / filters>

- [ ] **Unit** — `tests/.../*.test.ts` — <behavior>
- [ ] **Integration / snapshot** — … — <what>
- [ ] **Manual** — `tests/manual/<slug>.md` — <scenario> — or **N/A** + reason

## <Coverage area B — e.g. shell / route>

- [ ] …

## Smoke / regression (whole slice)

- [ ] `npm test`
- [ ] `npm run build`
- [ ] `<optional: npm run test:… from package.json>`

## Notes

- **N/A** — Row does not apply; one-line why.
- **Runner:** [run tests](../run-tests/SKILL.md).
