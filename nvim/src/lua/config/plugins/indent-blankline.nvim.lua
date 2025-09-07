return {
  {
    -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    enabled = true,
    main = "ibl",
    opts = {
      debounce = 100,
      indent = { char = "┊" },
    }
    -- config = function()
    --   -- To be exectute for setup
    -- end,
  },
}
