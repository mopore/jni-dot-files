#!/usr/bin/env bash
set -euo pipefail

if ! command -v sudo >/dev/null; then
    echo "Please update repos and install sudo."
    exit 1
fi

if ! command -v zsh >/dev/null 2>&1 ; then
	if command -v apt-get >/dev/null ; then
        sudo apt-get update && sudo apt-get upgrade -y
        sudo apt-get install zsh curl git wget fzf -y
    elif command -v pacman >/dev/null; then
        sudo pacman -Syu --noconfirm
        sudo pacman -S zsh curl git wget fzf --noconfirm
    else
    	echo "System does not seam to be debian or arch-based."
        echo "Please install 'zsh' to execute this script."
        exit 1
    fi
fi


# Set Zsh as the default Shell
sudo chsh -s /usr/bin/zsh $(whoami)

# Install Oh my Zsh!
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | /bin/zsh

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Apply my configs
curl -fLo ~/.zshrc https://raw.githubusercontent.com/mopore/jni-dot-files/main/jni-shell/zshrc
curl -fLo ~/.p10k.zsh https://raw.githubusercontent.com/mopore/jni-dot-files/main/jni-shell/p10k.zsh

curl -fLo ~/.oh-my-zsh/custom/custom.zsh https://raw.githubusercontent.com/mopore/jni-dot-files/main/jni-shell/custom.zsh
if command -v pacman >/dev/null; then
    sed -i 's/# Arch-based /''/g' ~/.oh-my-zsh/custom/custom.zsh
fi
if command -v apt-get >/dev/null; then
    sed -i 's/# Debian-based /''/g' ~/.oh-my-zsh/custom/custom.zsh
fi

# Apply PowerLevel10k theme
rm -rf $HOME/.oh-my-zsh/custom/themes/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k


clear
echo "Zsh is ready now. Log out an log back in with Zsh!"
exit 0