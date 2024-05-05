return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
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
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- lua
        "lua-language-server",
        "stylua",

        -- web
        "html-lsp",
        "css-lsp",
        "prettier",

        -- python
        "pyright",
        "black",

        -- shell
        "shellharden",
        "bash-language-server",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- vim
        "vim",
        "vimdoc",

        -- scripts
        "c",
        "lua",
        "bash",
        "python",

        -- web
        "css",
        "scss",
        "html",
        "json",
        "jsonc",

        -- JVM
        "kotlin",

        -- hyprland
        "hyprlang",

        -- markdown
        "markdown",
        "markdown_inline",

        -- rofi
        "rasi",
      },
    },
  },
  {
    "wakatime/vim-wakatime",
    lazy = false,
  },
  {
    "michaelrommel/nvim-silicon",
    lazy = true,
    cmd = "Silicon",
    config = function()
      require("silicon").setup {
        font = "JetBrainsMono Nerd Font=34;Noto Color Emoji=34",
        to_clipboard = true,
        theme = "Nord",
        pad_horiz = 50,
        pad_vert = 40,
        window_title = function()
          return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
        end,
      }
    end,
  },
}
