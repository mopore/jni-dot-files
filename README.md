```
████████▄   ▄██████▄      ███             ▄████████  ▄█   ▄█          ▄████████    ▄████████ 
███   ▀███ ███    ███ ▀█████████▄        ███    ███ ███  ███         ███    ███   ███    ███ 
███    ███ ███    ███    ▀███▀▀██        ███    █▀  ███▌ ███         ███    █▀    ███    █▀  
███    ███ ███    ███     ███   ▀       ▄███▄▄▄     ███▌ ███        ▄███▄▄▄       ███        
███    ███ ███    ███     ███          ▀▀███▀▀▀     ███▌ ███       ▀▀███▀▀▀     ▀███████████ 
███    ███ ███    ███     ███            ███        ███  ███         ███    █▄           ███ 
███   ▄███ ███    ███     ███            ███        ███  ███▌    ▄   ███    ███    ▄█    ███ 
████████▀   ▀██████▀     ▄████▀          ███        █▀   █████▄▄██   ██████████  ▄████████▀  
                                                         ▀                                                                                          
```

Source for ASCII-fonts: https://www.coolgenerator.com/ascii-text-generator
(Font: Delta Corps Priest 1


# What is this?
This repository holds my personal dot config files to configure and/or install my favorite apps.
It also includes a script to setup my shell environment with ZSH, Oh my ZSH! and PowerLevel10k.

Supported configurations:
* Shell setup with ZSH, Oh my ZSH!, PowerLevel10k [README](./jni-shell/README.md)
* Neovim [README](./neovim/README.md)
* kitty [README](./kitty/README.md)
* TMUX [README](./tmux/README.md)
* GTile Gnome Extension [README](./gtile/README.md)
* Vim [README](./vim/README.md)
* alacritty [README](./alacritty/README.md)

# What's the motivation?
The aim is to get a system quicker configured to a state that I like it to be.

# How to use
There is a subfolder for each app (e.g. `./kitty` for Kitty).
Each subfolder holds at least one app related config file and potentially an installation script.
View the config file(s) and and use the corresponding installation script to apply the configuration
to your system.


# Install Scripts
You find the source code under each subfolder.

## JNI Shell (ZSH, Oh my ZSH!, PowerLevel10k)
To install and configure the shell:
```
curl -sSL https://raw.githubusercontent.com/mopore/jni-dot-files/main/jni-shell/install_jni-shell.sh | /bin/bash
```

## Tmux
To install and configure Tmux:
```
curl -sSL https://raw.githubusercontent.com/mopore/jni-dot-files/main/tmux/install_tmux_config.sh  | /bin/bash
```

## Vim
To install and configure vim with my settings:
```
curl -sSL https://raw.githubusercontent.com/mopore/jni-dot-files/main/vim/install_vim_config.sh | /bin/bash
```

## Optional
Install "mdr" as a Markdown renderer to have a better viewing experiencing during installation
Under arch-based distros:
```
pacman -S mdr
```


# Release History

## v0.2.0
- Add Neovim config.
- Add configuration for kitty.
- Remove neovim from vim configuration.
- Update readme files.


## v0.1.0
- Vim configuration added.
- GTile Gnome extension added.
- Tmux configuration added.
- Alacritty terminal added.