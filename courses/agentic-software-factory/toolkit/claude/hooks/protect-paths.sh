#!/usr/bin/env bash
# PreToolUse hook for Edit, Write and MultiEdit.
# Blocks edits to the factory's own files, infrastructure, decisions, and
# existing tests. Exit 2 blocks and explains; exit 0 allows.
set -uo pipefail

file=$(jq -r '.tool_input.file_path // empty')
[ -z "$file" ] && exit 0
root=${CLAUDE_PROJECT_DIR:-$(pwd)}
rel=${file#"$root"/}

case "$rel" in
  .github/*|.claude/*|scripts/*|infra/*)
    echo "Blocked: $rel is protected (factory or infrastructure file). Describe the change you need in the PR description; a human will make it." >&2
    exit 2 ;;
  PRODUCT.md|docs/adr/*)
    echo "Blocked: $rel records a human decision. If the task needs it changed, stop and say so in the PR or issue." >&2
    exit 2 ;;
esac

# Existing tests are evidence. New tests are welcome; changing old ones is a human decision.
if [[ "$rel" =~ \.(test|spec)\.tsx?$ || "$rel" =~ Tests?\.cs$ ]]; then
  if git -C "$root" cat-file -e "origin/main:$rel" 2>/dev/null; then
    echo "Blocked: $rel is an existing test. Fix the code, not the test. If the test is wrong, say why in the PR description and leave it failing." >&2
    exit 2
  fi
fi

exit 0
