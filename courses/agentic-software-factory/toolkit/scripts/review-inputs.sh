#!/usr/bin/env bash
# Writes SPEC.md, PLAN.md and DIFF.patch for the reviewer (chapter 8).
# Usage: review-inputs.sh <pr-number>
# The PR description is deliberately NOT given to the reviewer.
set -euo pipefail
pr=$1

body=$(gh pr view "$pr" --json body -q .body)
issue=$(grep -oiE '(closes|fixes|resolves) #[0-9]+' <<<"$body" | head -1 | grep -oE '[0-9]+' || true)

if [ -n "$issue" ]; then
  # The spec: a linked file in docs/specs/ if the issue names one, else the issue body.
  issue_body=$(gh issue view "$issue" --json body -q .body)
  spec_file=$(grep -oE 'docs/specs/[A-Za-z0-9._-]+\.md' <<<"$issue_body" | head -1 || true)
  if [ -n "$spec_file" ] && [ -f "$spec_file" ]; then
    cp "$spec_file" SPEC.md
  else
    printf '%s\n' "$issue_body" > SPEC.md
  fi
  # The plan: the latest comment that starts with "## Plan".
  gh issue view "$issue" --json comments \
    -q '[.comments[] | select(.body | startswith("## Plan"))] | last | .body // "No plan found."' > PLAN.md
else
  echo "No linked issue (no 'Closes #n' in the PR). Review against the repository rules only." > SPEC.md
  echo "No plan." > PLAN.md
fi

gh pr diff "$pr" > DIFF.patch
echo "Review inputs: SPEC.md ($(wc -l < SPEC.md) lines), PLAN.md ($(wc -l < PLAN.md) lines), DIFF.patch ($(wc -l < DIFF.patch) lines)"
