--  ____  _             _           
-- |  _ \| |_   _  __ _(_)_ __  ___ 
-- | |_) | | | | |/ _` | | '_ \/ __|
-- |  __/| | |_| | (_| | | | | \__ \
-- |_|   |_|\__,_|\__, |_|_| |_|___/
--                |___/             

local M = {}

M.load = function()

    -- NVIM-CMP
    -- 
    -- Autocompletion plugin for Neovim
    --
    -- See `:help cmp`
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup {}
    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        -- ['<S-Tab>'] = cmp.mapping(function(fallback)  -- JNI Addition - avoid conflict with copilot
        --   if cmp.visible() then
        --     cmp.select_prev_item()
        --   elseif luasnip.locally_jumpable(-1) then
        --     luasnip.jump(-1)
        --   else
        --     fallback()
        --   end
        -- end, { 'i', 's' }),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'luasnip' },
        { name = 'buffer', keyword_length = 5},
      },
    }

    -- FIREMVIM
    --
    -- For having a Neovim iframe in the browser
    --
    vim.g.firenvim_config = {
        globalSettings = { alt = "all" },
        localSettings = {
            [".*"] = {
                cmdline  = "neovim",
                content  = "text",
                priority = 0,
                selector = "textarea",
                takeover = "never"
            }
        }
    }

    -- COMMENT PLUGIN
    --
    require('Comment').setup()

    -- GITHUB COPILOT
    --
    require('copilot').setup({
        panel = {
            enabled = false,
            -- auto_refresh = false,
            -- keymap = {
            --   jump_prev = "[[",
            --   jump_next = "]]",
            --   accept = "<CR>",
            --   refresh = "gr",
            --   open = "<M-CR>"
            -- },
            -- layout = {
            --   position = "bottom", -- | top | left | right
            --   ratio = 0.4
            -- },
        },
        suggestion = {
            enabled = true,
            auto_trigger = true,
            debounce = 75,
            keymap = {
                -- accept = "<M-CR>",  -- Alt + Enter
                accept = "<S-Tab>", -- Shift + Tab
                accept_word = false,
                accept_line = false,
                next = "<M-]>",
                prev = "<M-[>",
                dismiss = "<C-]>",
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
    -- Define a custom color for Copilot suggestions
    vim.cmd [[
      highlight CopilotSuggestion guifg=#452e45 ctermfg=8
    ]]

    -- FANCIER NOTIFICATIONS
    --
    -- rcarriga/nvim-notify Configuration
    -- Renders notification windows
    vim.notify = require("notify")
    require("notify").setup({
        top_down = false,
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

    -- NVIMTREE CONFIGURATION
    --
    -- File explorer for Neovim.
    --
    -- empty setup using defaults
    require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
            width = 30,
        },
        renderer = {
            group_empty = true,
        },
        filters = {
            dotfiles = true,
        },
    })
    local function open_nvim_tree(data)
        -- buffer is a directory
        local directory = vim.fn.isdirectory(data.file) == 1

        if not directory then
            return
        end

        -- change to the directory
        vim.cmd.cd(data.file)

        -- open the tree
        require("nvim-tree.api").tree.open()
    end
    vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
    vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle, { desc = "Toggle NvimTree" })

end

return M
