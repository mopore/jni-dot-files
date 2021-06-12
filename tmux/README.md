J N I   T M U X   C O N F I G U R A T I O N 
===========================================

This script works only on user level and must not be executed with 'sudo'.

## What it will perform
* Moves an existing tmux config to `./tmux.conf.backup`
* Installs the tmux config in the current folder and puts it to `~/.tmux.conf`

## What you will have to do post installation
Install xclip to be able to use copy to clipboard correctly (when on Linux).
You need to restart your shell session.

## Configuration Overview

### General
* Changes the prefix to <Ctrl> + a
* Installs visual enhancements
* Sets the tmux colors to be compatible with Alacritty
* Use Prefix + vim keys to navigate over panes.
* Use <Alt> + h or l to switch windows
* Use Prexfix + | to split horizontally
* Use Prefix + - to split vertically
* Removes necessatyi to confirm pane closing
* Create a new session when no session to attach (instead of throwing error message)
