--[[
 ____  _             _          ____             __ 
|  _ \| |_   _  __ _(_)_ __    / ___|___  _ __  / _|
| |_) | | | | |/ _` | | '_ \  | |   / _ \| '_ \| |_ 
|  __/| | |_| | (_| | | | | | | |__| (_) | | | |  _|
|_|   |_|\__,_|\__, |_|_| |_|  \____\___/|_| |_|_|  
               |___/                                
--]]

local M = {}

M.load = function()

  --
  --  _____    _
  -- |_   _|__| | ___  ___  ___ ___  _ __   ___
  --   | |/ _ \ |/ _ \/ __|/ __/ _ \| '_ \ / _ \
  --   | |  __/ |  __/\__ \ (_| (_) | |_) |  __/
  --   |_|\___|_|\___||___/\___\___/| .__/ \___|
  --                                |_|
  --
  --
  -- See `:help telescope` and `:help telescope.setup()`
  require('telescope').setup {
    defaults = {
      mappings = {
        i = {
          ['<C-u>'] = false,
          ['<C-d>'] = false,
        },
      },
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown {
          -- even more opts
        }
      }
    }
  }
  -- Enable telescope fzf native, if installed
  pcall(require('telescope').load_extension, 'fzf')
  pcall(require('telescope').load_extension, 'ui-select')

  -- See `:help telescope.builtin`
  vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
  -- vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
  -- Fuzzy search in current file (was '<leader>/') -- JNI addtion
  vim.keymap.set('n', '<c-f>', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer' })

  vim.keymap.set('n', '<leader>gf', require('telescope.builtin').find_files, { desc = 'Search [G]it [F]iles' })
  vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch all [F]iles' })
  vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })



  --  _____                   _ _   _
  -- |_   _| __ ___  ___  ___(_) |_| |_ ___ _ __
  --   | || '__/ _ \/ _ \/ __| | __| __/ _ \ '__|
  --   | || | |  __/  __/\__ \ | |_| ||  __/ |
  --   |_||_|  \___|\___||___/_|\__|\__\___|_|
  --
  -- [[ Configure Treesitter ]]
  -- See `:help nvim-treesitter`
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
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
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }


  --  _     ____  ____
  -- | |   / ___||  _ \
  -- | |   \___ \| |_) |
  -- | |___ ___) |  __/
  -- |_____|____/|_|
  --
  -- [[ Configure LSP ]]
  --  This function gets run when an LSP connects to a particular buffer.
  local on_attach = function(_, bufnr)
    print("LSP connected.");

    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
      if desc then
        desc = 'LSP: ' .. desc
      end

      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ss', require('telescope.builtin').lsp_document_symbols, '[S]earch [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    -- Change the hover documentation from 'K' to 'Alt' and 'k' -- JNI addition
    nmap('<M-k>', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
      vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })

  end

  -- Enable the following language servers
  --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
  --
  --  Add any additional override configuration in the following tables. They will be passed to
  --  the `settings` field of the server config. You must look up that documentation yourself.
  --
  --  If you want to override the default filetypes that your language server will attach to you can
  --  define the property 'filetypes' to the map in question.
  local servers = {
    -- clangd = {},
    gopls = {},
    -- pyright = {},
    -- rust_analyzer = {},
    ts_ls = {},
    -- html = { filetypes = { 'html', 'twig', 'hbs'} },

    lua_ls = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
    -- Add a configuration for pylsp -- JNI addition
    pylsp = {
      pylsp = {
        plugins = {
          pycodestyle = {
            ignore = { 'W191' }, -- See: https://pycodestyle.pycqa.org/en/latest/intro.html#error-codes
            maxLineLength = 100
          }
        }
      }
    },
    bashls = {
      filetypes = { 'sh', 'zsh' },
    },
  }

  -- Setup neovim lua configuration
  require('neodev').setup()

  -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  for server_name, _ in pairs(servers) do
    local cfg = {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
    -- Only setup if lspconfig knows the server (avoids nil indexing)
    if require('lspconfig')[server_name] then
      require('lspconfig')[server_name].setup(cfg)
    end
  end


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


  -- GITHUB COPILOT (Lua edition by zbirenbaum/copilot.lua)
  --
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

  -- For nvim-tree -- JNI addition
  -- disable netrw at the very start of your init.lua
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1


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
