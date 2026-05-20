#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PLUGIN="$ROOT/plugins/fabric-sdlc"

if ! command -v claude >/dev/null 2>&1; then
  echo "claude CLI is required for plugin validation" >&2
  exit 1
fi

claude plugin validate --strict "$ROOT/.claude-plugin/marketplace.json"
claude plugin validate --strict "$PLUGIN"

# Every bundled (third-party) skill must ship its LICENSE.txt. The first-party
# fabric-sdlc skill is exempt — it is covered by the repo LICENSE.
for skill_dir in "$PLUGIN"/skills/*; do
  [[ -d "$skill_dir" ]] || continue
  skill_name="$(basename "$skill_dir")"
  if [[ "$skill_name" != "fabric-sdlc" && ! -f "$skill_dir/LICENSE.txt" ]]; then
    echo "Missing LICENSE.txt in $skill_dir" >&2
    exit 1
  fi
done

if grep -R -n -E "ADDITIONAL RESTRICTIONS|All rights reserved" "$PLUGIN/skills"; then
  echo "Restricted license text found in bundled skills" >&2
  exit 1
fi

echo "Plugin validation passed"
