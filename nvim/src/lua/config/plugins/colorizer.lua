return {
  {
    'catgoose/nvim-colorizer.lua',
    enabled = true,
    event = "BufReadPre",
    config = function()
      require('colorizer').setup()
    end
  },
}
