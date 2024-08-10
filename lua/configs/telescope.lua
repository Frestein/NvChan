local options = require "nvchad.configs.telescope"

options.extensions_list = { "themes", "terms", "noice", "lazy", "lazy_plugins" }
options.extensions = {
  lazy_plugins = {
    lazy_config = vim.fn.stdpath "config" .. "/init.lua",
  },
}

return options
