local opts = require "nvchad.configs.mason"

opts.ensure_installed = {
  "html-lsp",
  "css-lsp",
  "dockerfile-language-server",
  "hadolint",
  "clangd",
  "clang-format",
  "hyprls",
}

return opts
