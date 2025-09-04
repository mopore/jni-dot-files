#!/usr/bin/env bash
set -euo pipefail

if ! command -v wezterm >/dev/null 2>&1 ;
then
    echo "Please install 'kitty' to execute this script."
    exit 1
fi

CONFIG_NAME="wezterm"
CONFIG_FILE="$CONFIG_NAME.lua"

if [ ! -d "$HOME/.config/$CONFIG_NAME" ] ; then
    mkdir -p "$HOME/.config/$CONFIG_NAME"
fi

if [ -f "$HOME/.config/$CONFIG_NAME/$CONFIG_FILE" ] ; then
    mv "$HOME/.config/$CONFIG_NAME/$CONFIG_FILE" "$HOME/.config/$CONFIG_NAME/${CONFIG_FILE}.backup" 
fi

# Install kitty config
cp ./$CONFIG_FILE ~/.config/$CONFIG_NAME/$CONFIG_FILE

echo "WezTerm configuration installed to $HOME/.config/$CONFIG_NAME/$CONFIG_FILE"
