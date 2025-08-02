-- This is a local plugin to add more customization to my Neovim setup.G e
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

    -- Set the search NOT-highlight colors
    vim.api.nvim_set_hl(0, 'Search', { bg = '#7a4452', fg = '#23211f' })

    -- Split to the right by default
    vim.opt.splitright = true

    -- Toggle undotree to <leader>u
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undotree" })

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

    -- | Shortcut                | Description                        |
    -- | ----------------------- | ---                                |
    -- | `Z` + `Z`               | :wa :qa Save all & exit            |
    -- | `Z` + `W`               | :wa Save all                       |
    -- | `Z` + `Q`               | :qa exit only when nothing to save |
    vim.keymap.set('n', 'ZZ', ':wa<CR>:qa<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', 'ZW', ':wa<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', 'ZQ', ':qa<CR>', { noremap = true, silent = true })

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
    vim.keymap.set("n", "<leader>%", ":source %<CR>", { noremap = true, silent = true, desc = "Source current file" })


    --  ____  _  __  __   _   _     _     
    -- |  _ \(_)/ _|/ _| | |_| |__ (_)___ 
    -- | | | | | |_| |_  | __| '_ \| / __|
    -- | |_| | |  _|  _| | |_| | | | \__ \
    -- |____/|_|_| |_|    \__|_| |_|_|___/
    --                                    
    -- DIFFTHIS (built-in)
    -- Shows the diff of the two currently opened files in vertival splits
    -- Als necessary to have no other splits open
    --
    M.jniDiffedThis = false
    function _G.DiffThis()
        if not M.jniDiffedThis then

            -- -- Check if NvimTree would need to be closed so we have only two
            -- -- windows open.
            -- local nvim_tree_open = require("nvim-tree.view").is_visible()
            -- local window_count = vim.api.nvim_list_wins()
            -- local ready_to_diff = false
            -- if nvim_tree_open then
            --     if window_count == 3 then
            --         -- Close the NvimTree window
            --         vim.api.nvim_command('NvimTreeClose')
            --         ready_to_diff = true
            --     else
            -- end
            --     if window_count == 2 then
            --         ready_to_diff = true
            --     end
            -- end
            -- if not ready_to_diff then
            --     vim.notify("Please ensure to have only two windows open")
            --     return
            -- end

            -- Diff the two windows
            vim.api.nvim_command('windo diffthis')
            M.jniDiffedThis = true
        else
            vim.api.nvim_command('windo diffoff')
            M.jniDiffedThis = false
        end
    end
    vim.keymap.set("n", "<leader>dt", DiffThis, { noremap = true, silent = true, desc = "[D]iff [T]hese 2 files" })

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

    --  _____ _ _        ____                      _     
    -- |  ___(_) | ___  / ___|  ___  __ _ _ __ ___| |__  
    -- | |_  | | |/ _ \ \___ \ / _ \/ _` | '__/ __| '_ \ 
    -- |  _| | | |  __/  ___) |  __/ (_| | | | (__| | | |
    -- |_|   |_|_|\___| |____/ \___|\__,_|_|  \___|_| |_|
    --                                                   
    -- File search with <space>s<space> with Telescope's git_files  if possible
    -- otherwise use normal file search via Telescope
    M.vim_entered = function ()
        -- Check if we are in a git repo
        local result = vim.fn.system('git rev-parse --is-inside-work-tree 2>/dev/null')
        local is_git_repo =  "true" == vim.trim(result)

        if is_git_repo then
            vim.keymap.set('n', '<leader>s<space>', require('telescope.builtin').git_files, { desc = '[S]earch [space] git repo files' })
        else
            vim.keymap.set('n', '<leader>s<space>', require('telescope.builtin').find_files, { desc = '[S]earch [space] files' })
        end
    end
    vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("JniAdditionsFileSearch", { clear = true }),
        callback = M.vim_entered
    })

    --   ____  _             _           
    --  |  _ \| |_   _  __ _(_)_ __  ___ 
    --  | |_) | | | | |/ _` | | '_ \/ __|
    --  |  __/| | |_| | (_| | | | | \__ \
    --  |_|   |_|\__,_|\__, |_|_| |_|___/
    --                 |___/             

    -- COMMENT PLUGIN
    --
    require('Comment').setup()

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
        top_down = false,
        background_colour = "#000911",
        stages = "fade",  -- Search help for 'noitfy.Config'
        render = "default",  -- Search help for 'notity-render'
        level = 2,  -- Representing vim.log.levels.INFO
        timeout = 5000,
        icons = {
          DEBUG = "",
          ERROR = "",
          INFO = "",
          TRACE = "✎",
          WARN = ""
        },
        time_formats = {
          notification = "%T",
          notification_history = "%FT%T"
        },
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
    vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle, { desc = "Toggle NvimTree" })

--   ____    _    ____    ____       _                       _             
--  |  _ \  / \  |  _ \  |  _ \  ___| |__  _   _  __ _  __ _(_)_ __   __ _ 
--  | | | |/ _ \ | |_) | | | | |/ _ \ '_ \| | | |/ _` |/ _` | | '_ \ / _` |
--  | |_| / ___ \|  __/  | |_| |  __/ |_) | |_| | (_| | (_| | | | | | (_| |
--  |____/_/   \_\_|     |____/ \___|_.__/ \__,_|\__, |\__, |_|_| |_|\__, |
--                                               |___/ |___/         |___/ 
    -- For debugging w/ Go Lang you need "Delve" installed.
    -- The executable is called "dlv"
    local delvePresent = vim.fn.executable('dlv') == 1
    if not delvePresent then
        vim.notify(
            "Delve is missing for debugging Go programs.\n" ..
            "Install with:\n" ..
            "go install github.com/go-delve/delve/cmd/dlv@latest",
            vim.log.levels.ERROR,
            { title = "Delve not found" }
        )
    end

    local dap = require('dap')
    local ui = require('dapui')

    vim.keymap.set( 'n', '<leader>db', dap.toggle_breakpoint, { desc = '[D]ebug [B] toggle breakpoint' })
    vim.keymap.set( 'n', '<leader>d<space>', dap.continue, { desc = '[D]ebug [space] start/continue' })
    vim.keymap.set( 'n', '<leader>dr', dap.restart, { desc = '[D]ebug [r] RESTART' })
    vim.keymap.set( 'n', '<leader>dj', dap.step_into, { desc = '[D]ebug [j] step into' })
    vim.keymap.set( 'n', '<leader>dl', dap.step_over, { desc = '[D]ebug [l] step over' })
    vim.keymap.set( 'n', '<leader>dk', dap.step_out, { desc = '[D]ebug [k] step out' })
    vim.keymap.set( 'n', '<leader>dx', dap.disconnect, { desc = '[D]ebug [x] CLOSE' })

    vim.keymap.set(
      'n',
      '<leader>d?',
        function()
          ui.eval(nil, { enter = true })
        end,
      { desc = '[D]ebug [?] inspect under cursor' }
    )


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

    local function ReadWriteExternal()
        local external_program = "helloworld"

        -- This test requires an external program "helloworld" which receives 
        -- an input string and returns a JSON string.
        --
        -- Call:
        -- helloworld "{\"name\": \"Jens\"}"
        --
        -- Output:
        -- {"name": "Jens"}
        --
        local input_lines = {external_program,createJsonInput()}
        vim.fn.jobstart(input_lines, {
            stdout_buffered = true,
            on_stdout = function(_, data)
                if data then
                    parseJsonOutput(data)
                end
            end,
        })
    end
    vim.api.nvim_create_user_command("ReadWriteExternal", ReadWriteExternal, {})


    local function TestMe()
        vim.notify("I am here to get called.", vim.log.levels.INFO, { title = "TestMe" })
    end
    vim.api.nvim_create_user_command("TestMe", TestMe, {})
end

return M
