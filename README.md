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

# Motivation
The aim is to get a system quicker configured and gain general productivity.


# Shortcuts and Command Overview

## Neovim Shortcuts

### Search
| Shortcut                | Description                        |  
| ----------------------- | ---                                |
| `Space` + `Space`       | Show current open files/buffers    |
| `Ctrl` & `f`            | Search text in current file/buffer |
| `Space` + `s` + `h`     | Search help                        |
| `Space` + `s` + `Space` | Search files (smart)              |
| `Space` + `s` + `f`     | Search files (by name)             |
| `Space` + `s` + `g`     | Search files (via grep)            |
| `Space` + `g` + `f`     | Search in git files                |
| `Space` + `?`           | Show recently opened files/buffers |

smart search: If the cd is in a git repo, the search is in git file
search mode otherwise in file search mode.

### Tabs

| Shortcut               | Description                        |
| ---------------------- | ---                                |
| `Ctrl` & `t`           | Open in Tab                        |
| `g` + `t`              | Next tab                           |
| `g` + `T`              | Previous tab                       |

### Windows

| Shortcut               | Description                        |
| ---------------------- | ---                                |
| `Ctrl` & `w` + `x`     | Close current window               |
| `Ctrl` & `w` + h,j,k,l | Move between windows               |

### Folding

| Shortcut               | Description                        |
| ---------------------- | ---                                |
| `z` + `f`              | Create new folding zone            |
| `z` + `a`              | Toggle folding zone                |
| `z` + `d`              | Delete folding zone                |

### LSP Diagnostics

| Shortcut              | Description |
| --------------------- | --- |
| `Space` + `c` + `a`   | "[C]ode [A]ction" - Perform action for issue |
| `Space` + `s` + `s`   | Search symbols (e.g., props or methods) |
| `]` + `d`             | Next diagnostics |
| `[` + `d`             | Prev diagnostics |
| `Space` + `r` + `n`   | [R]e[n]ame all references of symbol under cursor |

### LSP Navigation

| Shortcut              | Description |
| --------------------- | --- |
| `g` + `d`             | Go to definition |
| `g` + `r`             | Find references |
| `g` + `I`             | Go to implementation(s) |
| `Alt` & `k`           | Show documentation under cursor |
| `Ctrl` + (`space`)*   | incrementally increases the selection. | 

### Diff this
When two windows are open (side by side) `Space` + `d` + `t` will diff the
currently opened windows.


### Misc
`:Format` will format the current buffer.

Use `:Telescope keymaps` to show shortcuts.
`:Telescope help_tags` offers a fuzzy find over all help files.

Type `:Mason` to open install additional language support.
Use `i` to install and `u` to uninstall.


### Comments

| Shortcut              | Description |
| --------------------- | --- |
| `g` + `c` + `c`   | Toggle comment of current line |
| `g` + `c`         | Toggle comment of selection |


### Surround-Plugin 
https://github.com/tpope/vim-surround
* Visualize a word and press `S` + `"` to surround it with `"`.
* To chance an existing surrounding with () to [] , press `c` + `s` + `(` + `[`.


### Undotree
Use `Space` + `u` to open the undotree.


### nvim-tree
https://github.com/kyazdani42/nvim-tree.lua
Besides browsing offers many options to manipulate files and folders.

| Shortcut              | Description |
| --------------------- | --- |
| `Space` + `e`         | Toggle nvim-tree window |
| `g` + `?`             | Show Keymappings |
| `Ctrl` & `t`          | Open in new tab  |
| `Ctrl` & `v`          | Open in left & right split  |
| `Ctrl` & `x`          | Open in up & down split |
| `Enter`               | Enters file |


### Fugitive (Git Plugin)
https://github.com/tpope/vim-fugitive

Use `:G <command>` to show the git status.
Do not forget to SAVE the file before trying to add it to the staging area.
To stage a file `:G add -A`.
For committing us `:G commit`.
To push use `:G push`.


## TMUX

| Shortcut                  | Description |
| ------------------------- | --- |
| `Ctrl` & `a` + `-`        | Split up & down |
| `Ctrl` & `a` + `\|`       | Split left & right |
| `Ctrl` & `a` + `x`        | Close current pane |
| `Ctrl` & `a` + `z`        | Toggle current pane is 100% |
| `Ctrl` & `a` + h,j,k,l    | Move to pane in direction |
| `Ctrl` & `a` + h,j,k,l    | Resizing: Move boder in direction |
| `Ctrl` & `a` + `Space`    | Toggle layouts |


# Setup
There is a subfolder for each app (e.g. `./kitty` for Kitty).
Each subfolder holds at least one app related config file and potentially an installation script.
View the config file(s) and and use the corresponding installation script to apply the configuration
to your system.

## Install Scripts
If available you find install and setup scripts under each subfolder.

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
