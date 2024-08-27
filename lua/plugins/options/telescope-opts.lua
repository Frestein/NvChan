local options = require "nvchad.configs.telescope"

options.extensions_list = {
  "themes",
  "terms",
  "noice",
  "lazy",
  "undo",
  "project",
  "zoxide",
  "chezmoi",
  "heading",
}
options.extensions = {
  lazy_plugins = {
    lazy_config = vim.fn.stdpath "config" .. "/init.lua",
  },
  extensions = {
    heading = {
      treesitter = true,
    },
  },
}

return options
