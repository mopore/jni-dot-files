#!/usr/bin/env bash

set -euo pipefail

OPEN_CODE_CONFIG_DIR="${HOME}/.config/opencode"

if [ ! -d "$OPEN_CODE_CONFIG_DIR" ]; then
	mkdir -p "$OPEN_CODE_CONFIG_DIR"
fi

rm -f "$OPEN_CODE_CONFIG_DIR/AGENTS.md" || true
rm -f "$OPEN_CODE_CONFIG_DIR/config.json" || true
rm -rf "$OPEN_CODE_CONFIG_DIR/agent" || true

cp ./AGENTS.md "$OPEN_CODE_CONFIG_DIR/AGENTS.md"
cp ./config.json "$OPEN_CODE_CONFIG_DIR/config.json"
cp -r ./agent "$OPEN_CODE_CONFIG_DIR/agent"

echo "OpenCode configuration has been installed!"
