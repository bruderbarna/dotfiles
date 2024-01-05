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

require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

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
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {},
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

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
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  {
    "kana/vim-textobj-line",
    dependencies = {
      "kana/vim-textobj-user",
    }
  },

  "vim-scripts/ReplaceWithRegister",
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons",
  "shaunsingh/nord.nvim",
  "christoomey/vim-tmux-navigator",
  "folke/trouble.nvim",
  "windwp/nvim-autopairs",
  "windwp/nvim-ts-autotag",

}, {})

--   use("tpope/vim-repeat")
--   use("kana/vim-textobj-user")
--   use("kana/vim-textobj-entire")
--   use("kana/vim-textobj-line")
--   use("kana/vim-textobj-function")
--   use("vim-scripts/ReplaceWithRegister")
--   use("nvim-tree/nvim-tree.lua")
--   use("nvim-tree/nvim-web-devicons")
--   use("shaunsingh/nord.nvim")
--   use("christoomey/vim-tmux-navigator")
--   use("folke/trouble.nvim")
--   use("windwp/nvim-autopairs")
--   use("windwp/nvim-ts-autotag")

-- return require("packer").startup(function(use)
--   use("wbthomason/packer.nvim")

--   -- tpope goodness
--   use("tpope/vim-surround")
--   use("tpope/vim-commentary")
--   use("tpope/vim-repeat")

--   use("tpope/vim-fugitive")

--   -- text objects
--   use("kana/vim-textobj-user")
--   use("kana/vim-textobj-entire")
--   use("kana/vim-textobj-line")
--   use("kana/vim-textobj-function")
--   use("vim-scripts/ReplaceWithRegister")

--   -- file tree
--   use("nvim-tree/nvim-tree.lua")
--   use("nvim-tree/nvim-web-devicons")

--   use("norcalli/nvim-colorizer.lua")

--   -- colorschemes
--   use("shaunsingh/nord.nvim")
--   use("AlexvZyl/nordic.nvim")

--   use("https://github.com/adelarsq/vim-matchit")

--   -- misc convenience oriented plugins
--   use("gpanders/editorconfig.nvim")

--   use("nvim-lua/popup.nvim")
--   use("nvim-lua/plenary.nvim")
--   use("nvim-telescope/telescope.nvim")

--   use("hrsh7th/cmp-buffer")   -- nvim-cmp source for buffer words
--   use("hrsh7th/cmp-path")     -- nvim-cmp source for paths
--   use("hrsh7th/cmp-nvim-lsp") -- nvim-cmp source for neovim's built-in LSP
--   use("hrsh7th/nvim-cmp")     -- Completion
--   use("L3MON4D3/LuaSnip")
--   use("saadparwaiz1/cmp_luasnip")
--   use("rafamadriz/friendly-snippets")

--   use({
--     'Equilibris/nx.nvim',
--     requires = {
--       'nvim-telescope/telescope.nvim',
--     },
--     config = function()
--       require("nx").setup {}
--     end
--   })

--   use("lewis6991/gitsigns.nvim")

--   use("neovim/nvim-lspconfig")  -- LSP
--   use("nvimtools/none-ls.nvim") -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
--   use("jayp0521/mason-null-ls.nvim")
--   use("williamboman/mason.nvim")
--   use("williamboman/mason-lspconfig.nvim")
--   use({
--     "nvimdev/lspsaga.nvim",
--     branch = "main",
--     config = function()
--       require("lspsaga").setup({
--         code_action = {
--           keys = {
--             quit = { "q", "<ESC>" },
--           },
--         },
--         finder = {
--           keys = {
--             quit = { "q", "<ESC>" },
--           },
--         },
--         rename = {
--           in_select = false,
--         },
--       })
--     end,
--     requires = { { "nvim-tree/nvim-web-devicons" } },
--   })

--   use({
--     "pmizio/typescript-tools.nvim",
--     requires = {
--       "nvim-lua/plenary.nvim",
--       "neovim/nvim-lspconfig"
--     },
--     config = function()
--       require("typescript-tools").setup({})
--     end,
--   })

--   use("folke/trouble.nvim")

--   use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

--   use("windwp/nvim-autopairs")
--   use("windwp/nvim-ts-autotag")

--   if packer_bootstrap then
--     require("packer").sync()
--   end
-- end)
