local options = require "nvchad.configs.telescope"

options.defaults = {
  prompt_prefix = "   ",
  selection_caret = " ",
  entry_prefix = " ",
  layout_config = {
    vertical = {
      prompt_position = "top",
      preview_width = 0.55,
    },
    width = 0.87,
    height = 0.80,
  },
  mappings = {
    n = { ["q"] = require("telescope.actions").close },
  },
}

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
  "ast_grep",
}

options.extensions = {
  lazy_plugins = {
    lazy_config = vim.fn.stdpath "config" .. "/init.lua",
  },
  extensions = {
    ast_grep = {
      command = {
        "sg",
        "--json=stream",
      },
      grep_open_files = false,
    },
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
