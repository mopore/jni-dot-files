return {
  {
    --      _
    --     | |_   _ _ __ ___  _ __   ___ _ __
    --  _  | | | | | '_ ` _ \| '_ \ / _ \ '__|
    -- | |_| | |_| | | | | | | |_) |  __/ |
    --  \___/ \__,_|_| |_| |_| .__/ \___|_|
    --                       |_|
    --
    -- Use leader, type the first to chars and the appearing marked character 
    -- to jump to that character.
    -- nvim leap (jump like a cangaroo)
    "ggandor/leap.nvim",
    enabled = true,
    config = function()
      vim.keymap.set({ 'n', 'x', 'o' }, '<leader>k', '<Plug>(leap-backward)',
        { desc = '[k] leap up ↑', noremap = true, silent = true })
      vim.keymap.set({ 'n', 'x', 'o' }, '<leader>j', '<Plug>(leap-forward)',
        { desc = '[j] leap down ↓', noremap = true, silent = true })
    end,
  },
}
