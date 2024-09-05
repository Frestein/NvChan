return {
  {
    "williamboman/mason.nvim",
    keys = {
      { "<leader>mm", desc = "mason open home" },
      { "<leader>mi", desc = "mason install all packages" },
      { "<leader>mu", desc = "mason update packages" },
    },
    cmd = {
      "Mason",
      "MasonLog",
      "MasonUpdate",
      "MasonInstall",
      "MasonInstallAll",
      "MasonUninstall",
      "MasonUninstallAll",
    },
    opts = require "plugins.options.mason-opts",
    config = function()
      require "plugins.configs.mason-conf"
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
    dependencies = {
      -- { "jcdickinson/codeium.nvim" },
      -- "supermaven-inc/supermaven-nvim",
      "onsails/lspkind.nvim",
    },
    opts = function()
      require "plugins.options.cmp-opts"
    end,
    config = function(_, opts)
      -- table.insert(opts.sources, { name = "codeium" })
      -- table.insert(opts.sources, { name = "supermaven" })
      require("cmp").setup(opts)
    end,
  },

  {
    "onsails/lspkind.nvim",
    opts = require "plugins.options.lspkind-opts",
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
    keys = {
      { "<leader>e", desc = "file open parent directory" },
      { "<leader>fl", desc = "file open parent directory (float)" },
    },
    config = function()
      require "plugins.configs.oil-conf"
      require "plugins.mappings.oil-keys"
    end,
  },

  {
    "mikavilpas/yazi.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      { "<leader>-", desc = "yazi open" },
    },
    opts = require "plugins.options.yazi-opts",
    config = function(_, opts)
      require("yazi").setup(opts)
      require "plugins.mappings.yazi-keys"
    end,
  },

  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    keys = {
      { mode = "i", "<C-f>", desc = "supermaven accept suggestion" },
      { mode = "i", "<C-w>", desc = "supermaven accept word" },
      { mode = "i", "<C-c>", desc = "supermaven clear suggestion" },
    },
    opts = require "plugins.options.supermaven-opts",
    config = function(_, opts)
      require("supermaven-nvim").setup(opts)
    end,
  },

  -- {
  --   "monkoose/neocodeium",
  --   event = "InsertEnter",
  --   opts = require "plugins.options.neocodeium-opts",
  --   keys = {
  --     { mode = "i", "<C-f>", desc = "neocodeium accept suggestion" },
  --     { mode = "i", "<C-w>", desc = "neocodeium accept word" },
  --     { mode = "i", "<C-l>", desc = "neocodeium accept line" },
  --     { mode = "i", "<C-e>", desc = "neocodeium cycle or complete" },
  --     { mode = "i", "<C-r>", desc = "neocodeium cycle or complete (reverse)" },
  --     { mode = "i", "<C-c>", desc = "neocodeium clear" },
  --     { "<leader>tc", desc = "neocodeium chat" },
  --   },
  --   config = function(_, opts)
  --     require("neocodeium").setup(opts)
  --     require "plugins.mappings.neocodeium-keys"
  --   end,
  -- },

  -- {
  --   "jcdickinson/codeium.nvim",
  --   opts = require "plugins.options.codeium-opts",
  -- },

  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
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
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      { "<leader>ff", desc = "telescope find files" },
      { "<leader>fm", desc = "telescope find marks" },
      { "<leader>fw", desc = "telescope live grep" },
      { "<leader>fb", desc = "telescope find buffers" },
      { "<leader>fH", desc = "telescope help page" },
      { "<leader>fo", desc = "telescope find oldfiles" },
      { "<leader>fz", desc = "telescope find in current buffer" },
      { "<leader>fd", desc = "telescope find diagnostics" },
      { "<leader>ft", desc = "telescope find terms" },
      { "<leader>tH", desc = "telescope nvchad themes" },
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
      { "<leader>fW", require("plugins.mappings.telescope-extensions-keys").sg, desc = "telescope live grep (sg)" },
    },
  },

  {
    "tsakirist/telescope-lazy.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    -- stylua: ignore
    keys = {
      { "<leader>fP", require("plugins.mappings.telescope-extensions-keys").lazy, desc = "telescope installed plugins" },
    },
  },

  {
    "nvim-telescope/telescope-project.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>fp", require("plugins.mappings.telescope-extensions-keys").project, desc = "telescope find projects" },
    },
  },

  {
    "piersolenski/telescope-import.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>fi", require("plugins.mappings.telescope-extensions-keys").import, desc = "telescope find imports" },
    },
  },

  {
    "crispgm/telescope-heading.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>fh", require("plugins.mappings.telescope-extensions-keys").heading, desc = "telescope heading list" },
    },
  },

  {
    "jvgrootveld/telescope-zoxide",
    dependencies = {
      { "stevearc/oil.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    keys = {
      { "<leader>fZ", require("plugins.mappings.telescope-extensions-keys").zoxide, desc = "telescope zoxide list" },
    },
  },

  {
    "debugloop/telescope-undo.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>fu", require("plugins.mappings.telescope-extensions-keys").undo, desc = "telescope find undo" },
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
    dependencies = "folke/todo-comments.nvim",
    keys = {
      { "<leader>x", desc = "trouble toggle diagnostics" },
      { "<leader>xx", desc = "trouble toggle buffer diagnostics" },
      { "<leader>cl", desc = "trouble LSP definitions / references / ..." },
      { "<leader>xq", desc = "trouble toggle quickfix list" },
      { "<leader>xs", desc = "trouble toggle document symbols" },
    },
    config = function()
      require("trouble").setup {}
      dofile(vim.g.base46_cache .. "trouble")
      require "plugins.mappings.trouble-keys"
    end,
  },

  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    keys = {
      { "<leader>tt", desc = "todo-comments show the todo list" },
      { "<leader>fT", desc = "telescope todo list" },
    },
    dependencies = "nvim-telescope/telescope.nvim",
    config = function(_, opts)
      require("todo-comments").setup(opts)
      dofile(vim.g.base46_cache .. "todo")
      require "plugins.mappings.todo-comments-keys"
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
      { "<leader>fD", require("plugins.mappings.telescope-extensions-keys").chezmoi, desc = "telescope find dotfiles" },
    },
    opts = require "plugins.options.chezmoi-opts",
  },

  {
    "folke/zen-mode.nvim",
    keys = {
      { "<leader>z", desc = "toggle zen-mode" },
    },
    opts = require "plugins.options.zen-mode-opts",
    config = function(_, opts)
      require("zen-mode").setup(opts)
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
      { "<leader>qS", desc = "session select session" },
      { "<leader>qs", desc = "restore session" },
      { "<leader>ql", desc = "restore last session" },
      { "<leader>qd", desc = "session don't save current session" },
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
    "Isrothy/neominimap.nvim",
    version = "*",
    keys = {
      { "<leader>nm", desc = "minimap toggle global minimap" },
      { "<leader>nr", desc = "minimap refresh global minimap" },
      { "<leader>nw", desc = "minimap toggle minimap for current window" },
      { "<leader>nt", desc = "minimap toggle minimap for current tab" },
      { "<leader>nb", desc = "minimap toggle minimap for current buffer" },
      { "<leader>nf", desc = "minimap switch focus on minimap" },
    },
    init = function()
      vim.g.neominimap = {
        layout = "split",
        split = {
          close_if_last_window = true,
        },
        search = {
          enabled = true,
        },
      }
    end,
    config = function()
      require "plugins.mappings.neominimap-keys"
    end,
  },

  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>a", desc = "aerial toggle" },
      { "<leader>an", desc = "aerial navigation toggle" },
      { "<leader>fa", desc = "telescope aerial" },
    },
    opts = require "plugins.options.aerial-opts",
    config = function(_, opts)
      require("aerial").setup(opts)
      require("plugins.mappings.aerial-keys").lazy()
    end,
  },

  -- {
  --   "stevearc/overseer.nvim",
  --   keys = {
  --     { "<leader>o", desc = "overseer toggle" },
  --   },
  --   opts = {},
  --   config = function(_, opts)
  --     require("overseer").setup(opts)
  --     require "plugins.mappings.overseer-keys"
  --   end,
  -- },

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
      { mode = "o",               "r",      desc = "flash remote" },
      { mode = "c",               "<C-s>",  desc = "flash toggle flash search" },
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
    keys = {
      { "<leader>m", desc = "treesj toggle node under cursor" },
      { "<leader>M", desc = "treesj toggle node recursive under cursor" },
      { "<leader>j", desc = "treesj join node under cursor" },
      { "<leader>s", desc = "treesj split node under cursor" },
    },
    dependencies = "nvim-treesitter/nvim-treesitter",
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

  -- {
  --   "m4xshen/hardtime.nvim",
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --   },
  --   event = "VeryLazy",
  --   opts = require "plugins.options.hardtime-opts",
  -- },

  {
    "piersolenski/wtf.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    keys = {
      {
        "<leader>ws",
        desc = "wtf search diagnostic with duckduckgo",
      },
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
    "Wansmer/langmapper.nvim",
    lazy = false,
    priority = 1000,
    opts = require "plugins.options.langmapper-opts",
    config = function(_, opts)
      require "plugins.configs.langmapper-conf"
      require("langmapper").setup(opts)
      require("langmapper").hack_get_keymap()
    end,
  },
}
