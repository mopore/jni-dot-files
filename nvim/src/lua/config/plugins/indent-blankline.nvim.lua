return {
  {
    -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    enabled = true,
    main = "ibl",
    opts = {
      debounce = 100,
      indent = { char = "┊" },
    },
    config = function()
      require("ibl").setup({
        indent = {
          -- char = "│",
          -- highlight = "LineNr",
          -- show_trailing_blankline_indent = false,
          -- show_first_indent_level = false,
        },
        scope = {
          enabled = true,
          show_start = false,
          show_end = false,
        },
        exclude = {
          filetypes = { "help", "dashboard", "packer", "NvimTree" },
          buftypes = { "terminal" },
        },
      })
    end,
  },
}
