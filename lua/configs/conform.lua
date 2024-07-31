local options = {
  formatters_by_ft = {
    -- scripts
    lua = { "stylua" },
    bash = { "shfmt" },
    python = { "ruff_format", "black" },
    c = { "clang-format" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    scss = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    yaml = { "prettier" },
    json = { "prettier" },
    jsonc = { "prettier" },
    markdown = { "prettier" },
  },
}

require("conform").setup(options)
