#!/usr/bin/env bash
# Exit 0 (true) if api/openapi.json changed in a breaking way since BASE:
# a path, operation, schema or property was removed, or a property became required.
# Additions only (new paths, new optional properties) exit 1 (not breaking).
set -euo pipefail
base=$1
old=$(git show "$base:api/openapi.json" 2>/dev/null || echo '{}')
new=$(cat api/openapi.json)

keys() {
  jq -r '
    [ (.paths // {} | to_entries[] | "path " + .key),
      (.paths // {} | to_entries[] | .key as $p | .value | keys[] | "op " + $p + " " + .),
      (.components.schemas // {} | to_entries[] | .key as $s |
         ("schema " + $s),
         (.value.properties // {} | keys[] | "prop " + $s + "." + .))
    ] | .[]' <<<"$1" | sort
}
required() {
  jq -r '.components.schemas // {} | to_entries[] | .key as $s | (.value.required // [])[] | $s + "." + .' <<<"$1" | sort
}

removed=$(comm -23 <(keys "$old") <(keys "$new"))
newly_required=$(comm -13 <(required "$old") <(required "$new"))

if [ -n "$removed" ] || [ -n "$newly_required" ]; then
  echo "Breaking contract change:" >&2
  [ -n "$removed" ] && echo "$removed" | sed 's/^/  removed: /' >&2
  [ -n "$newly_required" ] && echo "$newly_required" | sed 's/^/  now required: /' >&2
  exit 0
fi
exit 1
