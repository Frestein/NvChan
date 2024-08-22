return {
  {
    "NvChad/nvcommunity",
    { import = "nvcommunity.completion.codeium" },
    { import = "nvcommunity.diagnostics.trouble" },
    { import = "nvcommunity.editor.telescope-undo" },
    { import = "nvcommunity.editor.treesittercontext" },
    { import = "nvcommunity.editor.autosave" },
    {
      "okuuva/auto-save.nvim",
      opts = {
        debounce_delay = 30000,
      },
    },
    { import = "nvcommunity.file-explorer.oil-nvim" },
    {
      "stevearc/oil.nvim",
      opts = require "plugins.options.oil-opts",
    },
    { import = "nvcommunity.git.diffview" },
    { import = "nvcommunity.git.neogit" },
    { import = "nvcommunity.motion.neoscroll" },
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    opts = require "plugins.options.conform-opts",
    config = function(_, opts)
      require("conform").setup(opts)
      require "plugins.configs.conform-conf"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = require "plugins.options.mason-opts",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.options.lspconfig-opts"
    end,
  },

  {
    "mfussenegger/nvim-lint",
    event = "LspAttach",
    config = function()
      require "plugins.configs.lint-conf"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "plugins.options.treesitter-opts",
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = require "plugins.options.tree-opts",
    enabled = false,
  },

  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = "LspAttach",
    config = function()
      require "plugins.configs.lsplines-conf"
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-project.nvim" },
      { "scottmckendry/telescope-resession.nvim" },
      { "tsakirist/telescope-lazy.nvim" },
      { "jvgrootveld/telescope-zoxide" },
    },
    opts = require "plugins.options.telescope-opts",
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = require "plugins.options.gitsigns-opts",
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = require "plugins.options.noice-opts",
    config = function(_, opts)
      require("noice").setup(opts)
      require "plugins.configs.noice-conf"
    end,
  },

  {
    "michaelrommel/nvim-silicon",
    opts = function()
      return require "plugins.options.silicon-opts"
    end,
  },

  {
    "aznhe21/actions-preview.nvim",
    opts = require "plugins.options.actions-preview-opts",
    config = function(_, opts)
      require("actions-preview").setup(opts)
    end,
  },

  {
    "wakatime/vim-wakatime",
    lazy = false,
  },

  {
    "fladson/vim-kitty",
    event = "BufEnter */kitty/*.conf",
  },

  {
    "xvzc/chezmoi.nvim",
    dependencies = {
      "alker0/chezmoi.vim",
      lazy = false,
      init = function()
        vim.g["chezmoi#use_tmp_buffer"] = true
      end,
    },
    opts = require "plugins.options.chezmoi-opts",
  },

  {
    "folke/zen-mode.nvim",
    opts = require "plugins.options.zen-mode-opts",
  },

  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },

  {
    "nvim-neorg/neorg",
    dependencies = {
      "luarocks.nvim",
      "nvim-neorg/neorg-telescope",
    },
    lazy = false,
    version = "*",
    opts = require "plugins.options.neorg-opts",
  },

  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    lazy = false,
    opts = {},
  },

  {
    "SmiteshP/nvim-navic",
    event = "LspAttach",
    opts = require "plugins.options.navic-opts",
  },

  {
    "stevearc/resession.nvim",
    opts = {},
  },

  {
    "Wansmer/langmapper.nvim",
    lazy = false,
    priority = 1,
    opts = require "plugins.options.langmapper-opts",
    config = function(_, opts)
      require "plugins.configs.langmapper-conf"
      require("langmapper").setup(opts)
      require("langmapper").hack_get_keymap()
    end,
  },
}
