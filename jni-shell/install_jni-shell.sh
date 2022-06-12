#!/usr/bin/env bash
set -euo pipefail

if ! command -v sudo >/dev/null; then
    echo "Please update repos and install sudo."
    exit 1
fi

if ! command -v zsh >/dev/null 2>&1 ; then
	if command -v apt-get >/dev/null ; then
        sudo apt-get update && sudo apt-get upgrade -y
        sudo apt-get install zsh curl git wget -y
    elif command -v pacman >/dev/null; then
        sudo pacman -Syu --noconfirm
        sudo pacman -S zsh curl git wget --noconfirm
    else
    	echo "System does not seam to be debian or arch-based."
        echo "Please install 'zsh' to execute this script."
        exit 1
    fi
fi


# Set Zsh as the default Shell
sudo chsh -s /usr/bin/zsh $USER

# Install Oh my Zsh!
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | /bin/zsh

# Apply my configs
git clone https://github.com/mopore/jni-dot-files.git

cp -fv jni-dot-files/jni-shell/zshrc ~/.zshrc
cp -fv jni-dot-files/jni-shell/custom.zsh ~/.oh-my-zsh/custom/



# Apply PowerLevel10k theme
rm -rf ~/.oh-my-zsh/custom/themes/powerlevel10k
cp -rv jni-dot-files/jni-shell/powerlevel10k/ ~/.oh-my-zsh/custom/themes/



# Clean up
rm -rf ./jni-dot-files



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