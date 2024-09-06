local opts = require "nvchad.configs.mason"

opts.ensure_installed = {
  "clangd",
  "clang-format",
}

return opts
