# Risk tiers

[Back to the toolkit](README.md)

A risk tier is a promise about how much human attention a change gets, decided by what it can break. CI computes it from the changed files with [`scripts/risk-tier.sh`](scripts/risk-tier.sh), labels the PR `tier:0`, `tier:1` or `tier:2`, and the required `tier-gate` check enforces the merge rule. The highest tier of any changed file wins. Chapter 9 explains the design.

## The tiers

| Tier | What can break | Paths and changes | Merge rule |
|---|---|---|---|
| **0** | Nothing users depend on | `*.md` outside `docs/adr/` and `docs/specs/`; new test files only; `content/blog/**` | Auto-merge when every required check passes (agent PRs) |
| **1** | What users see, recoverable in one revert | `web/app/**` routes, components and logic; new API endpoints that don't touch auth, data access or migrations; additive changes to `api/openapi.json`; `docs/specs/**` | A maintainer approves after the evidence review (chapter 8) |
| **2** | Data, trust, money, or the factory itself | `.github/**`, `.claude/**`, `scripts/**`, `infra/**`, `PRODUCT.md`, `docs/adr/**`; `api/**/Auth/**`, `api/**/Data/**`, `api/**/Migrations/**`; `web/app/lib/storage.ts`, `history.ts`, `sync.ts`; `web/app/styles/globals.css`, `web/app/routes.ts`; any dependency change; any change to or deletion of an existing test; breaking changes to `api/openapi.json` | A maintainer reads the full diff, approves, and adds `tier-2-reviewed`; infrastructure deploys also need a `production-infra` approval |

## Why some entries are where they are

| Entry | Tier | Reason |
|---|---|---|
| Existing tests | 2 | Changing an expectation is a behaviour decision; it's also the cheapest way to fake a green build |
| Dependencies | 2 | New code from strangers in your build and your users' browsers |
| `.github/`, `.claude/`, `scripts/` | 2 | The gates live there; weakening a gate must be the most visible change of all |
| `globals.css`, `routes.ts` | 2 | Wide blast radius: one line changes every screen or every route |
| Storage files | 2 | Users' data lives only in their browsers; a renamed key deletes it |
| Specs | 1 | They change behaviour by changing what the agent builds |

## Reviewing by tier

| Tier | Your review | Time |
|---|---|---|
| 0 | None; spot-check one a week in the factory review | 0 |
| 1 | Checks green → reviewer findings → screenshots or preview → flagged files and files not in the plan → "Things a human should look at" | 5 to 10 min |
| 2 | Everything for tier 1, then the full diff with the checklist below | 20 to 60 min |

## Tier 2 checklist: auth and data

| Check | Look for |
|---|---|
| Every endpoint is authorised | `RequireAuthorization()` on the `/api` group; `AllowAnonymous` only on `/api/auth/*` and `/api/flags` |
| Users only see their own rows | Every query filters by the user ID from the claims, never from the request |
| State-changing requests need the custom header | Antiforgery middleware for `POST`, `PUT`, `DELETE` |
| No tokens or personal data in logs | User IDs only; no request bodies |
| Deletion really deletes | `DELETE /api/account` removes everything; a test proves it |
| Nothing new leaves the server or the browser | No new outbound calls; no third-party scripts |
| Cookie settings unchanged | `HttpOnly`, `Secure`, `SameSite`, `__Host-` prefix |
| Migrations only expand | No drops, renames or narrowing in the same change that stops using the old shape |

## Tier 2 checklist: the factory

| Check | Look for |
|---|---|
| Gates not weakened | No removed steps, `continue-on-error`, skipped tests, lowered caps |
| Permissions not widened | Workflow `permissions:`, Claude Code `allow` rules, sandbox domains |
| Secrets not exposed | No new `secrets.*` in jobs that agents or PRs can trigger; no `environment:` added to PR workflows |
| Tier rules not loosened | `risk-tier.sh` patterns: anything moved to a lower tier |

## With a team (chapter 13)

- Use `CODEOWNERS` so tier 2 areas route to the right reviewer.
- Require one approval in the ruleset for everyone; the tier gate adds the `tier-2-reviewed` label for tier 2.
- Revisit the wide-blast-radius list whenever someone new joins: newcomers can't feel what a token change does.
