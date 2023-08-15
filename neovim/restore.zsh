#!/usr/bin/env zsh
set -euo pipefail

BACKUP_DIR="$HOME/.config/nvim_backup"
NEO_VIM_CONFIG_PATH="$HOME/.config/nvim"
BACKUP_FILE_PATTERN="dot_config_slash_nvim_*.zip"

if ! command -v fzf >/dev/null 2>&1 ;
then
    echo "Please install 'fzf' to execute this script."
    exit 1
fi

if [ ! -d "$BACKUP_DIR" ]; then
  echo "No backup directory found at $BACKUP_DIR"
  exit 1
fi

choosen_backup_file=""

candidates=($(find $BACKUP_DIR -maxdepth 1 -type f -name "$BACKUP_FILE_PATTERN"))
if [[ ${#candidates[@]} -eq 0 ]]; then
    echo "No backup candidates could be found in '$HOME'."
    exit 1
# If there's exactly one file
elif [[ ${#candidates[@]} -eq 1 ]]; then
    choosen_backup_file=${candidates[1]}
    echo "Found the following backup file: $choosen_backup_file"
# If there's more than one file, use fzf to allow user to select
else
    choosen_backup_file=$(printf "%s\n" "${candidates[@]}" | fzf --prompt="Choose a backup file: ")

    if [[ -z $choosen_backup_file ]]; then
        echo "No file was chosen. Exiting."
        exit 1
    fi
fi

if [ ! -d "$NEO_VIM_CONFIG_PATH" ]; then
  mkdir -p "$NEO_VIM_CONFIG_PATH"
  echo "Created neovim config directory at $NEO_VIM_CONFIG_PATH"
fi

if [ -n "$(ls -A "$NEO_VIM_CONFIG_PATH")" ]; then
  echo "Neovim config directory is not empty and will be overwritten at $NEO_VIM_CONFIG_PATH"
  # Offer to delete the directory
  echo "Do you want to proceed? (y/N)"
  read -r response
  if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
    rm -rf "$NEO_VIM_CONFIG_PATH"
    echo "Directory deleted and recreated."
  else
    echo "Restoration aborted."
    exit 1
  fi
fi

echo "Will use '$choosen_backup_file' to restore neovim config."
unzip -o "$choosen_backup_file" -d "$NEO_VIM_CONFIG_PATH"