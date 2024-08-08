local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    bash = { "shellharden" },
    dash = { "shellharden" },
    sh = { "shellharden" },
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
