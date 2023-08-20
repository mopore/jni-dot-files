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


# Application

## Neovim

| Shortcut              | Description |
| --------------------- | --- |
| `Space` + `s` + `h`   | Search help |
| `Space` + `g` + `f`   | Search in git files |
| `Ctrl` & `f`          | Search text in current file/buffer |
| `Space` + `Space`     | Show current open files/buffers |
| `Space` + `?`         | Show recently opened files/buffers |
| `Ctrl` & `t`          | Open in Tab |
| `g` + `t`             | Next tab |
| `g` + `T`             | Previous tab |
| `Ctrl` & `w` + `c`    | Close current window (on top) |
| `Ctrl` & h,j,k,l      | Move between windows |

### LSP specific shortcuts

| Shortcut              | Description |
| --------------------- | --- |
| `g` + `d`             | Go to definition |
| `g` + `r`             | Find references |
| `g` + `I`             | Go to implementation(s) |
| `Space` + `d` + `s`   | Search symbols in current file/buffer |
| `Alt` & `k`           | Show documentation |
| `Ctrl` + (`space`)*   | incrementally increases the selection. | 
| `Space` + `q`         | Show diagnostics |
| `Space` + `e`         | Show details |
| `]` + `d`             | Next diagnostics |
| `[` + `d`             | Prev diagnostics |

`:Format` will format the current buffer.

Use `:Telescope keymaps` to show shortcuts.
`:Telescope help_tags` offers a fuzzy find over all help files.

Type `:Mason` to open install additional language support.
Use `i` to install and `u` to uninstall.

### Github Copilot

| Shortcut              | Description |
| --------------------- | --- |
| `Space` + `/` + `/`   | Toggle comment of current line |
| `Space` + `/`         | Toggle comment of selection |


### Diagnostics from Language Server for errors and warnings

| Shortcut              | Description |
| --------------------- | --- |
| `Space` + `q`         | Toggles diagnostics window |
| `]` + `d`             | Next diagnostics |
| `[` + `d`             | Prev diagnostics |


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
