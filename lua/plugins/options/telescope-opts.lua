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
}
options.extensions = {
  lazy_plugins = {
    lazy_config = vim.fn.stdpath "config" .. "/init.lua",
  },
  extensions = {
    resession = {
      prompt_title = "Find Sessions",
      dir = "session",
    },
  },
}

return options
