dofile(vim.g.base46_cache .. "telescope")

return {
	defaults = {
		prompt_prefix = "   ",
		selection_caret = " ",
		entry_prefix = " ",
		sorting_strategy = "descending",
		layout_config = {
			vertical = {
				prompt_position = "top",
				preview_width = 0.55,
			},
			width = 0.87,
			height = 0.80,
		},
	},
	extensions_list = {
		"aerial",
		"ast_grep",
		"chezmoi",
		"fzf",
		"heading",
		"import",
		"lazy",
		"noice",
		"smart_open",
		"terms",
		"themes",
		"todo-comments",
		"undo",
		"zoxide",
	},
	extensions = {
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
		zoxide = {
			mappings = {
				["<C-f>"] = {
					action = function(selection)
						vim.cmd.cd(selection.path)
						require("telescope").extensions.smart_open.smart_open {
							cwd_only = true,
							filename_first = true,
						}
					end,
				},
			},
		},
	},
}
