return {
  {
    'nvim-treesitter/nvim-treesitter',
    -- Use 'main' branch for 0.12+ compatibility
    branch = 'main',
    build = ':TSUpdate',
    config = function()
      -- 1. Parser Management (The new 'main' entry point)
      -- Note: NO '.configs' here.
      require('nvim-treesitter').setup {
        ensure_installed = {
          'c', 'cpp', 'typescript', 'tsx', 'go', 'lua',
          'python', 'rust', 'vimdoc', 'vim', 'bash',
          'markdown', 'markdown_inline'
        },
        auto_install = false,
      }

      -- 2. Modern Highlighting (Native 0.12 way)
      if vim.fn.has("nvim-0.12") == 1 then
        -- FIXME: Remove after 0.12 is generally available
        vim.api.nvim_create_autocmd("FileType", {
          callback = function()
            pcall(vim.treesitter.start)
            -- Native 0.12 indentation
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end,
        })
      else
        -- Fallback for your Manjaro 0.11 machine
        -- This uses the old internal command if it still exists in your local cache
        pcall(function()
          vim.cmd('TSEnable highlight')
          vim.cmd('TSEnable indent')
        end)
      end

      -- Custom Dotenv registration
      vim.treesitter.language.register("bash", "dotenv")
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    config = function()
      -- In 2026, textobjects requires its own setup call
      require('nvim-treesitter-textobjects').setup {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = { [']m'] = '@function.outer', [']]'] = '@class.outer' },
          goto_next_end = { [']M'] = '@function.outer', [']['] = '@class.outer' },
          goto_previous_start = { ['[m'] = '@function.outer', ['[['] = '@class.outer' },
          goto_previous_end = { ['[M'] = '@function.outer', ['[]'] = '@class.outer' },
        },
        swap = {
          enable = true,
          swap_next = { ['<leader>a'] = '@parameter.inner' },
          swap_previous = { ['<leader>A'] = '@parameter.inner' },
        },
      }
    end
  }
}
