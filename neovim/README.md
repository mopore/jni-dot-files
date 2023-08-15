 ```
._   _                 _             _  ___      _        _             _   
| \ | | ___  _____   _(_)_ __ ___   | |/ (_) ___| | _____| |_ __ _ _ __| |_ 
|  \| |/ _ \/ _ \ \ / / | '_ ` _ \  | ' /| |/ __| |/ / __| __/ _` | '__| __|
| |\  |  __/ (_) \ V /| | | | | | | | . \| | (__|   <\__ \ || (_| | |  | |_ 
|_| \_|\___|\___/ \_/ |_|_| |_| |_| |_|\_\_|\___|_|\_\___/\__\__,_|_|   \__|
                                                                            
```

A Neovim configuration based on [TJ DeVries's](https://github.com/tjdevries) video on 
[Effective Neovim: Instant IDE](https://www.youtube.com/watch?v=stqUbv-5u2s) and the corresponding
[kickstart.nvim script](https://github.com/nvim-lua/kickstart.nvim).
The config aims to include the existing JNI VIM configuration from this repository (at least until 
2023-09-15).

# Directory structure

## Backup and optional cleanup
This directory includes an interactive script `backup_clean.sh` to create a backup of the existing 
configuration and **optionally** clean up Neovim's current config directory. The backups are stored
in `$HOME/.config/nvim_backup`

## Restore from backup
The interactive script `restore.sh` can be used to restore a Neovim configuration from an existing 
backup stored in `$HOME/.config/nvim_backup`. The script will ask to overwrite the current
configuration.

## Old Vim Config
The sub directory `imported_from_vim` includes an `init.vim` file representing my former vim config
as of 2023-08-15. This file is only for lookup and migration purposes present.


# Setup

## JNI config
1. Use the `clean_backup.sh` script to create a backup of the current configuration and clean the 
directory
2. Copy the `init.lua` file to your config folder `cp ./init.lua ~/.config/nvim/init.lua`
3. Start neovim with `nvim`.


## Base configuration based on TJ DeVries's kickstart.nvim
1. Use the `clean_backup.sh` script to create a backup of the current configuration and clean the 
directory 
2. Curl the kickstart.nvim init.lua file to the config directory
`curl https://raw.githubusercontent.com/nvim-lua/kickstart.nvim/master/init.lua --output ~/.config/nvim/init.lua`
3. Start neovim with `nvim`.

```
./clean_backup.sh

...

Old neovim config backed up to /home/jni/.config/nvim_backup/dot_config_slash_nvim_2023-08-15_11-33-21.zip
Also clean the config directory? (y/N)
y

...

curl https://raw.githubusercontent.com/nvim-lua/kickstart.nvim/master/init.lua --output ~/.config/nvim/init.lua
```

After the initial start it might be necesary to trigger `:Copilot auth` to authenticate with GitHub.


# Getting started

## Examples
`space` + `space` show currently opened files
`space` + `f` + `s` to search for files under current directory in below.
`space` + `d` + `s` to search for symbols in the current file.
`space` + `?` to open recently opened files
`gd` to go to definition
`gr` to find references

`space` + `e` shows 'diagnostics' (errors, warnings, etc.)


## Get help
`:Telescope keymaps` will open an overview of keymaps you can search for.
`:Telescope help_tags` offers a fuzzy find over all help files.

## Install language support via Mason
Type `:Mason` to open the Mason menu and install language support.
Use `i` to install and `u` to uninstall.


## Telescope
`Crtrl` and `space` incrementally increases the selection.

## Working wiht tabs
Open a file list ant hit `Ctrl` and `t` to open a new tab.
move left and right with `gt` and `gT`. 