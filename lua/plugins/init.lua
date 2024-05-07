return {
  {
    "stevearc/conform.nvim",
    config = function()
      require "configs.conform"
    end,
  },

  -- {
  --   "nvimtools/none-ls.nvim",
  --   opts = function()
  --     return require "configs.null-ls"
  --   end,
  --   requires = { "nvim-lua/plenary.nvim" },
  -- },

  {
    "williamboman/mason.nvim",
    opts = function()
      return require "configs.mason"
    end,
  },

  -- {
  --   "williamboman/mason-lspconfig.nvim",
  -- },

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
      require "configs.treesitter"
    end,
  },

  {
    "wakatime/vim-wakatime",
    lazy = false,
  },

  {
    "fladson/vim-kitty",
    event = "BufEnter */kitty.conf",
  },

  {
    "michaelrommel/nvim-silicon",
    cmd = "Silicon",
    config = function()
      require "configs.silicon"
    end,
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
