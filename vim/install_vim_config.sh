#!/usr/bin/env bash 
set -euo pipefail

if ! command -v sudo >/dev/null; then
    echo "Please update repos and install sudo."
    exit 1
fi

if ! command -v vim >/dev/null 2>&1 ; then
	if command -v apt-get >/dev/null ; then
        sudo apt-get update && sudo apt-get upgrade -y
        sudo apt-get install vim curl git -y
    elif command -v pacman >/dev/null; then
        sudo pacman -Syu --noconfirm
        sudo pacman -S vim curl git --noconfirm
    else
    	echo "System does not seam to be debian or arch-based."
        echo "Please install 'vim' to execute this script."
        exit 1
    fi
fi

# Backup of existing Vim config
if [ -f "$HOME/vimrc" ] ; then
    # Remove old vim config as backup to current folder
    mv ~/.vimrc ~/vimrc.backup
fi

# Remove old Vim plugin manager
rm -f ~/.vim/autoload/plug.vim

# Install new Vim plugin manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install new vimrc
curl -fLo ./vimrc https://raw.githubusercontent.com/mopore/jni-dot-files/main/vim/vimrc
mv -v ./vimrc ~/.vimrc

# For undodir plugin
mkdir -p ~/.vim/undodir

# Automatically lunch Plugin installation for referenced plugins in config.
vim -c ':PlugInstall | quit | quit'
clear
echo "Vim is ready!"

exit 0
