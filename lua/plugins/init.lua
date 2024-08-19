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
      opts = function()
        return require "configs.oil"
      end,
    },
    { import = "nvcommunity.git.diffview" },
    { import = "nvcommunity.git.neogit" },
    { import = "nvcommunity.motion.neoscroll" },
  },

  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
    config = function(_, opts)
      local conform = require "conform"

      conform.setup(opts)
      vim.api.nvim_create_user_command("ConformFormat", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        conform.format { async = true, lsp_fallback = true, range = range }
      end, { range = true })
    end,
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
    enabled = false,
  },

  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = "LspAttach",
    config = function()
      require "configs.lsplines"
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
    opts = require "configs.telescope",
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = require "configs.gitsigns",
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = require "configs.noice",
    config = function(_, opts)
      local noice = require "noice"
      local notify = require "notify"
      local base46 = require "base46"

      noice.setup(opts)

      -- Transparency fix
      local base16 = base46.get_theme_tb "base_16"

      notify.setup {
        background_colour = base16.base00,
      }
    end,
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
    "xvzc/chezmoi.nvim",
    dependencies = {
      "alker0/chezmoi.vim",
      lazy = false,
      init = function()
        vim.g["chezmoi#use_tmp_buffer"] = true
      end,
    },
    opts = require "configs.chezmoi",
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
    "stevearc/resession.nvim",
    opts = {},
  },

  {
    "Wansmer/langmapper.nvim",
    lazy = false,
    priority = 1,
    opts = require "configs.langmapper",
    config = function(_, opts)
      local function escape(str)
        local escape_chars = [[;,."|\]]
        return vim.fn.escape(str, escape_chars)
      end

      local en = [[qwertyuiop[]asdfghjkl;zxcvbnm,.]]
      local ru = [[йцукенгшщзхъфывапролджячсмитьбю]]
      local en_shift = [[QWERTYUIOP{}ASDFGHJKL:ZXCVBNM<>]]
      local ru_shift = [[ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЯЧСМИТЬБЮ]]
      vim.o.langmap = vim.fn.join({ escape(ru_shift) .. ";" .. escape(en_shift), escape(ru) .. ";" .. escape(en) }, ",")

      require("langmapper").setup(opts)
      require("langmapper").hack_get_keymap()
    end,
  },
}
