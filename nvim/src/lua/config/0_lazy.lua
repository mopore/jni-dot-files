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
      { import = "config.plugins" },

      -- NOTE: This is where your plugins related to LSP can be installed.
      --  The configuration is done below. Search for lspconfig to find it below.
      {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
          -- Automatically install LSPs to stdpath for neovim
          { 'williamboman/mason.nvim', config = true },
          'williamboman/mason-lspconfig.nvim',

          -- Useful status updates for LSP
          -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
          { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

          -- Additional lua configuration, makes nvim stuff amazing!
          'folke/neodev.nvim',
        },
      },

    },
  }, {})

end

return M
