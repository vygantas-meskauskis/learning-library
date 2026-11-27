#!/usr/bin/env bash
# PostToolUse hook for Edit, Write and MultiEdit.
# Runs ESLint with --fix on the edited TypeScript file and reports what's left,
# so the agent sees lint problems inside its loop instead of in CI.
# PostToolUse can't undo the edit; stderr with exit 2 is shown to the agent.
set -uo pipefail

file=$(jq -r '.tool_input.file_path // empty')
root=${CLAUDE_PROJECT_DIR:-$(pwd)}
case "$file" in
  "$root"/web/*.ts|"$root"/web/*.tsx) ;;
  *) exit 0 ;;
esac

cd "$root/web" || exit 0
if ! out=$(npx --no-install eslint --fix "$file" 2>&1); then
  echo "ESLint problems remain in ${file#"$root"/}:" >&2
  echo "$out" | tail -n 30 >&2
  exit 2
fi
exit 0
