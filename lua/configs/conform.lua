local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    sh = { "shellharden", "shfmt" },
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
    toml = { "taplo" },
  },
}

require("conform").setup(options)
