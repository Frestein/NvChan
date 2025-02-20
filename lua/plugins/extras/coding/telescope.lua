return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		event = "VeryLazy",
		dependencies = "nvim-lua/plenary.nvim",
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Find Files (recent)" },
			{ "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Find Pattern (live grep)" },
			{ "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find Pattern (buffer)" },
			{
				"<leader>fb",
				"<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=true<cr>",
				desc = "Find Buffers",
			},
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
			{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Find Diagnostics" },
			{ "<leader>th", "<cmd>Telescope themes<cr>", desc = "Find Themes" },
			{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Find Keymaps" },
			{ "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Find Marks" },
		},
		opts = function()
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
		end,
		config = function(_, opts)
			require("telescope").setup(opts)
			dofile(vim.g.base46_cache .. "telescope")
		end,
	},

	{
		"danielfalk/smart-open.nvim",
		dependencies = {
			"kkharji/sqlite.lua",
			"nvim-telescope/telescope.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
			},
		},
		branch = "0.2.x",
		keys = { { "<leader><leader>", "<cmd>Telescope smart_open<cr>", desc = "Find Files (smart)" } },
	},

	{
		"Marskey/telescope-sg",
		dependencies = "nvim-telescope/telescope.nvim",
		keys = { { "<leader>fW", "<cmd>Telescope ast_grep<cr>", desc = "Find Pattern (sg)" } },
	},

	{
		"piersolenski/telescope-import.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		keys = { { "<leader>fi", "<cmd>Telescope import<cr>", desc = "Find Imports" } },
	},

	{
		"crispgm/telescope-heading.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		keys = { { "<leader>fH", "<cmd>Telescope heading<cr>", desc = "Find Headings" } },
	},

	{
		"jvgrootveld/telescope-zoxide",
		dependencies = "nvim-telescope/telescope.nvim",
		keys = { { "<leader>zl", "<cmd>Telescope zoxide list<cr>", desc = "Zoxide List" } },
	},

	{
		"debugloop/telescope-undo.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		keys = { { "<leader>fu", "<cmd>Telescope undo<cr>", desc = "Find Undo" } },
	},

	{
		"stevearc/dressing.nvim",
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load { plugins = { "dressing.nvim" } }
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load { plugins = { "dressing.nvim" } }
				return vim.ui.input(...)
			end
		end,
	},
}
