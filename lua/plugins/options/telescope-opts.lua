dofile(vim.g.base46_cache .. "telescope")

local actions = require "telescope.actions"

local open_with_trouble = function(...)
	return require("trouble.sources.telescope").open(...)
end

local function find_command()
	if 1 == vim.fn.executable "rg" then
		return { "rg", "--files", "--color", "never", "-g", "!.git" }
	elseif 1 == vim.fn.executable "fd" then
		return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
	elseif 1 == vim.fn.executable "fdfind" then
		return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
	elseif 1 == vim.fn.executable "find" and vim.fn.has "win32" == 0 then
		return { "find", ".", "-type", "f" }
	elseif 1 == vim.fn.executable "where" then
		return { "where", "/r", ".", "*" }
	end
end

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
		-- open files in the first window that is an actual file.
		-- use the current window if no other window is available.
		get_selection_window = function()
			local wins = vim.api.nvim_list_wins()
			table.insert(wins, 1, vim.api.nvim_get_current_win())
			for _, win in ipairs(wins) do
				local buf = vim.api.nvim_win_get_buf(win)
				if vim.bo[buf].buftype == "" then
					return win
				end
			end
			return 0
		end,
		mappings = {
			i = {
				["<c-q>"] = open_with_trouble,
				["<a-q>"] = open_with_trouble,
				["<C-Down>"] = actions.cycle_history_next,
				["<C-Up>"] = actions.cycle_history_prev,
				["<C-f>"] = actions.preview_scrolling_down,
				["<C-b>"] = actions.preview_scrolling_up,
			},
			n = {
				["<c-q>"] = open_with_trouble,
				["<a-q>"] = open_with_trouble,
				["q"] = actions.close,
			},
		},
	},
	pickers = {
		find_files = {
			find_command = find_command,
			hidden = true,
		},
	},
	extensions_list = {
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
