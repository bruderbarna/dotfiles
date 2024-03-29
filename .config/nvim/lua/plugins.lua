local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- NOTE: First, some plugins that don"t require any configuration

  -- Git related plugins
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gb", "<cmd>G blame<cr>")
    end,
  },

  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",

  "tpope/vim-repeat",

  {
    "tpope/vim-unimpaired",
    config = function()
      vim.cmd("nmap é [")
      vim.cmd("nmap é [")
      vim.cmd("nmap é [")
      vim.cmd("nmap á ]")
      vim.cmd("nmap á ]")
      vim.cmd("nmap á ]")
    end,
  },

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require("fidget").setup({})`
      { "j-hui/fidget.nvim", opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      "folke/neodev.nvim",
    },
  },

  {
    -- Autocompletion
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      "L3MON4D3/LuaSnip",

      -- Adds LSP completion capabilities
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
    },
  },

  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    opts = {},
  },

  -- "gc" to comment visual regions/lines
  { "numToStr/Comment.nvim", opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    config = function()
      vim.keymap.set(
        "n",
        "<leader>j",
        '<cmd>lua require("telescope.builtin").grep_string({search = vim.fn.expand("<cword>")})<cr>'
      )
      vim.keymap.set("n", "<leader>s", "<cmd>Telescope live_grep<cr>")
      vim.keymap.set("n", "<leader>S", function()
        require("telescope.builtin").live_grep({
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "-uu",
          },
        })
      end)
      vim.keymap.set("n", "<leader>f", "<cmd>Telescope git_files<cr>")
      vim.keymap.set(
        "n",
        "<leader>F",
        '<cmd>lua require("telescope.builtin").find_files({follow = true})<cr>'
      )
      vim.keymap.set(
        "n",
        "<leader>qr",
        '<cmd>lua require("telescope.builtin").oldfiles()<cr>'
      )
      -- vim.keymap.set("n", "<leader>/", function()
      --   -- You can pass additional configuration to telescope to change theme, layout, etc.
      --   require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      --     winblend = 10,
      --     previewer = false,
      --   })
      -- end, { desc = '[/] Fuzzily search in current buffer' })
      vim.keymap.set(
        "n",
        "<leader>qh",
        require("telescope.builtin").help_tags,
        { desc = "[S]earch [H]elp" }
      )
      vim.keymap.set(
        "n",
        "<leader>qd",
        require("telescope.builtin").diagnostics,
        { desc = "[S]earch [D]iagnostics" }
      )
      vim.keymap.set(
        "n",
        "<leader>qe",
        require("telescope.builtin").resume,
        { desc = "[S]earch [R]esume" }
      )
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
  },

  {
    "kana/vim-textobj-line",
    dependencies = {
      "kana/vim-textobj-user",
    },
  },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  },

  "vim-scripts/ReplaceWithRegister",

  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 40,
        },
        renderer = {
          group_empty = true,
        },
        on_attach = function(bufnr)
          local api = require("nvim-tree.api")

          local function opts(desc)
            return {
              desc = "nvim-tree: " .. desc,
              buffer = bufnr,
              noremap = true,
              silent = true,
              nowait = true,
            }
          end

          -- default mappings
          api.config.mappings.default_on_attach(bufnr)

          -- custom mappings
          vim.keymap.set("n", "cd", api.tree.change_root_to_node, opts("Up"))
          vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
        end,
      })

      vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<cr>")
      vim.keymap.set("n", "<leader>m", ":NvimTreeFindFile<cr>")
    end,
  },

  "nvim-tree/nvim-web-devicons",

  -- terafox?
  { "EdenEast/nightfox.nvim" },

  {
    "andersevenrud/nordic.nvim",
    config = function()
      vim.cmd([[colorscheme nordic]])
    end,
  },

  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
  },

  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        ts_config = {
          lua = { "string" },
          javascript = { "template_string" },
        },
      })
    end,
  },

  "windwp/nvim-ts-autotag",

  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    },
  },

  {
    "ThePrimeagen/harpoon",
    lazy = false,
    branch = "harpoon2",
    config = function()
      local harpoon = require("harpoon")

      harpoon:setup()

      vim.keymap.set("n", "<leader>hs", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)
      vim.keymap.set("n", "<leader>ha", function()
        harpoon:list():append()
      end)
      vim.keymap.set("n", "<leader>1", function()
        harpoon:list():select(1)
      end)
      vim.keymap.set("n", "<leader>2", function()
        harpoon:list():select(2)
      end)
      vim.keymap.set("n", "<leader>3", function()
        harpoon:list():select(3)
      end)
      vim.keymap.set("n", "<leader>4", function()
        harpoon:list():select(4)
      end)
      vim.keymap.set("n", "<leader>5", function()
        harpoon:list():select(5)
      end)
      vim.keymap.set("n", "<leader>hp", function()
        harpoon:list():prev({ ui_nav_wrap = true })
      end)
      vim.keymap.set("n", "<leader>hn", function()
        harpoon:list():next({ ui_nav_wrap = true })
      end)
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          lua = { "stylua" },
          go = { "goimports" },
          javascript = { "prettierd" },
          javascriptreact = { "prettierd" },
          typescript = { "prettierd" },
          typescriptreact = { "prettierd" },
          scss = { "prettierd" },
          less = { "prettierd" },
          html = { "prettierd" },
          json = { "prettierd" },
          jsonc = { "prettierd" },
          yaml = { "prettierd" },
          markdown = { "prettierd" },
          bash = { "shfmt" },
          sh = { "shfmt" },
        },
        format_on_save = {
          lsp_fallback = true,
          timeout_ms = 500,
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>qf", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        })
      end)
    end,
  },

  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        lua = { "luacheck" },
        go = { "golangcilint" },
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        bash = { "shellcheck" },
        sh = { "shellcheck" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd(
        { "BufEnter", "BufWritePost", "InsertLeave" },
        {
          group = lint_augroup,
          callback = function()
            lint.try_lint()
          end,
        }
      )
    end,
  },
}, {})
