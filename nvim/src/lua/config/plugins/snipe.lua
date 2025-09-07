return {
  {
    --- Plugin to pick a currently open buffer
    --  ____        _            
    -- / ___| _ __ (_)_ __   ___ 
    -- \___ \| '_ \| | '_ \ / _ \
    --  ___) | | | | | |_) |  __/
    -- |____/|_| |_|_| .__/ \___|
    --               |_|         
    "leath-dub/snipe.nvim",
    name="snipe",
    enabled = true,
    keys = {
      {"<leader><space>", function () require("snipe").open_buffer_menu() end, desc = "Open Snipe buffer menu"}
    },
    config = function()
      require("snipe").setup()
    end,
  },
}
