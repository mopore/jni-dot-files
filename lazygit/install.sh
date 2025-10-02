#!/usr/bin/env bash

set -euo pipefail

DEPENCENCY_TO_DELTA_COMMAND="delta"

if ! command -v $DEPENCENCY_TO_DELTA_COMMAND &> /dev/null; then
	echo "Error: Install git-delta before using this config!"
	exit 1
fi

cp -v --interactive ./config.yml "${HOME}/.config/lazygit/"
