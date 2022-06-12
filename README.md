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
This repository holds my personal dot config files to configure and applications like Vim, Tmux and
others with installation scripts.

Supported configurations:
* Vim
* GTile Gnome Extension

# What's the motivation?
The aim is to get a system quicker configured to a state that I like it to be.

# How to use
There is a subfolder for each app (e.g. `./vim` for Vim).
Each subfolder holds at least one app related config file and an installation script.
View the config file(s) and and use the corresponding installation script to apply the configuration
to your system.


# Install Scripts
You find the source code under each subfolder.
## Vim
To install and configure vim with my settings:
```
curl -sSL https://raw.githubusercontent.com/mopore/jni-dot-files/main/vim/install_vim_config.sh | /bin/bash
```


## Tmux
To install and configure Tmux:
```
curl -sSL https://raw.githubusercontent.com/mopore/jni-dot-files/main/tmux/install_tmux_config.sh  | /bin/bash
```

## Optional
Install "mdr" as a Markdown renderer to have a better viewing experiencing during installation
Under arch-based distros:
```
pacman -S mdr
```

## Testing in a Docker container
### Debian-based
Create the container.
Note that with '--rm' the container will be automatically removed after exiting.
```
docker run --rm -it debian /bin/bash
```
In container
```
apt-get update && apt-get upgrade -y && apt-get install -y sudo curl
```

### Manjaro (arch-like)
```
docker run --rm -it manjarolinux/base /bin/bash
```



# Release History

## v0.1.0
- Vim configuration added.
- GTile Gnome extension added.
- Tmux configuration added.
- Alacritty terminal added.