#!/usr/bin/env bash
set -euo pipefail

if ! command -v sudo >/dev/null; then
    echo "Please update repos and install sudo."
    exit 1
fi

if ! command -v nvim >/dev/null 2>&1 ; then
	if command -v apt-get >/dev/null ; then
        sudo apt-get update && sudo apt-get upgrade -y
        sudo apt-get install neovim curl git -y
    elif command -v pacman >/dev/null; then
        sudo pacman -Syu --noconfirm
        sudo pacman -S neovim curl git --noconfirm
    else
    	echo "System does not seam to be debian or arch-based."
        echo "Please install 'Neovim' to execute this script."
        exit 1
    fi
fi

# Backup for existing Neovim config
if [ -f "$HOME/config/nvim/init.vim" ] ; then
    # Remove old vim config as backup to current folder
    mv ~/.config/nvim/init.vim ~/.config/nvim/init.vim.backup 
fi

# Remove old Neovim plugin manager
rm -f $HOME/.config/nvim/im/autoload/plug.vim


# Install new Neovim plugin manager
sh -c 'curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install new config
curl -fLo ./vimrc https://raw.githubusercontent.com/mopore/jni-dot-files/main/vim/vimrc
mv -v ./vimrc ~/.config/nvim/init.vim 

# For undodir plugin
mkdir -p ~/.vim/undodir

# Automatically lunch Plugin installation for referenced plugins in config.
nvim --headless +PlugInstall +qa
clear
echo "Neovim is ready!"
