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
