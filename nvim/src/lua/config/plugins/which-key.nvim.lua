return {
  {
    -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    name="which-key",
    enabled = true,
    config = function()
      require("which-key").setup()
    end,
  },
}
