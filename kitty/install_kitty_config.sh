#!/usr/bin/env bash

if ! command -v kitty >/dev/null 2>&1 ;
then
    echo "Please install 'kitty' to execute this script."
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

if [ -f "~/.kitty.conf" ] ; then
    # Remove old kitty config as backup to current folder
    mv ~/.kitty.conf ./kitty.backup
fi

if [ ! -d "~/.config/kitty" ] ; then
    mkdir -p ~/.config/kitty
fi

if [ -f "~/.config/kitty/kitty.conf" ] ; then
    # Remove old kitty config as backup to current folder
    mv ~/.config/kitty/kitty.conf ./kitty.backup
fi

cp ./kitty.source.conf ./kitty.conf


# Install kitty config
mv ./kitty.conf ~/.config/kitty/kitty.conf

echo "All done. Restart your shell session."

exit 0