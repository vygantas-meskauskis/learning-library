# BusyHamster

A focus timer that remembers where your head was. Read PRODUCT.md before
changing behaviour, DESIGN.md before changing UI. Folder-level AGENTS.md files
in web/, api/ and infra/ add rules for those folders.

## The one rule

React shows things, .NET does things. The frontend (web/) renders pages and
calls /api. It never stores secrets or tokens, never talks to the database,
and holds no business rules beyond input validation. The backend (api/) owns
login, data and logic.

## Product rules that are not negotiable

These come from PRODUCT.md "Product Principles". If a task would break one,
stop and say so in the PR or issue instead of working around it.

1. Resuming must stay one key. Never add steps to the resume path.
2. Local first: every feature works signed out, with data in the browser.
   Sync is optional and additive (docs/adr/0002-accounts-and-sync.md).
   Nothing leaves the browser unless the user signed in and turned sync on.
3. Export is always available, signed in or not.
4. Keyboard first: every new action gets a shortcut and a command-menu entry.
5. Stay out of the way: no pop-ups, badges or sounds the user didn't ask for.

## Map

| Folder | What | Read first |
|---|---|---|
| web/ | React Router 8 app, pre-rendered to static files | web/AGENTS.md, DESIGN.md |
| api/ | ASP.NET Core (.NET 10): BFF (sign-in) and API | api/AGENTS.md |
| infra/ | Bicep for Azure | infra/AGENTS.md |
| docs/specs/ | One spec per feature | The spec for your issue |
| docs/adr/ | Architecture decisions | Any ADR the spec links to |
| scripts/ | Factory scripts (risk tiers, review) | Don't change (see below) |

## Commands

| Task | Command | Folder |
|---|---|---|
| Install | npm ci | web/ |
| Lint, types, unit tests | npm run check | web/ |
| Build (must work offline after npm ci) | npm run build | web/ |
| Smoke tests against a URL | BASE_URL=<url> npm run test:smoke | web/ |
| API build | dotnet build | api/ |
| API tests (needs Docker) | dotnet test | api/ |
| Regenerate the API contract | dotnet build, then npm run api:types in web/ | api/, web/ |

Run `npm run check` (and `dotnet test` if you touched api/) before you say
you're done.

## Definition of done

- Every acceptance criterion in the spec has a test or a named manual check.
- New code in web/app/lib/ or api/src/ has unit tests next to it.
- `npm run check` and `npm run build` pass; `dotnet test` passes if api/ changed.
- If behaviour changed, the spec in docs/specs/ is updated in the same PR.
- If structure changed (new folder, new command, new convention), this file
  or the folder's AGENTS.md is updated in the same PR.
- The PR fills in .github/pull_request_template.md, including
  "Things a human should look at".

## Never touch without a human

- .github/**, .claude/**, scripts/**
- infra/** (tier 2: a human reviews every change)
- PRODUCT.md and docs/adr/** (decisions are made by a human)
- Storage keys and formats: web/app/lib/storage.ts, the backup format in
  web/app/lib/history.ts
- Any existing test: fix the code, not the test. If a test is wrong, say why
  in the PR description and leave it failing.

If you need one of these changed, describe the change in the PR description.

## Language

| Word | Means |
|---|---|
| Task | What you're working on; a list of lines. One active task at a time |
| Line | One step of a task. Every pomodoro belongs to the current line |
| Pomodoro | One completed focus phase |
| Resume card | What / shows when you come back to an unfinished task |
| Focus screen | The / route: the line input, the timer, the current task |
| History | Finished tasks, at /history |
