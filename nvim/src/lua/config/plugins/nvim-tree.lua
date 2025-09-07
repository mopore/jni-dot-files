return {
  {
    -- nvim-tree (A file explorer)
    "nvim-tree/nvim-tree.lua",
    enabled = true,
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },
}
