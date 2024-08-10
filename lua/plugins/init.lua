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
      config = function()
        require "configs.oil"
      end,
    },
    { import = "nvcommunity.git.diffview" },
    { import = "nvcommunity.git.neogit" },
    { import = "nvcommunity.motion.neoscroll" },
  },

  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },

  {
    "williamboman/mason.nvim",
    opts = require "configs.mason",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "mfussenegger/nvim-lint",
    event = "LspAttach",
    config = function()
      require "configs.lint"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "configs.treesitter",
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = require "configs.tree",
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = require "configs.telescope",
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = require "configs.noice",
  },

  {
    "michaelrommel/nvim-silicon",
    opts = function()
      return require "configs.silicon"
    end,
  },

  {
    "aznhe21/actions-preview.nvim",
    config = function()
      require "configs.actions-preview"
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
    "folke/zen-mode.nvim",
    opts = require "configs.zen-mode",
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
    opts = require "configs.neorg",
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
    opts = require "configs.navic",
  },

  {
    "Wansmer/langmapper.nvim",
    lazy = false,
    priority = 1,
    opts = function()
      return require "configs.langmapper"
    end,
  },
}
