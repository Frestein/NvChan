local options = require "nvchad.configs.mason"

options.ensure_installed = {
  "lua-language-server",
  "stylua",
  "html-lsp",
  "css-lsp",
  "prettier",
  "pyright",
  "black",
  "ruff",
  "yaml-language-server",
  "yamllint",
  "clangd",
  "clang-format",
  "shfmt",
  "shellharden",
  "shellcheck",
  "bash-language-server",
  "hyprls",
  "taplo",
  "selene",
}

return options
