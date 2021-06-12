JNI ALACRITTY CONFIGURATION
===========================

This script works only on user level and must not be executed with 'sudo'.

## What it will perform
* Moves an existing alacritty config to `./alacritty.backup`
* Installs the tmux config in the current folder and puts it to `~/.config/alacritty/alacritty.yml`
* If necessary, an old config will be removed from `~/.alacritty.yml` and `~/.config/alacritty` folder will be created.
* User will be prompted if he wants to start tmux with alacritty.

## What you will have to do post installation
* Install 'MesloLGS NF' fonts (regular, bold, italic, bold italic) as provided in this folder.
* Check if you want to set 'transparent' window decorations (when on MacOS)

## Configuration Overview
* Ctrl + n creates a new instance
* Sets MesloLGS NF as default font.
* Optional: Start a 'tmux attach' on Alacritty launch.
