return {
  {
    -- Core LSP (no more require('lspconfig').X.setup)
    "neovim/nvim-lspconfig",
    enabled = true,
    dependencies = {
      -- Mason moved orgs + v2 behavior
      { "mason-org/mason.nvim", config = true },
      { "mason-org/mason-lspconfig.nvim", opts = {} },

      -- Status / UI extras
      { "j-hui/fidget.nvim", tag = "legacy", opts = {} },

      -- Better Lua-runtime typing
      "folke/neodev.nvim",
      -- your completion
      "saghen/blink.cmp",
    },

    config = function()
      -- Your on_attach is unchanged
      local on_attach = function(_, bufnr)
        print("LSP connected.")
        local nmap = function(keys, func, desc)
          if desc then desc = "LSP: " .. desc end
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
        nmap("<leader>ss", require("telescope.builtin").lsp_document_symbols, "[S]earch [S]ymbols")
        nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
        nmap("<M-k>", vim.lsp.buf.hover, "Hover Documentation")
        nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
        nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
        nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
        nmap("<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "[W]orkspace [L]ist Folders")

        vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_) vim.lsp.buf.format() end,
          { desc = "Format current buffer with LSP" })
      end

      -- neodev first
      require("neodev").setup()

      -- Capabilities (blink.cmp)
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Your servers (same content you had)
      local servers = {
        gopls = {},
        ts_ls = {},
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
        pylsp = {
          pylsp = {
            plugins = {
              pycodestyle = {
                ignore = { "W191" },
                maxLineLength = 100,
              },
            },
          },
        },
        bashls = {
          filetypes = { "sh", "zsh" },
        },
      }

      -- (Optional) set defaults for every LSP via wildcard
      -- This is neat in 0.11+ and keeps per-server blocks minimal.
      if vim.fn.has("nvim-0.11") == 1 and vim.lsp and vim.lsp.config then
        vim.lsp.config("*", {
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end

      -- Define/override each server's config (0.11 API)
      for name, s in pairs(servers) do
        vim.lsp.config(name, {
          -- wildcard defaults above will merge into this
          settings = s,                      -- your server-specific settings
          filetypes = s and s.filetypes,     -- allow overriding filetypes
        })
      end

      -- Mason v2: install + auto-enable servers
      -- (mason-lspconfig will call vim.lsp.enable() for installed servers)
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(servers),
        automatic_enable = true, -- default; shown here for clarity
      })

      -- If you prefer to control enablement yourself, disable automatic_enable and do:
      -- for name, _ in pairs(servers) do vim.lsp.enable(name) end
    end,
  },
}
