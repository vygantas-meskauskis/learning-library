# Toolkit

[Back to the course](../README.md)

Copy-ready files for building your own factory. Each one is written for BusyHamster's monorepo (`web/`, `api/`, `infra/`) and is meant to be adapted, not used blindly. Files marked 🧪 were written from the docs and not run end to end for this course. Facts marked 🔧 in the chapters (versions, flags, plan limits) apply to these files too.

> Files whose names start with `agents-` are AGENTS.md templates. They're named this way so that an agent working inside the learning library doesn't take them as instructions. Rename each one to `AGENTS.md` when you copy it.

## Where each file goes

| Toolkit file | Copy to | Chapter |
|---|---|---|
| [agents-root.md](agents-root.md) | `AGENTS.md` | 3 |
| [agents-web.md](agents-web.md) | `web/AGENTS.md` | 3, 10 |
| [agents-api.md](agents-api.md) | `api/AGENTS.md` | 3, 11 |
| [cold-start-test.md](cold-start-test.md) | Your notes, or `docs/` | 3, 12 |
| [claude/settings.json](claude/settings.json) | `.claude/settings.json` | 7 |
| [claude/hooks/guard-bash.sh](claude/hooks/guard-bash.sh) | `.claude/hooks/guard-bash.sh` (`chmod +x`) | 7 |
| [claude/hooks/protect-paths.sh](claude/hooks/protect-paths.sh) | `.claude/hooks/protect-paths.sh` (`chmod +x`) | 7 |
| [claude/hooks/after-edit.sh](claude/hooks/after-edit.sh) | `.claude/hooks/after-edit.sh` (`chmod +x`) | 7 |
| [claude/agents/spec-writer.md](claude/agents/spec-writer.md) | `.claude/agents/spec-writer.md` | 5 |
| [claude/agents/planner.md](claude/agents/planner.md) | `.claude/agents/planner.md` | 6 |
| [claude/agents/reviewer.md](claude/agents/reviewer.md) | `.claude/agents/reviewer.md` | 8 |
| [claude/review-verdict.schema.json](claude/review-verdict.schema.json) | `.claude/review-verdict.schema.json` | 8 |
| [claude/skills/new-tool/SKILL.md](claude/skills/new-tool/SKILL.md) | `.claude/skills/new-tool/SKILL.md` | 3 |
| [github/ISSUE_TEMPLATE/feature.yml](https://github.com/vygantas-meskauskis/learning-library/blob/main/courses/agentic-software-factory/toolkit/github/ISSUE_TEMPLATE/feature.yml) | `.github/ISSUE_TEMPLATE/feature.yml` | 5 |
| [github/pull_request_template.md](github/pull_request_template.md) | `.github/pull_request_template.md` | 7 |
| [github/workflows/ci.yml](https://github.com/vygantas-meskauskis/learning-library/blob/main/courses/agentic-software-factory/toolkit/github/workflows/ci.yml) | `.github/workflows/ci.yml` | 4, 9, 11 |
| [github/workflows/agent-implement.yml](https://github.com/vygantas-meskauskis/learning-library/blob/main/courses/agentic-software-factory/toolkit/github/workflows/agent-implement.yml) | `.github/workflows/agent-implement.yml` | 6, 7 |
| [github/workflows/agent-review.yml](https://github.com/vygantas-meskauskis/learning-library/blob/main/courses/agentic-software-factory/toolkit/github/workflows/agent-review.yml) | `.github/workflows/agent-review.yml` | 8 |
| [github/workflows/infra-whatif.yml](https://github.com/vygantas-meskauskis/learning-library/blob/main/courses/agentic-software-factory/toolkit/github/workflows/infra-whatif.yml) 🧪 | `.github/workflows/infra-whatif.yml` | 9 |
| [github/workflows/deploy.yml](https://github.com/vygantas-meskauskis/learning-library/blob/main/courses/agentic-software-factory/toolkit/github/workflows/deploy.yml) 🧪 | `.github/workflows/deploy.yml` | 9, 11 |
| [scripts/risk-tier.sh](scripts/risk-tier.sh) | `scripts/risk-tier.sh` (`chmod +x`) | 9 |
| [scripts/contract-breaking.sh](scripts/contract-breaking.sh) | `scripts/contract-breaking.sh` (`chmod +x`) | 11 |
| [scripts/review-inputs.sh](scripts/review-inputs.sh) | `scripts/review-inputs.sh` (`chmod +x`) | 8 |
| [scripts/review-post.sh](scripts/review-post.sh) | `scripts/review-post.sh` (`chmod +x`) | 8 |
| [templates/spec-template.md](templates/spec-template.md) | `docs/templates/spec-template.md` | 5 |
| [templates/plan-template.md](templates/plan-template.md) | `docs/templates/plan-template.md` | 6 |
| [templates/adr-template.md](templates/adr-template.md) | `docs/templates/adr-template.md` | 3 |
| [web/react-router.config.ts](web/react-router.config.ts) | `web/react-router.config.ts` | 10 |
| [web/staticwebapp.config.json](web/staticwebapp.config.json) | `web/public/staticwebapp.config.json` | 10 |
| [web/smoke.spec.ts](web/smoke.spec.ts) | `web/tests/smoke.spec.ts` | 8, 10 |
| [api/BffProgram.cs](https://github.com/vygantas-meskauskis/learning-library/blob/main/courses/agentic-software-factory/toolkit/api/BffProgram.cs) 🧪 | `api/src/BusyHamster.Api/Program.cs` | 11 |
| [infra/main.bicep](infra/main.bicep) 🧪 | `infra/main.bicep` | 9, 11 |
| [infra/main.bicepparam](infra/main.bicepparam) | `infra/main.bicepparam` | 9, 11 |

## Guides and worksheets

| File | Use it for |
|---|---|
| [factory-setup-checklist.md](factory-setup-checklist.md) | The whole course as a checklist, in rollout order |
| [risk-tiers.md](risk-tiers.md) | The tier rules, the merge policy and the tier 2 security checklist |
| [cost-guardrails.md](cost-guardrails.md) | Every cap on agent runs, and where to set it |
| [factory-metrics.md](factory-metrics.md) | The weekly numbers, the review agenda and the failure classes |
| [rollout-checklist.md](rollout-checklist.md) | Before turning a feature flag on for everyone |

## Before you copy

- **Labels**: create the labels from chapter 2 first; the workflows expect them.
- **Secrets**: `CLAUDE_CODE_OAUTH_TOKEN` (from `claude setup-token`) or `ANTHROPIC_API_KEY` as repository secrets for the agent and review jobs; deploy secrets only in the `production` environment (chapter 9).
- **Node version**: the workflows read `web/.nvmrc`. Create it with `22`.
- **Bot login**: the tier and retry jobs compare the PR author with the Claude GitHub app's bot login. Check yours on an agent PR (`gh pr view <n> --json author`) and update the scripts 🔧.
- **Sandbox settings**: the `sandbox` block in `settings.json` follows the 2026 docs; key names have changed between releases, so confirm them with `/sandbox` in Claude Code after copying 🔧.
- **Before the monorepo exists**: until chapter 10 creates `web/`, set `working-directory` to `.` in `ci.yml` and the agent prompts.
