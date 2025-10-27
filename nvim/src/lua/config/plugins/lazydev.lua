return {
  {
    -- Undotree
    'folke/lazydev.nvim',
    ft = "lua",
    enabled = true,
    opts = {
      library = {
        "~/.local/share/nvim/lua-language-server/meta/love-api/library",
      },
    }
    -- config = function()
    --   -- To be exectute for setup
    -- end,
  },
}
