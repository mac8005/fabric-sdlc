#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if ! command -v claude >/dev/null 2>&1; then
  echo "claude CLI is required for plugin validation" >&2
  exit 1
fi

claude plugin validate --strict "$ROOT/.claude-plugin/marketplace.json"
claude plugin validate --strict "$ROOT/.claude-plugin/plugin.json"
claude plugin validate --strict "$ROOT/plugins/fabric-sdlc"

diff -qr "$ROOT/commands" "$ROOT/plugins/fabric-sdlc/commands"
diff -qr "$ROOT/skills" "$ROOT/plugins/fabric-sdlc/skills"

for base in "$ROOT/skills" "$ROOT/plugins/fabric-sdlc/skills"; do
  for skill_dir in "$base"/*; do
    [[ -d "$skill_dir" ]] || continue
    skill_name="$(basename "$skill_dir")"
    if [[ "$skill_name" != "fabric-sdlc" && ! -f "$skill_dir/LICENSE.txt" ]]; then
      echo "Missing LICENSE.txt in $skill_dir" >&2
      exit 1
    fi
  done
done

if grep -R -n -E "ADDITIONAL RESTRICTIONS|All rights reserved" "$ROOT/skills" "$ROOT/plugins/fabric-sdlc/skills"; then
  echo "Restricted license text found in bundled skills" >&2
  exit 1
fi

echo "Plugin validation passed"
