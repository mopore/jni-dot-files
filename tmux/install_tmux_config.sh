#!/bin/bash

if ! command -v tmux >/dev/null 2>&1 ;
then
    echo "Please install 'tmux' to execute this script."
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

# Remove old Tmux config as backup to current folder
mv ~/.tmux.conf ./tmux.conf.backup

# Install tmux config
cp ./tmux.conf ~/.tmux.conf

echo "All done. Restart your shell session."

exit 0