#!/usr/bin/env bash

set -euo pipefail

OPEN_CODE_CONFIG_DIR="${HOME}/.config/opencode"

if [ ! -d "$OPEN_CODE_CONFIG_DIR" ]; then
	mkdir -p "$OPEN_CODE_CONFIG_DIR"
fi

rm -f "$OPEN_CODE_CONFIG_DIR/AGENTS.md" || true
rm -f "$OPEN_CODE_CONFIG_DIR/config.*" || true
rm -rf "$OPEN_CODE_CONFIG_DIR/agent" || true
rm -rf "$OPEN_CODE_CONFIG_DIR/skills" || true

cp ./AGENTS.md "$OPEN_CODE_CONFIG_DIR/AGENTS.md"
cp ./config.json "$OPEN_CODE_CONFIG_DIR/config.json"
cp -r ./skills/ "$OPEN_CODE_CONFIG_DIR/skills"

# Note: We do not need the example agent, hence the commented copy line
#
# cp -r ./agent "$OPEN_CODE_CONFIG_DIR/agent"

echo "OpenCode configuration has been installed!"
echo
echo "Use: \"opencode auth login\" to login with GitHub"
echo "Use: \"opencode --continue\" to continue last session"
echo "Use: \"opencode run < instructions.md\" to paste instructions"
