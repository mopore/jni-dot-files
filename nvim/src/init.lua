--[[

Kickstart Guide:

I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.

In addition, I have some `NOTE:` items throughout the file.
These are for you, the reader to help understand what is happening. Feel free to delete
them once you know what you're doing, but they should serve as a guide for when you
are first encountering a few different constructs in your nvim config.

I hope you enjoy your Neovim journey,
- TJ
--]]

-- Setting the leader key to "Space"
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("config.0_lazy").load()
require("config.1_plugin_conf").load()
require("config.2_settings").load()
require("config.3_keymap").load()
require("jni_additions").load()
