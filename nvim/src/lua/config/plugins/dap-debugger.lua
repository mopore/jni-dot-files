return {
  {
    -- Git related plugins
    "mfussenegger/nvim-dap",
    enabled = true,
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "leoluz/nvim-dap-go",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
    },
    config = function()
      local dap = require('dap')
      local ui = require('dapui')
      local virttext = require('nvim-dap-virtual-text')
      local go = require('dap-go')

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
      go.setup()
      ui.setup()
      virttext.setup({})
    end
  },
}
