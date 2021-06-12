#!/bin/bash

if ! command -v alacritty >/dev/null 2>&1 ;
then
    echo "Please install 'alacritty' to execute this script."
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

if [ -f "~/.alacritty.yml" ] ; then
    # Remove old alacritty config as backup to current folder
    mv ~/.alacritty.yml ./alacritty.backup
fi

if [ ! -d "~/.config/alacritty" ] ; then
    mkdir -p ~/.config/alacritty
fi

if [ -f "~/.config/alacritty/alacritty.yml" ] ; then
    # Remove old alacritty config as backup to current folder
    mv ~/.config/alacritty/alacritty.yml ./alacritty.backup
fi

cp ./alacritty.source.yml ./alacritty.yml

# Change Alacritty to launch tmux on start when requested
read -p "Change launch command to start Tmux? [N/y] " INPUT
INPUT_CLOUD_CONTROL=$( echo "${INPUT,,}" )
if [ "$INPUT_CLOUD_CONTROL" = "y" ] ;
then 
    sed -i 's/# @shell args:/args:/g' ./alacritty.yml
    sed -i 's/# @shell   - -c/  - -c/g' ./alacritty.yml
    sed -i 's/# @shell   - tmux attach/  - tmux attach/g' ./alacritty.yml
    echo "Launch command will call 'tmux a'"
fi

# Install alacritty config
mv ./alacritty.yml ~/.config/alacritty/alacritty.yml

echo "All done. Restart your shell session."

exit 0