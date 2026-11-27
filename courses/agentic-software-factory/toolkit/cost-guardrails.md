# Cost guardrails

[Back to the toolkit](README.md)

Cap every agent loop at three levels: the run, the job and the month. Chapter 12 explains why. Flags and limits change between Claude Code releases 🔧: check `claude --help` and the docs.

## Every cap and where to set it

| Level | Cap | Where |
|---|---|---|
| Agent loop: plan | 20 turns, $1 | `--max-turns 20 --max-budget-usd 1.00` in `agent-implement.yml` |
| Agent loop: build | 40 turns | `claude_args: --max-turns 40` |
| Agent loop: retry | 25 turns | `claude_args: --max-turns 25` |
| Agent loop: review | 25 turns, $1 | `--max-turns 25 --max-budget-usd 1.00` in `agent-review.yml` |
| Job time | Plan 15 min, build 45 min, retry 30 min, review 15 min | `timeout-minutes` |
| Retries | 2 per PR, then `needs-human` | `MAX_RETRIES` in `agent-implement.yml` |
| Parallelism | WIP limit 3 | `concurrency` groups, and your own `agent:go` discipline |
| Month | A hard limit you can afford to lose | Usage limits for the API key's workspace in the Anthropic Console |
| Who can start a run | Maintainers only | Labels; owner-only `@claude` handling |

`--max-budget-usd` works in print mode (`claude -p`). Inside `claude-code-action`, use `--max-turns` and the job timeout.

## Subscription or API key

| | Claude subscription (`CLAUDE_CODE_OAUTH_TOKEN`) | API key (`ANTHROPIC_API_KEY`) |
|---|---|---|
| Billing | Draws on your plan's usage limits | Pay per token |
| Cost per run in the JSON output | Not meaningful | `total_cost_usd` |
| Good for | Builds, when your plan has headroom | Reviews and plans with dollar caps; anything you want measured exactly |

The toolkit uses the subscription token for builds and an API key for plans and reviews. Swap either way.

## Picking models by stage

| Stage | Model | Why |
|---|---|---|
| Plan, review of tier 0 and 1 | A fast, cheaper model | Reading and judging diffs is lighter work than writing them |
| Build, tier 1 | Your default | |
| Build and review, tier 2 | The strongest model you have | The expensive mistakes are here |

Set it per job with `--model` (for example `sonnet` or `opus` as aliases) 🔧.

## When cost per merged PR rises

Check in this order:

1. **Retries.** Count `<!-- agent-retry -->` comments per PR. Many retries mean weak gates locally (the agent can't see the failure before CI) or flaky tests.
2. **Task size.** Turns per run near the cap mean tasks are too big; split them.
3. **Context.** Long runs reading the same files every time mean the context layer doesn't point to the right place.
4. **Model.** Only then, the model choice.
