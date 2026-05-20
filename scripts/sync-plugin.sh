#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PLUGIN="$ROOT/plugins/fabric-sdlc"

rsync -a --delete "$ROOT/commands/" "$PLUGIN/commands/"
rsync -a --delete "$ROOT/skills/" "$PLUGIN/skills/"

cp "$ROOT/LICENSE" "$PLUGIN/LICENSE"
cp "$ROOT/THIRD_PARTY_NOTICES.md" "$PLUGIN/THIRD_PARTY_NOTICES.md"

echo "Synced root commands and skills into $PLUGIN"
