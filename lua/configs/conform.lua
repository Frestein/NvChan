local options = {
  formatters_by_ft = {
    -- scripts
    lua = { "stylua" },
    bash = { "shfmt" },
    python = { "black", "ruff" },

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
}

require("conform").setup(options)
