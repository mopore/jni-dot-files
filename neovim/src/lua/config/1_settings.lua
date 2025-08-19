--   ____       _   _   _                 
--  / ___|  ___| |_| |_(_)_ __   __ _ ___ 
--  \___ \ / _ \ __| __| | '_ \ / _` / __|
--   ___) |  __/ |_| |_| | | | | (_| \__ \
--  |____/ \___|\__|\__|_|_| |_|\__, |___/
--                              |___/     
--

local M = {}

M.load = function()
    -- [[ Setting options ]]
    -- See `:help vim.o`
    -- NOTE: You can change these options as you wish!

    vim.o.cursorline = true -- Highlight the current line

    vim.o.expandtab = false -- Use real tabs instead of spaces
    vim.o.tabstop = 4
    vim.o.shiftwidth = 4
    vim.o.softtabstop = 4

    --  Not that the settings above can be overridden by a .editorconfig file
    --  
    --  Such a file is also placed in this project's `src` directory:
    --     [*.lua]
    --     indent_style = space
    --     indent_size = 2


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
    vim.o.colorcolumn = "80"

    -- Enable mouse mode
    vim.o.mouse = 'a'

    -- Sync clipboard between OS and Neovim.
    --  Remove this option if you want your OS clipboard to remain independent.
    --  See `:help 'clipboard'`
    vim.o.clipboard = 'unnamedplus'

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

    -- Set completeopt to have a better completion experience
    vim.o.completeopt = 'menuone,noselect'

    -- NOTE: You should make sure your terminal supports this
    vim.o.termguicolors = true

    -- Copilot -- JNI addition
    -- Discard current suggestion with <C-]>
    -- vim.keymap.set('n', '<leader>/',':Copilot status<CR>', { noremap = true, silent = true })

    -- [[ Highlight on yank ]]
    -- See `:help vim.highlight.on_yank()`
    local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
    vim.api.nvim_create_autocmd('TextYankPost', {
      callback = function()
	vim.highlight.on_yank()
      end,
      group = highlight_group,
      pattern = '*',
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

    -- Set the search NOT-highlight colors
    vim.api.nvim_set_hl(0, 'Search', { bg = '#7a4452', fg = '#23211f' })

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
