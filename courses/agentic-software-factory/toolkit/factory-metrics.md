# Factory metrics and the weekly review

[Back to the toolkit](README.md)

## The four numbers, plus one count

| Metric | Formula | Healthy direction |
|---|---|---|
| Cycle time | Median hours from `agent:go` to merged | Down |
| Acceptance rate | Agent PRs merged without a human rewrite ÷ agent PRs opened | Up, towards 70–80% |
| Rework rate | Merged changes reverted or fixed within 14 days ÷ merged changes | Down |
| Cost per merged PR | Agent spend ÷ merged PRs | Stable or down |
| Escaped defects | Bugs found in production | Each one traced to a gate |

Don't measure lines of code, PRs opened or agent runs: all three go up when the factory gets worse.

## Weekly table

Copy this into your factory log.

| Week | Opened | Merged | Cycle time (h) | Acceptance | Rework | Cost / merged | Escaped | Fix of the week |
|---|---|---|---|---|---|---|---|---|
| 2026-W49 | | | | | | | | |

How to get the numbers:

```bash
# Agent PRs merged in the last 7 days, with times
gh pr list --state merged --search "author:app/claude merged:>=$(date -d '7 days ago' +%F)" \
  --json number,createdAt,mergedAt,labels --limit 100

# Agent PRs closed without merging (not accepted)
gh pr list --state closed --search "author:app/claude is:unmerged closed:>=$(date -d '7 days ago' +%F)" \
  --json number --limit 100

# Run costs from review and plan artifacts
gh run list --workflow review --created ">=$(date -d '7 days ago' +%F)" --json databaseId -q '.[].databaseId' \
  | xargs -I{} gh run download {} -D runs/{}
jq -s 'map(.total_cost_usd // 0) | add' runs/*/*/review.json
```

The author filter depends on your Claude GitHub app's login 🔧.

## The 30-minute review

| Minutes | Do |
|---|---|
| 5 | Fill in the table |
| 10 | Go through every `needs-human`, every `block` verdict and every escaped defect. Classify each one |
| 10 | Pick **one** fix for the most common class. Open it as an issue |
| 5 | Run the cold-start test. First review of the month: do a rollback drill |

## Failure classes

| Class | Signal | Fix the… |
|---|---|---|
| Spec gap | The agent built what was written, and it was wrong | Spec template, spec-writer questions, definition of ready |
| Context gap | The agent didn't know a rule or a convention | AGENTS.md, a skill, an ADR |
| Gate gap | A mistake reached review or production that a check could find | A test, a lint rule, a hook |
| Tool gap | The agent couldn't do the right thing | Permissions, sandbox domains, scripts |
| Model limit | Clear spec and context, and it still couldn't | Task size, model choice, or a human |

## Seen it before?

| Seen | Rule goes into |
|---|---|
| Once | The factory log |
| Twice | AGENTS.md or a skill |
| Three times | A test, a lint rule or a hook |
