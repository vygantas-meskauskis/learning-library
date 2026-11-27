# Cold-start test

[Back to the toolkit](README.md)

Ask a brand-new agent session these questions, with no help, from the repository alone (chapter 3). One point per correct answer. Anything below full marks is a context bug: fix the file, not the question.

```bash
claude -p "Answer from this repository only, in one line each:
1. What is the one architectural rule?
2. Which commands must pass before a PR is ready?
3. Which folders or files may you never change without a human?
4. If a feature would send user data to a server, what do you do?
5. Where do colour values come from?
6. What is a 'Line' in BusyHamster?" --output-format text
```

## Answer key for BusyHamster

| # | A correct answer mentions |
|---|---|
| 1 | React (web/) shows things, .NET (api/) does things; no tokens, secrets, database access or business rules in the frontend |
| 2 | `npm run check` and `npm run build` in web/; `dotnet test` if api/ changed |
| 3 | `.github/`, `.claude/`, `scripts/`, `infra/`, `PRODUCT.md`, `docs/adr/`, storage files, existing tests |
| 4 | Only if the user signed in and turned on sync; otherwise stop and say so (Principle 3, ADR 0002) |
| 5 | The tokens in `globals.css`; never hard-coded hex values (DESIGN.md) |
| 6 | One step of a task; every pomodoro belongs to the current line |

## When to run it

- After every change to an AGENTS.md file
- After structural changes (a new folder, a new framework, a removed app)
- In every weekly factory review (chapter 12)
- In every other agent tool your contributors use (chapter 13)
