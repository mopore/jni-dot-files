#!/usr/bin/env bash

set -euo pipefail

OPEN_CODE_CONFIG_DIR="${HOME}/.config/opencode"

if [ ! -d "$OPEN_CODE_CONFIG_DIR" ]; then
	mkdir -p "$OPEN_CODE_CONFIG_DIR"
fi

rm -f "$OPEN_CODE_CONFIG_DIR/AGENTS.md" || true
rm -f "$OPEN_CODE_CONFIG_DIR/config.json" || true
rm -f "$OPEN_CODE_CONFIG_DIR/config.jsonc" || true
rm -f "$OPEN_CODE_CONFIG_DIR/opencode.jsonc" || true
rm -rf "$OPEN_CODE_CONFIG_DIR/agent" || true
rm -rf "$OPEN_CODE_CONFIG_DIR/skills" || true

cp ./AGENTS.md "$OPEN_CODE_CONFIG_DIR/AGENTS.md"
cp ./opencode.jsonc "$OPEN_CODE_CONFIG_DIR/opencode.jsonc"
cp -r ./skills/ "$OPEN_CODE_CONFIG_DIR/skills"

# Note: We do not need the example agent, hence the commented copy line
#
# cp -r ./agent "$OPEN_CODE_CONFIG_DIR/agent"

echo "OpenCode configuration has been installed!"
echo
echo "Use: \"opencode auth login\" to login with GitHub"
echo "Use: \"opencode auth login --provider openai\" for OpenAI directly"
echo "Use: \"opencode --continue\" to continue last session"
echo "Use: \"opencode run < instructions.md\" to paste instructions"
