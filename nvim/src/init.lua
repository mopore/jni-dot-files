--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

Kickstart.nvim is *not* a distribution.
Kickstart.nvim is a template for your own configuration.
  The goal is that you can read every line of code, top-to-bottom, understand
  what your configuration is doing, and modify it to suit your needs.

  Once you've done that, you should start exploring, configuring and tinkering to
  explore Neovim!

  If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example:
  - https://learnxinyminutes.com/docs/lua/


  And then you can explore or search through `:help lua-guide`
  - https://neovim.io/doc/user/lua-guide.html


Kickstart Guide:

I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.

In addition, I have some `NOTE:` items throughout the file.
These are for you, the reader to help understand what is happening. Feel free to delete
them once you know what you're doing, but they should serve as a guide for when you
are first encountering a few different constructs in your nvim config.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now :)
--]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- For nvim-tree -- JNI addition
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- JNI Addition (Nice notifications)
  "rcarriga/nvim-notify",

  -- JNI Addition (Splash Screen)
  {

    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.startify")
      dashboard.section.header.val = {
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                     ]],
        [[       ████ ██████           █████      ██                     ]],
        [[      ███████████             █████                             ]],
        [[      █████████ ███████████████████ ███   ███████████   ]],
        [[     █████████  ███    █████████████ █████ ██████████████   ]],
        [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        [[                                                                       ]],
        [[                                                                       ]],
      }

      _Gopts = {
        position = "center",
        hl = "Type",
        -- wrap = "overflow";
      }

      dashboard.opts.opts.noautocmd = true
      alpha.setup(dashboard.opts)
    end
  },

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  --
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Lua Version of Github Copilot -- JNI addition
  'zbirenbaum/copilot.lua',

  -- Surround plugin -- JNI addition
  'tpope/vim-surround',

  -- Undotree
  'mbbill/undotree',

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',  opts = {} },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
          { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end,
    },
  },

  {
    -- Theme
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },

  -- {
  --   -- Theme inspired by Atom
  --   'navarasu/onedark.nvim',
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme 'onedark'
  --   end,
  -- },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    -- I enabled the icons to show -- JNI addition
    opts = {
      options = {
        icons_enabled = true,
        theme = 'catppuccin',
        component_separators = '|',
        section_separators = '',
      },
      tabline = {
        lualine_a = { 'mode' },
        lualine_b = { { 'filename', path = 3 } },
        lualine_y = { 'filetype', 'diagnostics' },
        lualine_z = { 'searchcount' },
      },
      inactive_tabline = {
        lualine_a = { 'mode' },
        lualine_b = { { 'filename', path = 3 } },
        lualine_y = { 'filetype', 'diagnostics' },
        lualine_z = { 'searchcount' },
      },
      -- lualine_a = {},
      -- lualine_b = { { 'filename', path = 3 } },
      -- lualine_y = { 'filetype', 'diagnostics' },
      -- lualine_z = {'filetype', 'diagnostics' },
      sections = {
        lualine_a = {},
        lualine_b = { 'branch', 'diff' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = {},
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      -- inactive_sections = {
      --   lualine_a = {},
      --   lualine_b = {},
      --   lualine_c = { { 'filename', path = 1 } },
      --   lualine_x = { 'location' },
      --   lualine_y = {},
      --   lualine_z = {}
      -- },
    },
  },

  {
    -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      debounce = 100,
      indent = { char = "┊" },
    }
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Nicer window for code actions
  'nvim-telescope/telescope-ui-select.nvim',

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      'nvim-telescope/telescope-ui-select.nvim'
    },
  },


  --  _   ___     _____ __  __   _____
  -- | \ | \ \   / /_ _|  \/  | |_   _| __ ___  ___
  -- |  \| |\ \ / / | || |\/| |   | || '__/ _ \/ _ \
  -- | |\  | \ V /  | || |  | |   | || | |  __/  __/
  -- |_| \_|  \_/  |___|_|  |_|   |_||_|  \___|\___|
  --
  {
    -- nvim-tree (A file explorer)
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },

  {

    --      _
    --     | |_   _ _ __ ___  _ __   ___ _ __
    --  _  | | | | | '_ ` _ \| '_ \ / _ \ '__|
    -- | |_| | |_| | | | | | | |_) |  __/ |
    --  \___/ \__,_|_| |_| |_| .__/ \___|_|
    --                       |_|
    --
    -- Use leader, type the first to chars and the appearing marked character to jump to that character.
    -- nvim leap (jump like a cangaroo)
    "ggandor/leap.nvim",
    config = function()
      vim.keymap.set({ 'n', 'x', 'o' }, '<leader>k', '<Plug>(leap-backward)',
        { desc = '[k] leap up ↑', noremap = true, silent = true })
      vim.keymap.set({ 'n', 'x', 'o' }, '<leader>j', '<Plug>(leap-forward)',
        { desc = '[j] leap down ↓', noremap = true, silent = true })
    end,
  },

  -- Treesitter (syntax highlighting, code navigation, etc)
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  --   ____    _    ____    ____       _                       _
  --  |  _ \  / \  |  _ \  |  _ \  ___| |__  _   _  __ _  __ _(_)_ __   __ _
  --  | | | |/ _ \ | |_) | | | | |/ _ \ '_ \| | | |/ _` |/ _` | | '_ \ / _` |
  --  | |_| / ___ \|  __/  | |_| |  __/ |_) | |_| | (_| | (_| | | | | | (_| |
  --  |____/_/   \_\_|     |____/ \___|_.__/ \__,_|\__, |\__, |_|_| |_|\__, |
  --                                               |___/ |___/         |___/
  --
  {
    "mfussenegger/nvim-dap",
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
  {
    --- Plugin to spawn a neovim iframe for a text field
    ---
    --  _____ _                     _
    -- |  ___(_)_ __ ___ _ ____   _(_)_ __ ___
    -- | |_  | | '__/ _ \ '_ \ \ / / | '_ ` _ \
    -- |  _| | | | |  __/ | | \ V /| | | | | | |
    -- |_|   |_|_|  \___|_| |_|\_/ |_|_| |_| |_|
    --
    ---
    'glacambre/firenvim',
    build = ":call firenvim#install(0)"
  },

  {
    --- Plugin to pick a currently open buffer
    --  ____        _            
    -- / ___| _ __ (_)_ __   ___ 
    -- \___ \| '_ \| | '_ \ / _ \
    --  ___) | | | | | |_) |  __/
    -- |____/|_| |_|_| .__/ \___|
    --               |_|         
    "leath-dub/snipe.nvim",
    keys = {
      {"<leader><space>", function () require("snipe").open_buffer_menu() end, desc = "Open Snipe buffer menu"}
    },
    opts = {}
  },

  {
    --   ____               _ _     _            
    --  / ___|_ __ ___   __| | |   (_)_ __   ___ 
    -- | |   | '_ ` _ \ / _` | |   | | '_ \ / _ \
    -- | |___| | | | | | (_| | |___| | | | |  __/
    --  \____|_| |_| |_|\__,_|_____|_|_| |_|\___|
    --                                           
    "VonHeikemen/fine-cmdline.nvim",
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

  {
    --  _____ __  __ _   ___  __  _   _             _             _             
    -- |_   _|  \/  | | | \ \/ / | \ | | __ ___   _(_) __ _  __ _| |_ ___  _ __ 
    --   | | | |\/| | | | |\  /  |  \| |/ _` \ \ / / |/ _` |/ _` | __/ _ \| '__|
    --   | | | |  | | |_| |/  \  | |\  | (_| |\ V /| | (_| | (_| | || (_) | |   
    --   |_| |_|  |_|\___//_/\_\ |_| \_|\__,_| \_/ |_|\__, |\__,_|\__\___/|_|   
    --                                                |___/                     
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  }

}, {})

--
--   ____      _                     _
--  / ___|___ | | ___  _ __ ___  ___| |__   ___ _ __ ___   ___
-- | |   / _ \| |/ _ \| '__/ __|/ __| '_ \ / _ \ '_ ` _ \ / _ \
-- | |__| (_) | | (_) | |  \__ \ (__| | | |  __/ | | | | |  __/
--  \____\___/|_|\___/|_|  |___/\___|_| |_|\___|_| |_| |_|\___|
--
--
-- Configure theme style to -- JNI addition
-- require('onedark').setup {
--   style = 'warmer'
-- }
-- require('onedark').load()

vim.cmd.colorscheme "catppuccin"
-- Alternatives:
-- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha


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


require("config.0_plugins").load()
require("config.1_settings").load()
require("config.2_keymap").load()
require("jni_additions").load()
