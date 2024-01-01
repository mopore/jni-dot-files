-- This is a local plugin to add more customization to my Neovim setup.
--
-- It will be loaded by the main init.lua file like this::
-- JNI_ADDITIONS = require("jni_additions")
-- JNI_ADDITIONS.load()
--
-- For an example of a remote plugin see https://github.com/mopore/example_lua.nvim

local M = {}

M.load = function()
    -- Setting the Neovim background color to transparent (regardless of the theme)
    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'VertSplit', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'Comment', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'Constant', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'Special', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'Identifier', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'Statement', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'PreProc', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'Type', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'Underlined', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'Todo', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'String', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'Function', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'Conditional', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'Repeat', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'Operator', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'Structure', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'LineNr', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'NonText', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'CursorLineNr', { bg = 'none' })

    -- Set the line number colors
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='#7C8795' })
    vim.api.nvim_set_hl(0, 'LineNr', { fg='#dcb771', bold=true })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='#95817C' })

    -- Setup the comment plugin
    require('Comment').setup({
        toggler = {
            ---Line-comment toggle keymap
            line = '<leader>//',
        },
        opleader = {
            ---Line-comment keymap
            line = '<leader>/',
        },
    })

    -- Split to the right by default
    vim.opt.splitright = true

    -- Toggle undotree to <leader>u
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

    -- Use 'jj' and 'kk' to escape to normal mode
    vim.keymap.set('i', 'jj', '<Esc>', { noremap = true, silent = true })
    vim.keymap.set('i', 'kk', '<Esc>', { noremap = true, silent = true })

    -- Split line under current cursor with Shift + K (Capital)
    vim.keymap.set('n', 'K', 'i<CR><Esc>k$', { noremap = true, silent = true })

    -- breaking the undo chain on each , . ? ;
    vim.keymap.set('i', ',', ',<c-g>u', { noremap = true, silent = true })
    vim.keymap.set('i', '.', '.<c-g>u', { noremap = true, silent = true })
    vim.keymap.set('i', '!', '!<c-g>u', { noremap = true, silent = true })
    vim.keymap.set('i', '?', '?<c-g>u', { noremap = true, silent = true })

    -- Keeping the cursor centered when using search and joining lines.
    vim.keymap.set('n', 'n', 'nzzzv', { noremap = true, silent = true })
    vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true, silent = true })
    vim.keymap.set('n', 'J', 'mzJ`z', { noremap = true, silent = true })

    -- While 'ZZ' is ':wq' and 'ZQ' is ':q!' and 'ZW' should be ':w'
    vim.keymap.set('n', 'ZW', ':w<CR>', { noremap = true, silent = true })

    -- Lua Copilot Configuration
    require('copilot').setup({
        panel = {
            enabled = false,
            -- auto_refresh = false,
            -- keymap = {
            --   jump_prev = "[[",
            --   jump_next = "]]",
            --   accept = "<CR>",
            --   refresh = "gr",
            --   open = "<M-CR>"
            -- },
            -- layout = {
            --   position = "bottom", -- | top | left | right
            --   ratio = 0.4
            -- },
        },
        suggestion = {
            enabled = true,
            auto_trigger = true,
            debounce = 75,
            keymap = {
            -- accept = "<M-CR>",  -- Alt + Enter
            accept = "<S-Tab>",  -- Shift + Tab
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
            },
        },
        filetypes = {
            yaml = false,
            markdown = true,
            help = false,
            gitcommit = false,
            gitrebase = false,
            hgcommit = false,
            svn = false,
            cvs = false,
            ["."] = false,
        },
        copilot_node_command = 'node', -- Node.js version must be > 16.x
        server_opts_overrides = {},
    })

    -- NvimTree Configuration
    -- empty setup using defaults
    require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
            width = 30,
        },
        renderer = {
            group_empty = true,
        },
        filters = {
            dotfiles = true,
        },
    })

    -- Toggle undotree to <leader>u
    vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle)
end

return M
