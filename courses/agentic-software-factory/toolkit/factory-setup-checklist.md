# Factory setup checklist

[Back to the toolkit](README.md)

The whole course as checkboxes, in rollout order. Copy it into an issue in your own repository and tick it off.

## Week 1: context and gates (chapters 1 to 4)

- [ ] Factory log started: last 10 changes, where the time went (ch. 1)
- [ ] Seven stages drawn with owners; labels created (ch. 2)
- [ ] Cold-start test run; score written down (ch. 3)
- [ ] Root AGENTS.md: one rule, product rules, commands, definition of done, never-touch list (ch. 3)
- [ ] First ADR written (ch. 3)
- [ ] `typecheck` and `check` scripts (ch. 4)
- [ ] Build works without network after install, or the domains are documented (ch. 4)
- [ ] `ci.yml` running on every PR (ch. 4)
- [ ] Ruleset on `main`: PRs only, required checks, no force push, empty bypass list (ch. 4)
- [ ] Cold-start test: 6 out of 6 (ch. 3)

## Week 2: specs and plans (chapters 5 and 6)

- [ ] Feature issue form (ch. 5)
- [ ] Spec template in `docs/templates/` (ch. 5)
- [ ] `spec-writer` subagent; one spec written with it (ch. 5)
- [ ] Definition of ready in the issue form (ch. 5)
- [ ] Plan template; `planner` subagent; one plan reviewed in about two minutes (ch. 6)

## Week 3: build, verify, merge (chapters 7 to 9)

- [ ] `.claude/settings.json`: allow and deny rules, sandbox (ch. 7)
- [ ] Hooks: guard-bash, protect-paths, after-edit; tested by hand (ch. 7)
- [ ] Claude GitHub app installed; `agent-implement.yml` with plan, build and retry (ch. 7)
- [ ] PR template (ch. 7)
- [ ] One labelled issue turned into a PR without watching (ch. 7)
- [ ] `reviewer` subagent, verdict schema, `agent-review.yml`; `review` is a required check (ch. 8)
- [ ] Smoke test running against previews (ch. 8)
- [ ] `risk-tier` and `tier-gate` jobs; `tier-gate` is a required check (ch. 9)
- [ ] Auto-merge enabled; one tier 0 PR merged itself (ch. 9)
- [ ] `production` environment restricted to `main`; deploy secrets moved there (ch. 9)
- [ ] OIDC federated credentials for deploy (write) and what-if (read-only) (ch. 9)
- [ ] Rollback drill done and timed (ch. 9)

## Week 4: Arc 1 (chapter 10)

- [ ] ADR 0001 and the rewrite spec with parity goals
- [ ] `web/AGENTS.md` and the `port-route` skill merged before any port
- [ ] Parity harness (URLs, metadata, storage, smoke) running on `web/` PRs
- [ ] All child tickets merged; parity 100%
- [ ] Cutover with low TTL; old host kept for two weeks
- [ ] Old app removed; AGENTS.md updated; cold-start test re-run

## Week 5: Arc 2 and running it (chapters 11 to 13)

- [ ] Product principle changed by you, alone in its PR
- [ ] ADR 0002 (accounts and sync) and ADR 0003 (database)
- [ ] Sync spec with conflict, tombstone and first-sign-in criteria
- [ ] `contract` job in CI; breaking changes raise the tier
- [ ] Slices S1 to S4 merged behind the `sync` flag; tier 2 checklist done for S1 and S4
- [ ] S5: rollout checklist done; flag on
- [ ] Run log collected; first weekly factory review held (ch. 12)
- [ ] Monthly spending limit set (ch. 12)
- [ ] Strangers can't start agents: tested from a second account (ch. 12)
- [ ] CODEOWNERS written (ch. 13)
- [ ] 90-day plan for your own factory (ch. 13)
