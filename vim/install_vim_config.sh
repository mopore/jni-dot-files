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

# rm -rf jni-dot-files
# git clone https://github.com/mopore/jni-dot-files.git
# cd jni-dot-files/vim

# md_viewer="less"

# if command -v mdr >/dev/null 2>&1 ; then
#     md_viewer="mdr"
# fi

# clear
# $md_viewer ./README.md

# read -n 1 -s -r -p "Press any key to start installation..."
# printf "\n"


# INSTALLATION FOR VIM
if [ -f "$HOME/vimrc" ] ; then
    # Remove old vim config as backup to current folder
    mv ~/.vimrc ./vimrc.backup
fi

# Remove old Vim plug
rm -f ~/.vim/autoload/plug.vim

# Install new Vim plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install new vimrc
curl -fLo ./vimrc https://raw.githubusercontent.com/mopore/jni-dot-files/main/vim/vimrc
mv -v vimrc ~/.vimrc

# For undodir plugin
mkdir -p ~/.vim/undodir
# vim +PluginInstall +qall

echo "Vim is ready!"
exit 0
