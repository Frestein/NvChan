return {
  {
    "NvChad/nvcommunity",
    { import = "nvcommunity.completion.tabnine" },
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
    config = function()
      require "configs.conform"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = function()
      return require "configs.mason"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      return require "configs.treesitter"
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = function()
      require "configs.nvim-tree"
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = function()
      dofile(vim.g.base46_cache .. "notify")
      return require "configs.noice"
    end,
  },

  {
    "michaelrommel/nvim-silicon",
    config = function()
      require "configs.nvim-silicon"
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
    opts = function()
      return require "configs.zen-mode"
    end,
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
    opts = function()
      return require "configs.neorg"
    end,
  },

  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    lazy = false,
    opts = {},
  },

  {
    "Wansmer/langmapper.nvim",
    lazy = false,
    priority = 1, -- High priority is needed if you will use `autoremap()`
    config = function()
      require "configs.langmapper"
    end,
  },
}
