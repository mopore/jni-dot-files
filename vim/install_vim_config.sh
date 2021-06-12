#!/bin/bash

if ! command -v vim >/dev/null 2>&1 ;
then
    echo "Please install 'vim' to execute this script."
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

# Remove old Vim plug
rm -f ~/.vim/autoload/plug.vim

# Install new Vim plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Remove of vim config as backup to current folder
mv ~/.vimrc ./vimrc.backup
cp -v ./vimrc ~/.vimrc

echo "Run :PlugInstall in Vim"

exit 0