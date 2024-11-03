return {
  "nvim-lua/plenary.nvim",

  {
    "nvchad/ui",
    config = function()
      require "nvchad"
    end,
  },

  {
    "nvchad/base46",
    lazy = true,
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  "nvchad/volt",

  {
    "Wansmer/langmapper.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require "plugins.configs.langmapper-conf"
    end,
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    keys = {
      { mode = { "n", "v" }, "<leader>fc", desc = "code format code" },
    },
    config = function()
      require "plugins.configs.conform-conf"
      require "plugins.mappings.conform-keys"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    config = function()
      require "plugins.configs.lspconfig-conf"
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
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = require "plugins.options.treesitter-opts",
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "BufReadPost",
    opts = require "plugins.options.treesitter-context-opts",
  },

  {
    "hrsh7th/nvim-cmp",
    url = "https://github.com/iguanacucumber/magazine.nvim",
    event = "VeryLazy",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp", url = "https://github.com/iguanacucumber/mag-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua", url = "https://github.com/iguanacucumber/mag-nvim-lua" },
      { "hrsh7th/cmp-buffer", url = "https://github.com/iguanacucumber/mag-buffer" },
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
      require "plugins.options.cmp-opts"
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    dependencies = "rafamadriz/friendly-snippets",
    config = function()
      require "plugins.configs.luasnip-conf"
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require "plugins.configs.autopairs-conf"
    end,
  },

  {
    "echasnovski/mini.files",
    event = "VeryLazy",
    version = false,
    keys = {
      { mode = { "n" }, "<leader>e", desc = "MiniFiles toggle current directory" },
      { mode = { "n" }, "<leader>E", desc = "MiniFiles toggle root directory" },
    },
    opts = require("plugins.options.mini-files-opts").opts,
    config = function(_, opts)
      require("mini.files").setup(opts)
      require "plugins.mappings.mini-files-keys"
    end,
  },

  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    keys = {
      { mode = { "i" }, "<C-f>", desc = "supermaven accept suggestion" },
      { mode = { "i" }, "<C-w>", desc = "supermaven accept word" },
      { mode = { "i" }, "<C-c>", desc = "supermaven clear suggestion" },
    },
    opts = require "plugins.options.supermaven-opts",
    config = function(_, opts)
      require("supermaven-nvim").setup(opts)
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    config = function()
      require "plugins.configs.indent-blankline-conf"
    end,
  },

  {
    "~whynothugo/lsp_lines.nvim",
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = "LspAttach",
    config = function()
      require "plugins.configs.lsplines-conf"
    end,
  },

  {
    "ray-x/go.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "go", "gomod" },
    config = function(_, opts)
      require("go").setup(opts)
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      { mode = { "n" }, "<leader>ff", desc = "telescope find files" },
      { mode = { "n" }, "<leader>fm", desc = "telescope find marks" },
      { mode = { "n" }, "<leader>fw", desc = "telescope live grep" },
      { mode = { "n" }, "<leader>fb", desc = "telescope find buffers" },
      { mode = { "n" }, "<leader>fH", desc = "telescope help page" },
      -- spellchecker: disable-line
      { mode = { "n" }, "<leader>fo", desc = "telescope find oldfiles" },
      { mode = { "n" }, "<leader>fz", desc = "telescope find in current buffer" },
      { mode = { "n" }, "<leader>fd", desc = "telescope find diagnostics" },
      { mode = { "n" }, "<leader>ft", desc = "telescope find terms" },
      { mode = { "n" }, "<leader>th", desc = "telescope nvchad themes" },
    },
    opts = require "plugins.options.telescope-opts",
    config = function(_, opts)
      require("telescope").setup(opts)
      require "plugins.mappings.telescope-keys"
    end,
  },

  {
    "danielfalk/smart-open.nvim",
    dependencies = {
      "kkharji/sqlite.lua",
      "nvim-telescope/telescope.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
      },
    },
    branch = "0.2.x",
    keys = {
      {
        "<leader><leader>",
        require("plugins.mappings.telescope-extensions-keys").smart,
        desc = "telescope smart open",
      },
    },
  },

  {
    "Marskey/telescope-sg",
    dependencies = "nvim-telescope/telescope.nvim",
    keys = {
      {
        mode = { "n" },
        "<leader>fW",
        require("plugins.mappings.telescope-extensions-keys").sg,
        desc = "telescope live grep (sg)",
      },
    },
  },

  {
    "tsakirist/telescope-lazy.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    keys = {
      {
        mode = { "n" },
        "<leader>fP",
        require("plugins.mappings.telescope-extensions-keys").lazy,
        desc = "telescope installed plugins",
      },
    },
  },

  {
    "nvim-telescope/telescope-project.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    keys = {
      {
        mode = { "n" },
        "<leader>fp",
        require("plugins.mappings.telescope-extensions-keys").project,
        desc = "telescope find projects",
      },
    },
  },

  {
    "piersolenski/telescope-import.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    keys = {
      {
        mode = { "n" },
        "<leader>fi",
        require("plugins.mappings.telescope-extensions-keys").import,
        desc = "telescope find imports",
      },
    },
  },

  {
    "crispgm/telescope-heading.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    keys = {
      {
        mode = { "n" },
        "<leader>fh",
        require("plugins.mappings.telescope-extensions-keys").heading,
        desc = "telescope heading list",
      },
    },
  },

  {
    "jvgrootveld/telescope-zoxide",
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
    },
    keys = {
      {
        mode = { "n" },
        "<leader>fZ",
        require("plugins.mappings.telescope-extensions-keys").zoxide,
        desc = "telescope zoxide list",
      },
    },
  },

  {
    "debugloop/telescope-undo.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    keys = {
      {
        mode = { "n" },
        "<leader>fu",
        require("plugins.mappings.telescope-extensions-keys").undo,
        desc = "telescope find undo",
      },
    },
  },

  {
    "tzachar/highlight-undo.nvim",
    keys = { { "u" }, { "<C-r>" }, { "p" }, { "P" } },
    opts = {},
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = require "plugins.options.gitsigns-opts",
  },

  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    ft = { "diff" },
    keys = {
      { mode = { "n" }, "<leader>gg", desc = "neogit open" },
      { mode = { "n" }, "<leader>gl", desc = "neogit log" },
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
    "sindrets/diffview.nvim",
    config = function(_, opts)
      require("diffview").setup(opts)

      dofile(vim.g.base46_cache .. "diffview")
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    keys = {
      -- spellchecker: disable-line
      { mode = { "n" }, "<leader>nd", desc = "notices dismiss all visible messages" },
      { mode = { "n" }, "<leader>nl", desc = "notices show the last message" },
      { mode = { "n" }, "<leader>nh", desc = "notices show the notice history" },
      { mode = { "n" }, "<leader>fn", desc = "telescope find notices" },
    },
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
    cmd = { "Trouble" },
    dependencies = "folke/todo-comments.nvim",
    keys = {
      { mode = { "n" }, "<leader>x", desc = "trouble toggle diagnostics" },
      { mode = { "n" }, "<leader>xx", desc = "trouble toggle buffer diagnostics" },
      { mode = { "n" }, "<leader>cl", desc = "trouble LSP definitions / references / ..." },
      { mode = { "n" }, "<leader>xl", desc = "trouble toggle location list" },
      { mode = { "n" }, "<leader>xq", desc = "trouble toggle quickfix list" },
      { mode = { "n" }, "<leader>xs", desc = "trouble toggle document symbols" },
    },
    opts = require "plugins.options.trouble-opts",
    config = function(_, opts)
      require("trouble").setup(opts)
      require "plugins.mappings.trouble-keys"

      dofile(vim.g.base46_cache .. "trouble")
    end,
  },

  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoQuickFix", "TodoTelescope" },
    event = "BufReadPost",
    keys = {
      { mode = { "n" }, "<leader>tt", desc = "todo-comments show the todo list" },
      { mode = { "n" }, "<leader>tq", desc = "todo-comments show quickfix" },
      { mode = { "n" }, "<leader>fT", desc = "telescope todo list" },
    },
    dependencies = "nvim-telescope/telescope.nvim",
    config = function(_, opts)
      require("todo-comments").setup(opts)
      require "plugins.mappings.todo-comments-keys"

      dofile(vim.g.base46_cache .. "todo")
    end,
  },

  {
    "michaelrommel/nvim-silicon",
    keys = {
      { mode = { "v" }, "<leader>ss", desc = "snapshot screenshot code" },
      { mode = { "v" }, "<leader>sf", desc = "snapshot screenshot code as file" },
      { mode = { "v" }, "<leader>sc", desc = "snapshot screenshot code to clipboard" },
    },
    opts = require "plugins.options.silicon-opts",
    config = function(_, opts)
      require("nvim-silicon").setup(opts)
      require "plugins.mappings.silicon-keys"
    end,
  },

  {
    "aznhe21/actions-preview.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
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
        mode = { "n" },
        "<leader>fD",
        require("plugins.mappings.telescope-extensions-keys").chezmoi,
        desc = "telescope find dotfiles",
      },
    },
    opts = require "plugins.options.chezmoi-opts",
  },

  {
    "folke/zen-mode.nvim",
    keys = {
      { mode = { "n" }, "<leader>z", desc = "toggle zen-mode" },
    },
    config = function()
      require "plugins.configs.zen-mode-conf"
      require "plugins.mappings.zen-mode-keys"
    end,
  },

  {
    "folke/twilight.nvim",
    opts = require "plugins.options.twilight-opts",
  },

  {
    "nvim-neorg/neorg",
    dependencies = {
      { "nvim-neorg/neorg-telescope" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    ft = { "norg" },
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
    ft = { "markdown", "norg" },
    opts = {},
  },

  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    keys = {
      { mode = { "n" }, "<leader>qs", desc = "session select session" },
      { mode = { "n" }, "<leader>qL", desc = "session restore session" },
      { mode = { "n" }, "<leader>ql", desc = "session restore last session" },
      { mode = { "n" }, "<leader>qq", desc = "session quit all" },
      { mode = { "n" }, "<leader>qQ", desc = "session quit all without save session" },
    },
    config = function(_, opts)
      require("persistence").setup(opts)
      require "plugins.mappings.persistence-keys"
    end,
  },

  {
    "Wansmer/symbol-usage.nvim",
    event = "LspAttach",
    opts = require("plugins.options.symbol-usage-opts").opts,
  },

  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { mode = { "n" }, "<leader>aa", desc = "aerial toggle" },
      { mode = { "n" }, "<leader>an", desc = "aerial navigation toggle" },
      { mode = { "n" }, "<leader>fa", desc = "telescope aerial" },
    },
    opts = require "plugins.options.aerial-opts",
    config = function(_, opts)
      require("aerial").setup(opts)
      require("plugins.mappings.aerial-keys").lazy()
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      dofile(vim.g.base46_cache .. "devicons")
      return require "plugins.options.web-devicons-opts"
    end,
  },

  {
    "stevearc/overseer.nvim",
    enabled = false,
    keys = {
      { mode = { "n" }, "<leader>o", desc = "overseer toggle" },
    },
    config = function(_, opts)
      require("overseer").setup(opts)
      require "plugins.mappings.overseer-keys"
    end,
  },

  {
    "karb94/neoscroll.nvim",
    -- stylua: ignore
    keys = {
      { mode = { "n", "v" }, "<C-u>", desc = "scroll scroll up half a page" },
      { mode = { "n", "v" }, "<C-d>", desc = "scroll scroll down half a page" },
      { mode = { "n", "v" }, "<C-b>", desc = "scroll scroll up one full page" },
      { mode = { "n", "v" }, "<C-f>", desc = "scroll scroll down one full page" },
      { mode = { "n", "v" }, "<C-y>", desc = "scroll scroll up a little without moving the cursor" },
      { mode = { "n", "v" }, "<C-e>", desc = "scroll scroll down a little without moving the cursor" },
      { mode = { "n", "v" }, "zt",    desc = "scroll move the current line to the top of the window" },
      { mode = { "n", "v" }, "zz",    desc = "scroll center the current line in the window" },
      { mode = { "n", "v" }, "zb",    desc = "scroll move the current line to the bottom of the window" },
    },
    opts = require "plugins.options.neoscroll-opts",
    config = function(_, opts)
      require("neoscroll").setup(opts)
      require "plugins.mappings.neoscroll-keys"
    end,
  },

  {
    "folke/flash.nvim",
    event = "BufReadPost",
    -- stylua: ignore
    keys = {
      { mode = { "n", "x", "o" }, "s",      desc = "flash jump" },
      { mode = { "n", "x", "o" }, "S",      desc = "flash treesitter" },
      { mode = { "x", "o" },      "R",      desc = "flash treesitter search" },
      { mode = { "o" },           "r",      desc = "flash remote" },
      { mode = { "c" },           "<C-s>",  desc = "flash toggle flash search" },
    },
    config = function(_, opts)
      require("flash").setup(opts)
      require "plugins.mappings.flash-keys"
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "BufReadPost",
    opts = {},
  },

  {
    "Wansmer/treesj",
    dependencies = "nvim-treesitter/nvim-treesitter",
    keys = {
      { mode = { "n" }, "<leader>m", desc = "treesj toggle node under cursor" },
      { mode = { "n" }, "<leader>M", desc = "treesj toggle node recursive under cursor" },
      { mode = { "n" }, "<leader>j", desc = "treesj join node under cursor" },
      { mode = { "n" }, "<leader>s", desc = "treesj split node under cursor" },
    },
    opts = require "plugins.options.treesj-opts",
    config = function(_, opts)
      require("treesj").setup(opts)
      require "plugins.mappings.treesj-keys"
    end,
  },

  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    -- stylua: ignore
    keys = {
      { mode = { "x" },       "<leader>re", desc = "refactor extract function" },
      { mode = { "x" },       "<leader>rf", desc = "refactor extract function to file" },
      { mode = { "x" },       "<leader>rv", desc = "refactor extract variable" },
      { mode = { "n" },       "<leader>rI", desc = "refactor inline function" },
      { mode = { "n", "x" },  "<leader>ri", desc = "refactor inline variable" },
      { mode = { "n" },       "<leader>rb", desc = "refactor extract block" },
      { mode = { "n" },       "<leader>rB", desc = "refactor extract block to file" },
      { mode = { "n", "x" },  "<leader>rr", desc = "refactor select refactor" },
    },
    opts = require "plugins.options.refactoring-opts",
    config = function(_, opts)
      require("refactoring").setup(opts)
      require "plugins.mappings.refactoring-keys"
    end,
  },

  {
    "MagicDuck/grug-far.nvim",
    keys = {
      { mode = { "n" }, "<leader>rw", "grug-far open with word under cursor" },
      { mode = { "n" }, "<leader>rc", "grug-far open for current file" },
      { mode = { "x" }, "<leader>rC", "grug-far open with visual selection" },
    },
    opts = require "plugins.options.grug-far-opts",
    config = function(_, opts)
      require("grug-far").setup(opts)
      require "plugins.mappings.grug-far-keys"
    end,
  },

  {
    "folke/drop.nvim",
    event = "VimEnter",
    opts = require "plugins.options.drop-opts",
  },

  {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = require "plugins.options.garbage-day-opts",
  },

  {
    "m4xshen/hardtime.nvim",
    enabled = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    opts = require "plugins.options.hardtime-opts",
  },

  {
    "piersolenski/wtf.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    keys = {
      { mode = { "n" }, "<leader>ws", desc = "wtf search diagnostic with duckduckgo" },
    },
    opts = require "plugins.options.wtf-opts",
    config = function(_, opts)
      require("wtf").setup(opts)
      require "plugins.mappings.wtf-keys"
    end,
  },

  {
    "b0o/schemastore.nvim",
    version = false,
  },

  {
    "echasnovski/mini.bufremove",
    version = false,
    keys = {
      { mode = { "n" }, "<leader>bd", desc = "buffer delete buffer" },
      { mode = { "n" }, "<leader>bD", desc = "buffer delete buffer (force)" },
    },
    config = function(_, opts)
      require("mini.bufremove").setup(opts)
      require "plugins.mappings.mini-bufremove-keys"
    end,
  },

  {
    "echasnovski/mini.pick",
    dependencies = "echasnovski/mini.extra",
    event = "VeryLazy",
    enabled = false,
    version = false,
    keys = {
      { mode = { "n" }, "<leader>ff", desc = "MiniPick find files" },
      { mode = { "n" }, "<leader>fw", desc = "MiniPick grep files" },
      { mode = { "n" }, "<leader>fW", desc = "MiniPick live grep files" },
      { mode = { "n" }, "<leader>fb", desc = "MiniPick find buffers" },
      { mode = { "n" }, "<leader>fH", desc = "MiniPick find help" },
      { mode = { "n" }, "<leader>fr", desc = "MiniPick latest picker" },
      { mode = { "n" }, "<leader>fz", desc = "MiniPick buffer lines" },
      { mode = { "n" }, "<leader>fm", desc = "MiniPick marks" },
      { mode = { "n" }, "<leader>th", desc = "MiniPick nvchad themes" },
      -- spellchecker: disable-line
      { mode = { "n" }, "<leader>fo", desc = "MiniPick oldfiles" },
      { mode = { "n" }, "<leader>fs", desc = "MiniPick spell suggestions" },
      { mode = { "n" }, "<leader>fgb", desc = "MiniPick git branches" },
      { mode = { "n" }, "<leader>fgc", desc = "MiniPick git commits" },
      { mode = { "n" }, "<leader>fgf", desc = "MiniPick git files" },
      { mode = { "n" }, "<leader>fgh", desc = "MiniPick git hunks" },
      { mode = { "n" }, "<leader>fsh", desc = "MiniPick history" },
      { mode = { "n" }, "<leader>fhl", desc = "MiniPick highlight groups" },
      { mode = { "n" }, "<leader>fch", desc = "MiniPick keymaps" },
    },
    config = function(_, opts)
      require("mini.pick").setup(opts)
      require "plugins.mappings.mini-pick-keys"
    end,
  },

  {
    "echasnovski/mini.extra",
    enabled = false,
    version = false,
  },

  {
    "echasnovski/mini.move",
    version = false,
    keys = {
      { mode = { "n", "x" }, "<M-h>", desc = "code block left" },
      { mode = { "n", "x" }, "<M-j>", desc = "code block down" },
      { mode = { "n", "x" }, "<M-k>", desc = "code block up" },
      { mode = { "n", "x" }, "<M-l>", desc = "code block right" },
    },
    opts = {},
  },

  {
    "nvim-zh/colorful-winsep.nvim",
    event = "WinLeave",
    opts = require "plugins.options.colorful-winsep-opts",
  },

  {
    "b0o/incline.nvim",
    event = "BufReadPost",
    config = function()
      require "plugins.configs.incline-conf"
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    opts = function()
      dofile(vim.g.base46_cache .. "whichkey")
      return {}
    end,
  },

  {
    "artemave/workspace-diagnostics.nvim",
    opts = {},
  },

  {
    "mrjones2014/smart-splits.nvim",
    -- stylua: ignore
    keys = {
      { mode = { "n" }, "<C-S-Left>",         desc = "split resize left"          },
      { mode = { "n" }, "<C-S-Down>",         desc = "split resize down"          },
      { mode = { "n" }, "<C-S-Up>",           desc = "split resize up"            },
      { mode = { "n" }, "<C-S-Right>",        desc = "split resize right"         },
      { mode = { "n" }, "<C-h>",              desc = "split move cursor left"     },
      { mode = { "n" }, "<C-j>",              desc = "split move cursor down"     },
      { mode = { "n" }, "<C-k>",              desc = "split move cursor up"       },
      { mode = { "n" }, "<C-l>",              desc = "split move cursor right"    },
      { mode = { "n" }, "<C-\\>",             desc = "split move cursor previous" },
      { mode = { "n" }, "<leader><leader>h",  desc = "split swap buffer left"     },
      { mode = { "n" }, "<leader><leader>j",  desc = "split swap buffer down"     },
      { mode = { "n" }, "<leader><leader>k",  desc = "split swap buffer up"       },
      { mode = { "n" }, "<leader><leader>l",  desc = "split swap buffer right"    },
    },
    config = function(_, opts)
      require("smart-splits").setup(opts)
      require "plugins.mappings.smart-splits-keys"
    end,
  },
}
