local opts = require "nvchad.configs.telescope"

opts.defaults = {
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

opts.extensions_list = {
  "fzf",
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
  "smart_open",
}

opts.extensions = {
  fzf = {
    fuzzy = true,
    override_generic_sorter = true,
    override_file_sorter = true,
    case_mode = "smart_case",
  },
  smart_open = {
    match_algorithm = "fzf",
    cwd_only = true,
  },
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
}

return opts
