#!/usr/bin/env bash
# PreToolUse hook for Bash. Reads the tool call as JSON on stdin.
# Exit 2 blocks the command and sends stderr back to the agent. Exit 0 allows it.
# (Exit 1 does NOT block: policy hooks must exit 2.)
set -uo pipefail

cmd=$(jq -r '.tool_input.command // empty')
[ -z "$cmd" ] && exit 0

block() {
  echo "Blocked by guard-bash: $1" >&2
  exit 2
}

# History rewriting and force pushes.
if grep -Eq 'git[[:space:]]+push[^|;&]*(--force|-f([[:space:]]|$)|--force-with-lease)' <<<"$cmd"; then
  block "force pushes are not allowed. Push a new commit instead."
fi
if grep -Eq 'git[[:space:]]+(rebase|reset[[:space:]]+--hard|filter-branch|filter-repo)' <<<"$cmd"; then
  block "rewriting history is not allowed in this repository. Make a new commit."
fi
if grep -Eq 'git[[:space:]]+(checkout|switch)[^|;&]*[[:space:]]main([[:space:]]|$)' <<<"$cmd" && grep -Eq 'git[[:space:]]+commit' <<<"$cmd"; then
  block "never commit on main. Work on your agent/<issue> branch."
fi

# Piping downloads into a shell.
if grep -Eq '(curl|wget)[^|]*\|[[:space:]]*(ba|z|)sh' <<<"$cmd"; then
  block "piping a download into a shell is not allowed."
fi

# Deleting outside the project.
if grep -Eq 'rm[[:space:]]+(-[a-zA-Z]*r[a-zA-Z]*f|-[a-zA-Z]*f[a-zA-Z]*r)[[:space:]]+(/|~|\$HOME|\.\.)' <<<"$cmd"; then
  block "recursive delete outside the project folder."
fi

# Databases and cloud: agents never touch them.
if grep -Eq '(^|[[:space:];&|])(az|sqlcmd|psql|kubectl)([[:space:]]|$)' <<<"$cmd"; then
  block "agents don't use cloud or database CLIs. Describe what you need in the PR."
fi
if grep -Eq 'dotnet[[:space:]]+ef[[:space:]]+database' <<<"$cmd"; then
  block "migrations are applied by the deploy workflow, not by agents. 'dotnet ef migrations add' is fine."
fi

# Secrets.
if grep -Eq '(^|[[:space:]/])\.env(\.|[[:space:]]|$)|printenv|(^|[[:space:]])env([[:space:]]|$)' <<<"$cmd"; then
  block "reading environment files or dumping environment variables is not allowed."
fi

exit 0
