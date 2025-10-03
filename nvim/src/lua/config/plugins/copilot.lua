return {
  {
    -- Lua Version of Github Copilot -- JNI addition
    'zbirenbaum/copilot.lua',
    enabled = true,
    config = function()
      require('copilot').setup({
        -- The 'panel' could show previews.
        panel = {
          enabled = false,
        },
        suggestion = {
          enabled = true,
          auto_trigger = false,
          debounce = 75,
          keymap = {
            accept = "<S-Tab>", -- Shift + Tab
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-[>",
          },
        },
        filetypes = {
          yaml = false,
          markdown = true,
          help = false,
          gitcommit = true,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
        copilot_node_command = 'node', -- Node.js version must be > 16.x
        server_opts_overrides = {},
      })

      --
      -- Custom color for Copilot suggestions
      -- 
      -- color is a greenish gray
      --
      vim.cmd [[
      highlight CopilotSuggestion guifg=#88aa88 ctermfg=8
      ]]

      --
      -- Custom keymap to toggle auto trigger
      --
      -- After a recent change (2025-10) triggering the "next word" did not seem
      -- to automatically acitivate makeing the plugin starting to make a suggestion.
      -- 
      vim.keymap.set(
        'n',
        '<leader>cc',
        function()
          local copilot = require('copilot.suggestion')
          copilot.toggle_auto_trigger()
          local state = (vim.b.copilot_suggestion_auto_trigger) and "enabled" or "disabled"
          vim.notify("Copilot auto trigger: " .. state)
        end,
        { desc = '[C]opilot [c]toggle auto trigger' }
      )
    end,
  },
}
