local options = require "nvchad.configs.mason"

options.ensure_installed = {
  "html-lsp",
  "css-lsp",
  "dockerfile-language-server",
  "hadolint",
  "clangd",
  "clang-format",
  "hyprls",
}

return options
