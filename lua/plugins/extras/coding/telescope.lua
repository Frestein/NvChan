return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		event = "VeryLazy",
		dependencies = "nvim-lua/plenary.nvim",
		keys = {
			{
				"<leader>,",
				"<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
				desc = "Buffers",
			},
			{ "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
			-- find
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
			{
				"<leader>fb",
				"<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=true<cr>",
				desc = "Buffers",
			},
			{ "<leader>ft", "<cmd>Telescope themes<cr>", desc = "Find Themes" },
			{ "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
			-- git
			{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Commits" },
			{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Status" },
			-- search
			{ '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
			{ "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
			{ "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
			{ "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
			{ "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
			{ "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
			{ "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
			{ "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
			{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
			{ "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
			{ "<leader>sj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
			{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
			{ "<leader>sl", "<cmd>Telescope loclist<cr>", desc = "Location List" },
			{ "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Marks" },
			{ "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
			{ "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
			{ "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
			{ "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
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
		keys = { { "<leader><space>", "<cmd>Telescope smart_open<cr>", desc = "Find Files (smart)" } },
	},

	{
		"Marskey/telescope-sg",
		dependencies = "nvim-telescope/telescope.nvim",
		keys = { { "<leader>sG", "<cmd>Telescope ast_grep<cr>", desc = "Live Grep (sg)" } },
	},

	{
		"piersolenski/telescope-import.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		keys = { { "<leader>si", "<cmd>Telescope import<cr>", desc = "Imports" } },
	},

	{
		"jvgrootveld/telescope-zoxide",
		dependencies = "nvim-telescope/telescope.nvim",
		keys = { { "<leader>fz", "<cmd>Telescope zoxide list<cr>", desc = "Zoxide List" } },
	},

	{
		"debugloop/telescope-undo.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		keys = { { "<leader>su", "<cmd>Telescope undo<cr>", desc = "Undo" } },
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
