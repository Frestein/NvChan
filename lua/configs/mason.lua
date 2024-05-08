local options = {
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
    "ruff",

    -- JVM
    "kotlin-language-server",

    -- shell
    "shellharden",
    "bash-language-server",
  },
}

return options
