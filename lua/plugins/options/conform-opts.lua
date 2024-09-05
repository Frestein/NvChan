local opts = {
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "goimports", "gofumpt" },
    sh = { "shellharden", "shellcheck", "shfmt" },
    python = { "ruff_format", "black" },
    c = { "clang-format" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    scss = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    yaml = { "prettier" },
    json = { "prettier" },
    json5 = { "prettier" },
    jsonc = { "prettier" },
    markdown = { "prettier" },
    toml = { "taplo" },
  },
  formatters = {
    prettier = {
      append_args = function()
        local ft = vim.bo.filetype
        if ft == "jsonc" then
          return { "--trailing-comma", "none" }
        else
          return {}
        end
      end,
    },
  },
}

return opts
