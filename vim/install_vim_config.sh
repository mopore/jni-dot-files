#!/usr/bin/env bash

set euo pipefail

if ! command -v vim >/dev/null 2>&1 ;
then
	if command -v apt-get; then
        if ! command -v sudo; then
            echo "Please apt-get update and install sudo"
            exit 1
        fi
        sudo apt-get update && sudo apt-get upgrade -y
        sudo apt-get install vim curl git -y
    else if command -v pacman; then
        if ! command -v sudo; then
            echo "Please install sudo"
            exit 1
        fi
        sudo pacman -Syu --noconfirm
        sudo pacman -S vim curl git --noconfirm
    else
    	echo "System does not seam to be debian or arch-based."
        echo "Please install 'vim' to execute this script."
        exit 1
    fi
fi

git clone https://github.com/mopore/jni-dot-files.git
cd jni-dot-files

md_viewer="less";
if command -v mdr >/dev/null 2>&1 ;
then
    md_viewer="mdr"
fi

clear
$md_viewer ./README.md

read -n 1 -s -r -p "Press any key to start installation..."
printf "\n"




# INSTALLATION FOR VIM
if [ -f "~/.vimrc" ] ; then
    # Remove old vim config as backup to current folder
    mv ~/.vimrc ./vimrc.backup
fi

# Remove old Vim plug
rm -f ~/.vim/autoload/plug.vim

# Install new Vim plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | /bin/bash

# Install new config
cp -v ./vimrc ~/.vimrc

# For undodir plugin
mkdir -p ~/.vim/undodir

echo "Run :PlugInstall in Vim"

exit 0
