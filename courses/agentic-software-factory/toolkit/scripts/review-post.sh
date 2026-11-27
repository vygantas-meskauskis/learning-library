#!/usr/bin/env bash
# Turns the reviewer's JSON verdict into a PR comment, and fails on "block".
# Usage: review-post.sh <pr-number> <review.json>
set -euo pipefail
pr=$1
json=$2

out=$(jq '.structured_output // (.result | fromjson? ) // empty' "$json")
if [ -z "$out" ]; then
  gh pr comment "$pr" --body "Review: the reviewer returned no verdict. Treating as **changes**; a human should look."
  exit 0
fi

verdict=$(jq -r .verdict <<<"$out")
cost=$(jq -r '.total_cost_usd // empty' "$json")

{
  echo "### Independent review: **$verdict**"
  echo
  echo "| Criterion | Covered by | Met |"
  echo "|---|---|---|"
  jq -r '.criteria[] | "| \(.id) | \(.covered_by) | \(.met) |"' <<<"$out"
  echo
  if [ "$(jq '.findings | length' <<<"$out")" -gt 0 ]; then
    echo "| Severity | Where | Finding |"
    echo "|---|---|---|"
    jq -r '.findings[] | "| \(.severity) | `\(.file)\(if .line then ":\(.line)" else "" end)` | \(.summary) |"' <<<"$out"
  else
    echo "No findings."
  fi
  [ -n "$cost" ] && printf '\n<sub>Review cost: $%s</sub>\n' "$cost"
} > review-comment.md

gh pr comment "$pr" --body-file review-comment.md

if [ "$verdict" = "block" ]; then
  echo "::error::The independent reviewer blocked this PR. See the review comment."
  exit 1
fi
