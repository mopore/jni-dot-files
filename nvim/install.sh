#!/usr/bin/env bash
# Provide --noconfirm as first argument to skip user confirmation

set -euo pipefail

NEO_VIM_CONFIG_PATH="$HOME/.config/nvim"
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_DIR="$HOME/.config/nvim_backup"
BACKUP_FILE_PATH="$BACKUP_DIR/dot_config_slash_nvim_$TIMESTAMP.zip"
ORIGINAL_DIR=$(pwd)

SWITCH_ON=1
SWITCH_OFF=0

user_interaction=SWITCH_ON
# Check if $1 is set and is --noconfirm
if [ -n "${1:-}" ] && [ "$1" = "--noconfirm" ]; then
	echo "Running without user interaction"
	user_interaction=SWITCH_OFF
fi


function ask_user() {
	local question="$1"
	echo "$question (y/N)"
	read -r response
	if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
		return 0  # true
	else
		return 1  # false
	fi
}

function deploy() {
	rm -rf "$NEO_VIM_CONFIG_PATH"
	mkdir -p "$NEO_VIM_CONFIG_PATH"
	cp -rv src/* "$NEO_VIM_CONFIG_PATH"
	cp -rv src/.* "$NEO_VIM_CONFIG_PATH"  # Copy hidden files like .editorconfig and .luarc.json 
}


perform_backup=$SWITCH_ON 

if [ ! -d "$NEO_VIM_CONFIG_PATH" ]; then
	echo "No neovim config directory found at $NEO_VIM_CONFIG_PATH"
	perform_backup=$SWITCH_OFF
	if (( user_interaction )); then
		if ! ask_user "Proceed anyway...?"; then
			exit 1
		fi
	fi
fi

if [ -z "$(ls -A "$NEO_VIM_CONFIG_PATH")" ]; then
	echo "Neovim config directory is empty at $NEO_VIM_CONFIG_PATH"
	perform_backup=$SWITCH_OFF
	if (( user_interaction )); then
		if ! ask_user "Proceed anyway...?"; then
			exit 1
		fi
	fi
fi

if [ ! -d "$BACKUP_DIR" ]; then
	mkdir -p "$BACKUP_DIR"
	echo "Created backup directory at $BACKUP_DIR"
fi

if (( perform_backup )); then
	echo "Backing up neovim config to $BACKUP_FILE_PATH..."
	cd "$NEO_VIM_CONFIG_PATH"
	zip -r "$BACKUP_FILE_PATH" .
	echo "Old neovim config backed up to $BACKUP_FILE_PATH"
	cd "$ORIGINAL_DIR"
fi

if (( user_interaction )); then
	if ask_user "Deploy new neovim config...?" ; then
		deploy
	fi
else
	deploy
fi

exit 0
