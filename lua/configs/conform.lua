local options = {
  formatters_by_ft = {
    -- scripts
    lua = { "stylua" },
    bash = { "shellharden" },
    python = { "black" },

    -- web
    scss = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    yaml = { "prettier" },
    json = { "prettier" },

    -- docs
    markdown = { "prettier" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

require("conform").setup(options)
