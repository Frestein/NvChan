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
    "ktlint",
    "kotlin-language-server",

    -- yaml
    "yaml-language-server",

    -- c
    "clangd",
    "clang-format",

    -- shell
    "shfmt",
    "bash-language-server",
  },
}

return options
