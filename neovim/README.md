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
Also the config takes input from [ThePrimeagen's Neovim config](https://github.com/ThePrimeagen/init.lua)

## Optional Pre-Requirements:
Have ripgrep installed to have telescopre work faster.
Run `brew install ripgrep` on MacOS or `sudo pacman -S ripgrep` on Ubuntu.

## Install
This directory includes an interactive script `install.sh` to create a backup of the existing 
configuration and **optionally** installs this project's neovim config. The backups are stored
in `$HOME/.config/nvim_backup`

## Restore from backup
The interactive script `restore_from_backup.sh` can be used to restore a Neovim configuration 
from an existing backup stored in `$HOME/.config/nvim_backup`. The script will ask to overwrite the 
current configuration.

## Old Vim Config
The sub directory `imported_from_vim` includes an `init.vim` file representing my former vim config
as of 2023-08-15. This file is only for lookup and migration purposes present.

## Custom Local Plugin
This configuration comes with a custom local neovim plugin "jni_additions". This
plugin encapsulates most of the JNI specific configurations and mappings.
The plugin also showcases a user command "TestMe" which calls a local program
"helloworld" (see the corresponding folder) and demonstrates communication via
JSON as an command line argument (in) and the standard output (out).
For parsing the JSON an additional library (lunajson) is packages with the plugin.
