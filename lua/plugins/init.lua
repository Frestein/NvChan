return {
  {
    "williamboman/mason.nvim",
    keys = {
      { "<leader>mm", desc = "mason open home" },
      { "<leader>mi", desc = "mason install all packages" },
      { "<leader>mu", desc = "mason update packages" },
    },
    opts = require "plugins.options.mason-opts",
    config = function(_, opts)
      require("mason").setup(opts)
      require "plugins.mappings.mason-keys"
    end,
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    keys = {
      { mode = { "n", "v" }, "<leader>fc", desc = "code format code" },
    },
    opts = require "plugins.options.conform-opts",
    config = function(_, opts)
      require("conform").setup(opts)
      require "plugins.configs.conform-conf"
      require "plugins.mappings.conform-keys"
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
    cmd = "Oil",
    keys = {
      { "<leader>e", desc = "file open parent directory" },
      { "<leader>fl", desc = "file open parent directory (float)" },
    },
    opts = require "plugins.options.oil-opts",
    config = function(_, opts)
      require("oil").setup(opts)
      require "plugins.mappings.oil-keys"
    end,
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
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      { "<leader>ff", desc = "telescope find files" },
      { "<leader>fm", desc = "telescope find marks" },
      { "<leader>fw", desc = "telescope live grep" },
      { "<leader>fb", desc = "telescope find buffers" },
      { "<leader>fh", desc = "telescope help page" },
      { "<leader>fo", desc = "telescope find oldfiles" },
      { "<leader>fz", desc = "telescope find in current buffer" },
      { "<leader>ftd", desc = "telescope find diagnostics" },
      { "<leader>pt", desc = "telescope pick hidden term" },
      { "<leader>th", desc = "telescope nvchad themes" },
    },
    opts = require "plugins.options.telescope-opts",
    config = function(_, opts)
      require("telescope").setup(opts)
      require "plugins.mappings.telescope-keys"
    end,
  },

  {
    "tsakirist/telescope-lazy.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fip",
        function()
          require("telescope").extensions.lazy.lazy()
        end,
        desc = "telescope installed plugins",
      },
    },
  },

  {
    "nvim-telescope/telescope-project.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope").extensions.project.project()
        end,
        desc = "telescope find projects",
      },
    },
  },

  {
    "jvgrootveld/telescope-zoxide",
    dependencies = {
      { "stevearc/oil.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    keys = {
      {
        "<leader>zl",
        function()
          require("telescope").extensions.zoxide.list()
        end,
        desc = "telescope zoxide list",
      },
    },
  },

  {
    "debugloop/telescope-undo.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fu",
        function()
          require("telescope").extensions.undo.undo()
        end,
        desc = "telescope find undo",
      },
    },
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
    keys = {
      { "<leader>gg", desc = "neogit open" },
      { "<leader>gl", desc = "neogit log" },
    },
    opts = require "plugins.options.neogit-opts",
    config = function(_, opts)
      require("neogit").setup(opts)
      require "plugins.mappings.neogit-keys"

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
    version = "4.4.7",
    keys = {
      { "<leader>nd", desc = "notices dismiss all visible messages" },
      { "<leader>nl", desc = "notices show the last message" },
      { "<leader>nh", desc = "notices show the notice history" },
      { "<leader>fn", desc = "telescope find notices" },
    },
    opts = require "plugins.options.noice-opts",
    config = function()
      require "plugins.configs.noice-conf"
      require "plugins.mappings.noice-keys"
    end,
  },

  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TodoTrouble", "TodoTelescope" },
    keys = {
      { "<leader>td", desc = "toggle diagnostics" },
      { "<leader>tt", desc = "todo-comments show the todo-list" },
      { "<leader>ftt", desc = "telescope todo-list" },
    },
    dependencies = {
      {
        "folke/todo-comments.nvim",
        opts = {},
      },
    },
    config = function(_, opts)
      require("trouble").setup(opts)
      require "plugins.mappings.trouble-keys"
    end,
  },

  {
    "michaelrommel/nvim-silicon",
    keys = {
      { mode = "v", "<leader>ss", desc = "snapshot screenshot code" },
      { mode = "v", "<leader>sf", desc = "snapshot screenshot code as file" },
      { mode = "v", "<leader>sc", desc = "snapshot screenshot code to clipboard" },
    },
    opts = require "plugins.options.silicon-opts",
    config = function(_, opts)
      require("nvim-silicon").setup(opts)
      require "plugins.mappings.silicon-keys"
    end,
  },

  {
    "aznhe21/actions-preview.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    opts = require "plugins.options.actions-preview-opts",
    config = function(_, opts)
      require("actions-preview").setup(opts)
    end,
  },

  {
    "wakatime/vim-wakatime",
    lazy = false,
  },

  -- {
  --   "fladson/vim-kitty",
  --   event = "BufEnter */kitty/*.conf",
  -- },

  {
    "okuuva/auto-save.nvim",
    event = { "InsertLeave", "TextChanged" },
    opts = require "plugins.options.auto-save-opts",
  },

  {
    "xvzc/chezmoi.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "alker0/chezmoi.vim",
        init = function()
          vim.g["chezmoi#use_tmp_buffer"] = true
        end,
      },
    },
    keys = {
      {
        "<leader>fd",
        function()
          require("telescope").extensions.chezmoi.find_files()
        end,
        desc = "telescope find dotfiles",
      },
    },
    opts = require "plugins.options.chezmoi-opts",
  },

  {
    "folke/zen-mode.nvim",
    keys = {
      {
        "<leader>mz",
        desc = "toggle zen-mode",
      },
    },
    opts = require "plugins.options.zen-mode-opts",
    config = function(_, opts)
      require("zen-mode").setup(opts)
      require "plugins.mappings.zen-mode-keys"
    end,
  },

  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    opts = {},
  },

  {
    "nvim-neorg/neorg",
    dependencies = {
      "luarocks.nvim",
      "nvim-neorg/neorg-telescope",
    },
    event = "VeryLazy",
    version = "*",
    opts = require "plugins.options.neorg-opts",
    config = function(_, opts)
      require("neorg").setup(opts)
      require "plugins.mappings.neorg-keys"
    end,
  },

  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    opts = {},
  },

  {
    "SmiteshP/nvim-navic",
    event = "LspAttach",
    opts = require "plugins.options.navic-opts",
  },

  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    keys = {
      {
        "<leader>qS",
        desc = "session select session",
      },
      {
        "<leader>qs",
        desc = "restore session",
      },
      {
        "<leader>ql",
        desc = "restore last session",
      },
      {
        "<leader>qd",
        desc = "session don't save current session",
      },
    },
    config = function(_, opts)
      require("persistence").setup(opts)
      require "plugins.mappings.persistence-keys"
    end,
  },

  {
    "Wansmer/symbol-usage.nvim",
    event = "LspAttach",
    opts = require "plugins.options.symbol-usage-opts",
  },

  {
    "karb94/neoscroll.nvim",
    keys = {
      { mode = { "n", "v" }, "<C-u>" },
      { mode = { "n", "v" }, "<C-d>" },
      { mode = { "n", "v" }, "<C-b>" },
      { mode = { "n", "v" }, "<C-f>" },
      { mode = { "n", "v" }, "<C-y>" },
      { mode = { "n", "v" }, "<C-e>" },
      { mode = { "n", "v" }, "zt" },
      { mode = { "n", "v" }, "zz" },
      { mode = { "n", "v" }, "zb" },
    },
    opts = require "plugins.options.neoscroll-opts",
    config = function(_, opts)
      require("neoscroll").setup(opts)
      require "plugins.mappings.neoscroll-keys"
    end,
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { mode = { "n", "x", "o" }, "s", desc = "flash jump" },
      { mode = { "n", "x", "o" }, "S", desc = "flash treesitter" },
      { mode = { "x", "o" }, "R", desc = "flash treesitter search" },
      { mode = "o", "r", desc = "flash remote" },
      { mode = "c", "<c-s>", desc = "flash toggle flash search" },
    },
    config = function(_, opts)
      require("flash").setup(opts)
      require "plugins.mappings.flash-keys"
    end,
  },

{
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {}
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
