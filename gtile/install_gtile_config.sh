#!/bin/bash

if ! command -v dconf >/dev/null 2>&1 ;
then
    echo "Please install 'dconf' to execute this script."
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

# Backup existing settings
dconf dump /org/gnome/shell/extensions/gtile/ > ./gtile_settings.backup
echo "Back created to ./gtile_settings.backup"

# Load settings
dconf load /org/gnome/shell/extensions/gtile/ < ./gtile_settings.input

echo "All done."

exit 0