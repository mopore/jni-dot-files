 ```
 _   _                 _           
| \ | | ___  _____   _(_)_ __ ___  
|  \| |/ _ \/ _ \ \ / / | '_ ` _ \ 
| |\  |  __/ (_) \ V /| | | | | | |
|_| \_|\___|\___/ \_/ |_|_| |_| |_|
```

The Neovim configuration is based on [TJ DeVries](https://github.com/tjdevries) video on 
[Effective Neovim: Instant IDE](https://www.youtube.com/watch?v=stqUbv-5u2s) and the corresponding
[kickstart.nvim script](https://github.com/nvim-lua/kickstart.nvim).
And also aims to include the existing VIM configuration from this repository (at least until 
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

## Vim Config
The sub directory `imported_from_vim` includes an `init.vim` file representing my former vim config
as of 2023-08-15. This file is only for lookup and migration purposes present.
