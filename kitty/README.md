KITTY ALACRITTY CONFIGURATION
=============================

This script works only on user level and must not be executed with 'sudo'.

## What it will perform
* Moves an existing alacritty config to `./kitty.backup`
* Installs the tmux config in the current folder and puts it to `~/.config/kitty/kitty.conf`
* If necessary, a `~/.config/kitty` folder will be created.

## What you will have to do post installation
* Install 'JetBrains Mono' fonts (located in subfolder).

## Installation on MacOS
- Copy to `~/.local/share/fonts` and 
- then run `sudo fc-cache -fr`

## Good to know
* Ctrl + n creates a new instance

