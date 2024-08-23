return {
  {
    "williamboman/mason.nvim",
    opts = require "plugins.options.mason-opts",
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
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPost",
        opts = require "plugins.options.treesitter-context-opts",
      },
    },
    opts = require "plugins.options.treesitter-opts",
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = require "plugins.options.tree-opts",
    enabled = false,
  },

  {
    "stevearc/oil.nvim",
    event = "VeryLazy",
    cmd = "Oil",
    opts = require "plugins.options.oil-opts",
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "jcdickinson/codeium.nvim",
        opts = {},
      },
    },
    config = function(_, opts)
      table.insert(opts.sources, { name = "codeium" })
      require("cmp").setup(opts)
    end,
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
      { "debugloop/telescope-undo.nvim" },
    },
    opts = require "plugins.options.telescope-opts",
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    dependencies = {
      {
        "sindrets/diffview.nvim",
        opts = {},
      },
    },
    opts = require "plugins.options.gitsigns-opts",
  },

  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    ft = { "diff" },
    opts = require "plugins.options.neogit-opts",
    config = function(_, opts)
      require("neogit").setup(opts)
      dofile(vim.g.base46_cache .. "git")
      dofile(vim.g.base46_cache .. "neogit")
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = require "plugins.options.noice-opts",
    config = function()
      require "plugins.configs.noice-conf"
    end,
  },

  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle", "TodoTrouble", "TodoTelescope" },
    dependencies = {
      {
        "folke/todo-comments.nvim",
        opts = {},
      },
    },
    opts = {},
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
    "okuuva/auto-save.nvim",
    event = { "InsertLeave", "TextChanged" },
    opts = require "plugins.options.auto-save-opts",
  },

  {
    "xvzc/chezmoi.nvim",
    dependencies = {
      {
        "alker0/chezmoi.vim",
        lazy = false,
        init = function()
          vim.g["chezmoi#use_tmp_buffer"] = true
        end,
      },
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
    "Wansmer/symbol-usage.nvim",
    event = "LspAttach",
    opts = require "plugins.options.symbol-usage-opts",
  },

  {
    "karb94/neoscroll.nvim",
    keys = {
      "<C-u>",
      "<C-d>",
    },
    opts = require "plugins.options.neoscroll-opts",
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
