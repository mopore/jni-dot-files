--  _  __                                
-- | |/ /___ _   _ _ __ ___   __ _ _ __  
-- | ' // _ \ | | | '_ ` _ \ / _` | '_ \ 
-- | . \  __/ |_| | | | | | | (_| | |_) |
-- |_|\_\___|\__, |_| |_| |_|\__,_| .__/ 
--           |___/                |_|    

local M = {}

M.load = function()


    vim.keymap.set('n', '<c-h>', ':TmuxNavigateLeft<CR>', { silent = true} )
    vim.keymap.set('n', '<c-j>', ':TmuxNavigateDown<CR>', { silent = true} )
    vim.keymap.set('n', '<c-k>', ':TmuxNavigateUp<CR>', { silent = true} )
    vim.keymap.set('n', '<c-l>', ':TmuxNavigateRight<CR>', { silent = true} )

    -- Keymaps for better default experience
    -- See `:help vim.keymap.set()`
    vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

    -- Remap for dealing with word wrap
    vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
    vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

    -- Diagnostic keymaps
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
    -- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })  -- Want it for explorer
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

    -- Toggle undotree to <leader>u
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undotree" })

    -- Use 'jj' and 'kk' to escape to normal mode
    vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true })
    -- vim.keymap.set('i', 'jj', '<Esc>', { noremap = true, silent = true })
    -- vim.keymap.set('i', 'kk', '<Esc>', { noremap = true, silent = true })

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

    -- Remapping 'Ctrl-w r' to 'Ctrl-w w' for swapping window with the next
    vim.api.nvim_set_keymap('n', '<C-w>w', '<C-w>r', {
        noremap = true,
        silent = true,
        desc = 'Swap with next window'
    })

    -- SOURCING CURRENT FILE WITH <leader>%
    --
    vim.keymap.set("n", "<leader>%", ":source %<CR>", {
	noremap = true,
	silent = true,
	desc = "Source current file",
    })

end

return M
