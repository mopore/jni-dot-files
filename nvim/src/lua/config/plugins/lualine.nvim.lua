return {
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    -- I enabled the icons to show -- JNI addition
    enabled = true,
    opts = {
      options = {
        icons_enabled = true,
        theme = 'catppuccin',
        component_separators = '|',
        section_separators = '',
      },
      tabline = {
        lualine_a = { 'mode' },
        lualine_b = { { 'filename', path = 3 } },
        lualine_y = { 'filetype', 'diagnostics' },
        lualine_z = { 'searchcount' },
      },
      inactive_tabline = {
        lualine_a = { 'mode' },
        lualine_b = { { 'filename', path = 3 } },
        lualine_y = { 'filetype', 'diagnostics' },
        lualine_z = { 'searchcount' },
      },
      -- lualine_a = {},
      -- lualine_b = { { 'filename', path = 3 } },
      -- lualine_y = { 'filetype', 'diagnostics' },
      -- lualine_z = {'filetype', 'diagnostics' },
      sections = {
        lualine_a = {},
        lualine_b = { 'branch', 'diff' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = {},
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      -- inactive_sections = {
      --   lualine_a = {},
      --   lualine_b = {},
      --   lualine_c = { { 'filename', path = 1 } },
      --   lualine_x = { 'location' },
      --   lualine_y = {},
      --   lualine_z = {}
      -- },
    },
    -- config = function()
    --   -- To be exectute for setup
    -- end,
  },
}
