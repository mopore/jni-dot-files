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

    -- Indent-Blankline
    --
    require("ibl").setup({
        indent = {
            -- char = "│",
            -- highlight = "LineNr",
            -- show_trailing_blankline_indent = false,
            -- show_first_indent_level = false,
        },
        scope = {
            enabled = true,
            show_start = false,
            show_end = false,
        },
        exclude = {
            filetypes = { "help", "dashboard", "packer", "NvimTree" },
            buftypes = { "terminal" },
        },
    })


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
    --
    --
    -- Custom color for Copilot suggestions
    -- 
    -- color is a greenish gray
    --
    vim.cmd [[
      highlight CopilotSuggestion guifg=#88aa88 ctermfg=8
    ]]

    -- FANCIER NOTIFICATIONS
    --
    -- rcarriga/nvim-notify Configuration
    -- Renders notification windows
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

    -- SNIPE 
    --
    -- Open Buffer Picker
    --
    require("snipe").setup({
      -- The snipe plugin provides a way to quickly select and open buffers
      -- It is a replacement for the old "bufferline" plugin
      -- See `:help snipe` for more information
      -- NOTE: This is a very powerful plugin, so make sure to read the documentation
      --       before using it.
      ui = {
        ---@type integer
        max_height = -1, -- -1 means dynamic height
        -- Where to place the ui window
        -- Can be any of "topleft", "bottomleft", "topright", "bottomright", "center", "cursor" (sets under the current cursor pos)
        ---@type "topleft"|"bottomleft"|"topright"|"bottomright"|"center"|"cursor"
        position = "topleft",
        -- Override options passed to `nvim_open_win`
        -- Be careful with this as snipe will not validate
        -- anything you override here. See `:h nvim_open_win`
        -- for config options
        ---@type vim.api.keyset.win_config
        open_win_override = {
          -- title = "My Window Title",
          border = "rounded", -- use "single" or "rounded" for rounded border
        },

        -- Preselect the currently open buffer
        ---@type boolean
        preselect_current = true,

        -- Set a function to preselect the currently open buffer
        -- E.g, `preselect = require("snipe").preselect_by_classifier("#")` to
        -- preselect alternate buffer (see :h ls and look at the "Indicators")
        ---@type nil|fun(buffers: snipe.Buffer[]): number
        preselect = nil, -- function (bs: Buffer[] [see lua/snipe/buffer.lua]) -> int (index)

        -- Changes how the items are aligned: e.g. "<tag> foo    " vs "<tag>    foo"
        -- Can be "left", "right" or "file-first"
        -- NOTE: "file-first" puts the file name first and then the directory name
        ---@type "left"|"right"|"file-first"
        text_align = "left",

        -- Provide custom buffer list format
        -- Available options:
        --  "filename" - basename of the buffer
        --  "directory" - buffer parent directory path
        --  "icon" - icon for buffer filetype from "mini.icons" or "nvim-web-devicons"
        --  string - any string, will be inserted as is
        --  fun(buffer_object): string,string - function that takes snipe.Buffer object as an argument
        --    and returns a string to be inserted and optional highlight group name
        -- buffer_format = { "->", "icon", "filename", "", "directory", function(buf)
        --   if vim.fn.isdirectory(vim.api.nvim_buf_get_name(buf.id)) == 1 then
        --     return " ", "SnipeText"
        --   end
        -- end },

        -- Whether to remember mappings from bufnr -> tag
        persist_tags = true,
      },
      hints = {
        -- Charaters to use for hints (NOTE: make sure they don't collide with the navigation keymaps)
        ---@type string
        dictionary = "sadflewcmpghio",
        -- Character used to disambiguate tags when 'persist_tags' option is set
        prefix_key = ".",
      },
      navigate = {
        -- Specifies the "leader" key
        -- This allows you to select a buffer but defer the action.
        -- NOTE: this does not override your actual leader key!
        leader = ",",

        -- Leader map defines keys that follow a selection prefixed by the
        -- leader key. For example (with tag "a"):
        -- ,ad -> run leader_map["d"](m, i)
        -- NOTE: the leader_map cannot specify multi character bindings.
        leader_map = {
          ["d"] = function (m, i) require("snipe").close_buf(m, i) end,
          ["v"] = function (m, i) require("snipe").open_vsplit(m, i) end,
          ["h"] = function (m, i) require("snipe").open_split(m, i) end,
        },

        -- When the list is too long it is split into pages
        -- `[next|prev]_page` options allow you to navigate
        -- this list
        next_page = "J",
        prev_page = "K",

        -- You can also just use normal navigation to go to the item you want
        -- this option just sets the keybind for selecting the item under the
        -- cursor
        under_cursor = "<cr>",

        -- In case you changed your mind, provide a keybind that lets you
        -- cancel the snipe and close the window.
        ---@type string|string[]
        cancel_snipe = "<esc>",

        -- Close the buffer under the cursor
        -- Remove "j" and "k" from your dictionary to navigate easier to delete
        -- NOTE: Make sure you don't use the character below on your dictionary
        close_buffer = "q",

        -- Open buffer in vertical split
        open_vsplit = "|",

        -- Open buffer in split, based on `vim.opt.splitbelow`
        open_split = "-",

        -- Change tag manually (note only works if `persist_tags` is not enabled)
        -- change_tag = "C",
      },
      -- The default sort used for the buffers
      -- Can be any of:
      --  "last" - sort buffers by last accessed
      --  "default" - sort buffers by its number
      --  fun(bs:snipe.Buffer[]):snipe.Buffer[] - custom sort function, should accept a list of snipe.Buffer[] as an argument and return sorted list of snipe.Buffer[]
      ---@type "last"|"default"|fun(buffers:snipe.Buffer[]):snipe.Buffer[]
      sort = "default",
    })

end

return M
