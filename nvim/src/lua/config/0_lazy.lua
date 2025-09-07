--[[
 _                    
| |    __ _ _____   _ 
| |   / _` |_  / | | |
| |__| (_| |/ /| |_| |
|_____\__,_/___|\__, |
                |___/ 
--]]

local M = {}

M.load = function()

  -- Let's bootstrap our package manager
  local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      lazypath,
    }
  end
  vim.opt.rtp:prepend(lazypath)

  require('lazy').setup({
    spec = {
      -- Plugins can be found under under the "plugins" directory relative 
      -- to this folder
      { import = "config.plugins" },
    },
  }, {})

end

return M
