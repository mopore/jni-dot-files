#!/usr/bin/env zsh

set -euo pipefail

NEO_VIM_CONFIG_PATH="$HOME/.config/nvim"
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_DIR="$HOME/.config/nvim_backup"
BACKUP_FILE_PATH="$BACKUP_DIR/dot_config_slash_nvim_$TIMESTAMP.zip"


if [ ! -d "$NEO_VIM_CONFIG_PATH" ]; then
  echo "No neovim config directory found at $NEO_VIM_CONFIG_PATH"
  exit 1
fi

if [ -z "$(ls -A "$NEO_VIM_CONFIG_PATH")" ]; then
  echo "Neovim config directory is empty at $NEO_VIM_CONFIG_PATH"
  exit 1
fi

if [ ! -d "$BACKUP_DIR" ]; then
  mkdir -p "$BACKUP_DIR"
  echo "Created backup directory at $BACKUP_DIR"
fi

echo "Backing up neovim config to $BACKUP_FILE_PATH..."
cd "$NEO_VIM_CONFIG_PATH"
zip -r "$BACKUP_FILE_PATH" .
echo "Old neovim config backed up to $BACKUP_FILE_PATH"

echo "Also clean the config directory? (y/N)"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
  rm -rf "$NEO_VIM_CONFIG_PATH"
  mkdir -p "$NEO_VIM_CONFIG_PATH"
  echo "Neovim config directory cleaned and recreated at $NEO_VIM_CONFIG_PATH"
fi

echo "All done."

exit 0