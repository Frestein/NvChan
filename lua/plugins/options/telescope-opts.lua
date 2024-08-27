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
  "import",
  "heading",
  "aerial",
}
options.extensions = {
  lazy_plugins = {
    lazy_config = vim.fn.stdpath "config" .. "/init.lua",
  },
  extensions = {
    heading = {
      treesitter = true,
    },
    import = {
      insert_at_top = true,
      custom_languages = {
        {
          extensions = { "go", "sh", "python", "lua" },
          insert_at_line = 2,
          regex = [[^(?:import(?:[\"'\s]*([\w*{}\n, ]+)from\s*)?[\"'\s](.*?)[\"'\s].*)]],
        },
      },
    },
  },
}

return options
