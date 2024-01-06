-- This is a local plugin to add more customization to my Neovim setup.
--
-- It will be loaded by the main init.lua file like this::
-- JNI_ADDITIONS = require("jni_additions")
-- JNI_ADDITIONS.load()
--
-- This
-- For an example of a remote plugin see https://github.com/mopore/example_lua.nvim

local M = {}

M.load = function()

    --   ____       _   _   _                 
    --  / ___|  ___| |_| |_(_)_ __   __ _ ___ 
    --  \___ \ / _ \ __| __| | '_ \ / _` / __|
    --   ___) |  __/ |_| |_| | | | | (_| \__ \
    --  |____/ \___|\__|\__|_|_| |_|\__, |___/
    --                              |___/     
    --
    -- Setting the Neovim background color to transparent (regardless of the theme)
    vim.api.nvim_set_hl(0, 'Normal', { bg = '#000911' })
    vim.api.nvim_set_hl(0, 'NormalNC', { bg = '#000911' })
    vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = '#000911' })
    vim.api.nvim_set_hl(0, 'VertSplit', { bg = '#000911' })

    -- Set the line number colors
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#7C8795' })
    vim.api.nvim_set_hl(0, 'LineNr', { fg = '#dcb771', bold = true })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#95817C' })

    -- Set the search highlight colors
    vim.api.nvim_set_hl(0, 'Search', { bg = '#6b4e34', fg = '#23211f' })

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

    -- Remapping 'Ctrl-w c' to 'Ctrl-w x' for closing the current window
    vim.api.nvim_set_keymap('n', '<C-w>x', '<C-w>c', {
        noremap = true,
        silent = true,
        desc = 'Close current window',
    })

    -- Remapping 'Ctrl-w r' to 'Ctrl-w w' for swapping window with the next
    vim.api.nvim_set_keymap('n', '<C-w>w', '<C-w>r', {
        noremap = true,
        silent = true,
        desc = 'Swap with next window'
    })

    -- SOURCING CURRENT FILE WITH <leader>%
    --
    vim.keymap.set("n", "<leader>%", ":source %<CR>", { noremap = true, silent = true })


    --    ____          _                    ____                      _     
    --   / ___|   _ ___| |_ ___  _ __ ___   / ___|  ___  __ _ _ __ ___| |__  
    --  | |  | | | / __| __/ _ \| '_ ` _ \  \___ \ / _ \/ _` | '__/ __| '_ \ 
    --  | |__| |_| \__ \ || (_) | | | | | |  ___) |  __/ (_| | | | (__| | | |
    --   \____\__,_|___/\__\___/|_| |_| |_| |____/ \___|\__,_|_|  \___|_| |_|
    --
    -- 1 - Pressing '*' will highlight the current word under the cursor and 
    -- pressing '*' again will remove the highlight.
    --
    -- 2 - When highlighting is enabled, the cursor will NOT jump to the next
    -- match.
    --
    M.jniHighlighted = false
    function _G.CustomSearch()
        if not M.jniHighlighted then
            vim.cmd('normal! *')
            vim.api.nvim_command('set hlsearch')
            vim.fn.execute('normal! N')
            M.jniHighlighted = true
        else
            vim.api.nvim_command('set nohlsearch')
            M.jniHighlighted = false
        end
    end
    vim.keymap.set('n', '*', CustomSearch, { noremap = true, silent = true })


    --   ____  _             _           
    --  |  _ \| |_   _  __ _(_)_ __  ___ 
    --  | |_) | | | | |/ _` | | '_ \/ __|
    --  |  __/| | |_| | (_| | | | | \__ \
    --  |_|   |_|\__,_|\__, |_|_| |_|___/
    --                 |___/             

    -- COMMENT PLUGIN
    --
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


    -- GITHUB COPILOT
    --
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
                accept = "<S-Tab>", -- Shift + Tab
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
            gitcommit = true,
            gitrebase = false,
            hgcommit = false,
            svn = false,
            cvs = false,
            ["."] = false,
        },
        copilot_node_command = 'node', -- Node.js version must be > 16.x
        server_opts_overrides = {},
    })
    -- Define a custom color for Copilot suggestions
    vim.cmd [[
      highlight CopilotSuggestion guifg=#452e45 ctermfg=8
    ]]

    -- FANCIER NOTIFICATIONS
    --
    -- rcarriga/nvim-notify Configuration
    -- Renders notification windows
    vim.notify = require("notify")
    require("notify").setup({
        background_colour = "#000911",
        stages = "fade",  -- Search help for 'noitfy.Config'
        render = "default",  -- Search help for 'noitity-render'
    })


    -- NVIMTREE CONFIGURATION
    --
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
    local function open_nvim_tree(data)
        -- buffer is a directory
        local directory = vim.fn.isdirectory(data.file) == 1

        if not directory then
            return
        end

        -- change to the directory
        vim.cmd.cd(data.file)

        -- open the tree
        require("nvim-tree.api").tree.open()
    end
    vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
    vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle)


    --  _____         _   _             
    -- |_   _|__  ___| |_(_)_ __   __ _ 
    --   | |/ _ \/ __| __| | '_ \ / _` |
    --   | |  __/\__ \ |_| | | | | (_| |
    --   |_|\___||___/\__|_|_| |_|\__, |
    --                            |___/ 
    -- Testing calling an external program and parsing input and outputs
    -- with JSON
    --
    local function createJsonInput()
        local person = {name = "Jenso"}
        -- local jsonInput =  "{\"name\": \"Jens\"}"
        local lunajson = require("lunajson")
        local jsonInput = lunajson.encode(person)
        return jsonInput
    end

    local function parseJsonOutput(jsonData)
        local lunajson = require("lunajson")
        local person = lunajson.decode(jsonData[1])
        if person == nil or person.name == nil then
            vim.notify("Invalid JSON")
            return
        else
            local text = "The person's name is " .. person.name
            vim.notify(text)
        end
    end

    local function TestMe()
        local input_lines = {"helloworld",createJsonInput()}
        vim.fn.jobstart(input_lines, {
            stdout_buffered = true,
            on_stdout = function(_, data)
                if data then
                    parseJsonOutput(data)
                end
            end,
        })
    end
    vim.api.nvim_create_user_command("TestMe", TestMe, {})

end

return M
