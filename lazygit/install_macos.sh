#!/usr/bin/env bash

set -euo pipefail

DEPENCENCY_TO_DELTA_COMMAND="delta"

if ! command -v $DEPENCENCY_TO_DELTA_COMMAND &> /dev/null; then
	echo "Error: Install git-delta before using this config!"
	exit 1
fi

# Remove this directory which does not work for MacOS
rm -rf "${HOME}/.config/lazygit/"

mkdir -p ~/Library/Application\ Support/lazygit
cp ./config.yml ~/Library/Application\ Support/lazygit/config.yml
