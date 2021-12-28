#!/bin/bash

if ! command -v nvim >/dev/null 2>&1 ;
then
    echo "Please install 'nvim' to execute this script."
    exit 1
fi


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
if [ -f "~/.config/nvim/init.vim" ] ; then
    # Remove old vim config as backup to current folder
    mv ~/.config/nvim/init.vim ~/.config/nvim/init.vim.backup 
fi

# Remove old Vim plug
rm -f $HOME/.config/nvim/im/autoload/plug.vim

# Install new Vim plug
sh -c 'curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install new config
cp -v ./vimrc ~/.config/nvim/init.vim 

echo "Run :PlugInstall in Vim"

exit 0
