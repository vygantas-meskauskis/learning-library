#!/usr/bin/env bash
# Prints the risk tier (0, 1 or 2) of a change, read from `git diff --name-status`
# on stdin. The highest tier of any changed file wins. See toolkit/risk-tiers.md.
# This script is itself tier 2: it lives in scripts/.
set -uo pipefail

tier=0
raise() { [ "$1" -gt "$tier" ] && tier=$1; }

while IFS=$'\t' read -r status path rest; do
  [ -z "${status:-}" ] && continue
  # For renames (R100 old new) the new path is the third field.
  [[ "$status" == R* || "$status" == C* ]] && path=$rest

  case "$path" in
    # Tier 2: the factory itself, decisions, infrastructure, data and trust.
    .github/*|.claude/*|scripts/*|infra/*|PRODUCT.md|docs/adr/*) raise 2 ;;
    api/*/Auth/*|api/*Auth*.cs|api/*/Migrations/*|api/*/Data/*) raise 2 ;;
    web/app/lib/storage.ts|web/app/lib/history.ts|web/app/lib/sync.ts) raise 2 ;;
    web/app/styles/globals.css|web/app/routes.ts) raise 2 ;;   # wide blast radius
    */package.json|*/package-lock.json|*.csproj|*/Directory.Packages.props) raise 2 ;;  # dependencies
    # Tier 0: text and new tests.
    content/blog/*|web/content/blog/*) ;;
    docs/specs/*) raise 1 ;;
    *.md) ;;
    *.test.ts|*.test.tsx|*.spec.ts|*Tests.cs)
      # New tests are tier 0; changing or deleting existing tests is tier 2.
      if [ "$status" = "A" ]; then :; else raise 2; fi ;;
    # Tier 1: everything else that users can see or that runs.
    *) raise 1 ;;
  esac

  # Deleting anything that isn't a doc is at least tier 1.
  if [ "$status" = "D" ] && [[ "$path" != *.md ]]; then raise 1; fi
done

echo "$tier"
