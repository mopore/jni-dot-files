#!/usr/bin/env bash
set -euo pipefail

if ! command -v sudo >/dev/null; then
    echo "Please update repos and install sudo."
    exit 1
fi

if ! command -v tmux >/dev/null 2>&1 ; then
	if command -v apt-get >/dev/null ; then
        sudo apt-get update && sudo apt-get upgrade -y
        sudo apt-get install tmux curl -y
    elif command -v pacman >/dev/null; then
        sudo pacman -Syu --noconfirm
        sudo pacman -S tmux curl --noconfirm
    else
    	echo "System does not seam to be debian or arch-based."
        echo "Please install 'tmux' to execute this script."
        exit 1
    fi
fi

# Set up tmux config
if [ -f "~/.tmux.conf" ] ; then
    # Remove old Tmux config as backup to current folder
    mv ~/.tmux.conf ~/tmux.conf.backup
fi
curl -fLo ./tmux.conf https://raw.githubusercontent.com/mopore/jni-dot-files/main/tmux/tmux.conf
mv ./tmux.conf ~/.tmux.conf

clear
echo "Tmux is read! Start with 'tmux a'."
exit 0