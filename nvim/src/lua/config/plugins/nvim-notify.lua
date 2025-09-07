return {
  {
    -- Nice Notifications
    "rcarriga/nvim-notify",
    enabled = true,
    config = function()
      vim.notify = require("notify")
      require("notify").setup({
        top_down = false,
        merge_duplicates = true,
        background_colour = "#000911",
        stages = "fade",  -- Search help for 'noitfy.Config'
        render = "default",  -- Search help for 'notity-render'
        level = 2,  -- Representing vim.log.levels.INFO
        timeout = 5000,
        icons = {
          DEBUG = "",
          ERROR = "",
          INFO = "",
          TRACE = "✎",
          WARN = ""
        },
        time_formats = {
          notification = "%T",
          notification_history = "%FT%T"
        },
      })
    end,
  },
}
