return {
  {
    --   ____               _ _     _            
    --  / ___|_ __ ___   __| | |   (_)_ __   ___ 
    -- | |   | '_ ` _ \ / _` | |   | | '_ \ / _ \
    -- | |___| | | | | | (_| | |___| | | | |  __/
    --  \____|_| |_| |_|\__,_|_____|_|_| |_|\___|
    --                                           
    "VonHeikemen/fine-cmdline.nvim",
    enabled = true,
    dependencies = { "MunifTanjim/nui.nvim" },
    keys = {
      { ":", "<cmd>FineCmdline<CR>", mode = "n", desc = "Floating cmdline" },
    },
    opts = {
      cmdline = { enable_keymaps = true, smart_history = true, prompt = ": " },
      popup = {
        position = { row = "45%", col = "50%" },
        size = { width = "60%" },
        border = { style = "rounded" },
        win_options = { winhighlight = "Normal:Normal,FloatBorder:FloatBorder" },
      },
    },
    config = function(_, opts) require("fine-cmdline").setup(opts) end,
  },
}
