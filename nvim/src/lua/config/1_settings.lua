--   ____       _   _   _                 
--  / ___|  ___| |_| |_(_)_ __   __ _ ___ 
--  \___ \ / _ \ __| __| | '_ \ / _` / __|
--   ___) |  __/ |_| |_| | | | | (_| \__ \
--  |____/ \___|\__|\__|_|_| |_|\__, |___/
--                              |___/     
--

local M = {}

M.load = function()

  vim.o.expandtab = false -- Use real tabs instead of spaces
  vim.o.tabstop = 4
  vim.o.shiftwidth = 4
  vim.o.softtabstop = 4
  --
  --  Note: Above settings can be overridden by a .editorconfig file
  --  
  --  Such a file is also placed in this project's `src` directory:
  --     [*.lua]
  --     indent_style = space
  --     indent_size = 2

  -- Highlight the current line
  vim.o.cursorline = true

  -- Set highlight on search
  vim.o.hlsearch = true

  -- Rounded borders
  vim.o.winborder = 'rounded'

  -- Do not wrap lines -- JNI addition
  vim.o.wrap = false

  -- Make line numbers default and relative -- JNI addition
  vim.wo.number = true
  vim.wo.relativenumber = true

  -- Show the tab bar at the top (2 = always) -- JNI addition
  vim.o.showtabline = 2

  -- Show a column after x digits -- JNI addition
  vim.o.colorcolumn = "100"

  -- Enable mouse mode
  vim.o.mouse = 'a'

  -- Sync clipboard between OS and Neovim.
  --  Remove this option if you want your OS clipboard to remain independent.
  --  See `:help 'clipboard'`
  vim.o.clipboard = 'unnamedplus'
  -- OSC 52 is natively supported by Neovim since v0.10 and allows copying to the clipboard 
  -- which (when running in a TMUX session) can be propagated to the TMUX host.
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }

  -- Enable break indent
  vim.o.breakindent = true

  -- Save undo history
  vim.o.undofile = true

  -- Case-insensitive searching UNLESS \C or capital in search
  vim.o.ignorecase = true
  vim.o.smartcase = true

  -- Keep signcolumn on by default
  vim.wo.signcolumn = 'yes'

  -- Decrease update time
  vim.o.updatetime = 250
  vim.o.timeoutlen = 300

  vim.o.completeopt = 'menuone,noselect'

  vim.o.termguicolors = true

  -- Highlight on yank
  -- 
  local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
  vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
      vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
  })

  -- Ensure systemd filetype is triggered by file postfix
  --
  vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "*.service", "*.socket", "*.target", "*.timer" },
    callback = function()
      vim.bo.filetype = "systemd"
    end,
  })

  -- Treat .env files as "dotenv" instead of "sh"
  vim.filetype.add({
    filename = {
      [".env"] = "dotenv",
    },
    pattern = {
      [".*%.env%..+"] = "dotenv", -- .env.local, .env.production, etc.
    },
  })

  -- Setting the Neovim background color to transparent (regardless of the theme)
  vim.api.nvim_set_hl(0, 'Normal', { bg = '#000911' })
  vim.api.nvim_set_hl(0, 'NormalNC', { bg = '#000911' })
  vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = '#000911' })
  vim.api.nvim_set_hl(0, 'VertSplit', { bg = '#000911' })

  -- Set the line number colors
  vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#7C8795' })
  vim.api.nvim_set_hl(0, 'LineNr', { fg = '#dcb771', bold = true })
  vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#95817C' })

  -- Set the background of the "selection" in visual mode
  vim.api.nvim_set_hl(0, 'Visual', { bg = '#88475b' })

  -- Set the search NOT-highlight colors
  vim.api.nvim_set_hl(0, 'Search', { bg = '#7a4452', fg = '#23211f' })

  -- Set the color column (the indicator after 80/100 characters)
  vim.api.nvim_set_hl(0, 'ColorColumn', { bg = '#100819' })  -- very dark purple

  -- Split to the right by default
  vim.opt.splitright = true

  -- Activate virtual text handler (which is disabled by default)
  vim.diagnostic.config({
    virtual_text = true,

    virtual_lines = {
      current_line = true,
    },
  })

end

return M
