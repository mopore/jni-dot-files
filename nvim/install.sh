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

function detect_pkg_manager() {
	if command -v pacman &>/dev/null; then
		echo "pacman"
	elif command -v brew &>/dev/null; then
		echo "brew"
	elif command -v apt &>/dev/null; then
		echo "apt"
	else
		echo "unknown"
	fi
}

function ensure_dependencies() {
	local pkg_manager
	pkg_manager=$(detect_pkg_manager)
	echo "Detected package manager: $pkg_manager"

	case "$pkg_manager" in
		pacman)
			local to_install=()
			command -v gcc &>/dev/null || to_install+=(gcc)
			command -v tree-sitter &>/dev/null || to_install+=(tree-sitter-cli)
			if [ ${#to_install[@]} -gt 0 ]; then
				sudo pacman -S --needed --noconfirm "${to_install[@]}"
			fi
			;;
		brew)
			if ! command -v cc &>/dev/null; then
				xcode-select --install
				until command -v cc &>/dev/null; do sleep 5; done
			fi
			if ! command -v tree-sitter &>/dev/null; then
				brew install tree-sitter-cli
			fi
			;;
		apt)
			local apt_install=()
			command -v gcc &>/dev/null || apt_install+=(gcc)
			command -v curl &>/dev/null || apt_install+=(curl)
			if [ ${#apt_install[@]} -gt 0 ]; then
				sudo apt-get update -y
				sudo apt-get install -y "${apt_install[@]}"
			fi
			if ! command -v tree-sitter &>/dev/null; then
				echo "Installing tree-sitter-cli from GitHub releases..."
				local arch
				case "$(uname -m)" in
					aarch64|arm64) arch="arm64" ;;
					x86_64) arch="x64" ;;
					armv7*|armv6*) arch="arm" ;;
					*) echo "ERROR: Unsupported architecture $(uname -m)"; exit 1 ;;
				esac
				local url="https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-${arch}.gz"
				curl -L "$url" | gunzip > /tmp/tree-sitter
				chmod +x /tmp/tree-sitter
				sudo mv /tmp/tree-sitter /usr/local/bin/tree-sitter
				echo "tree-sitter-cli installed to /usr/local/bin/tree-sitter"
			fi
			;;
		*)
			echo "ERROR: No supported package manager found (need pacman, brew, or apt)"
			exit 1
			;;
	esac

	echo "Dependencies OK: cc=$(which cc 2>/dev/null || which gcc), tree-sitter=$(which tree-sitter)"
}

function deploy() {
	rm -rf "$NEO_VIM_CONFIG_PATH"
	mkdir -p "$NEO_VIM_CONFIG_PATH"

	# Copies evertyhing (including hidden files like .editorconfig and .luarc.json)
	cp -av "${ORIGINAL_DIR}/src/." "$NEO_VIM_CONFIG_PATH/"  

	# Clean Ups
	#
	rm -rf ~/.local/share/nvim/lua-language-server/meta/love-api
	rm -rf ~/.local/share/nvim/lazy/nvim-treesitter*
	rm -rf ~/.local/share/nvim/site/parser-info
	rm -f ~/.config/nvim/lazy-lock.json

	# Install plugins and compile treesitter parsers headlessly
	echo "Installing plugins..."
	nvim --headless "+Lazy! sync" +qa
	echo "Compiling treesitter parsers (this may take a while)..."
	nvim --headless -c "lua require('nvim-treesitter.install').install({'bash','typescript','tsx','go','python','rust','cpp'}, {summary=true}):wait(); vim.cmd('qa')"
	echo "Plugins and parsers installed."
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

ensure_dependencies

if (( user_interaction )); then
	if ask_user "Deploy new neovim config...?" ; then
		deploy
	fi
else
	deploy
fi

exit 0
