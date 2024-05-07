local opts = {
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
    "mypy",
    "ruff",

    -- shell
    "shellharden",
    "bash-language-server",
  },
}

return opts
