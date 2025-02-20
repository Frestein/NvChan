return {
	{
		"MagicDuck/grug-far.nvim",
		opts = {
			staticTitle = "Find and Replace",
		},
		keys = {
			{
				"<leader>rw",
				function()
					require("grug-far").open { prefills = { search = vim.fn.expand "<cword>" } }
				end,
				desc = "Search Word",
			},
			{
				"<leader>rс",
				function()
					require("grug-far").open { prefills = { paths = vim.fn.expand "%" } }
				end,
				desc = "Open grug-far (current file)",
			},
			{
				mode = { "x" },
				"<leader>rC",
				function()
					require("grug-far").with_visual_selection { prefills = { paths = vim.fn.expand "%" } }
				end,
				desc = "Search Visual Selection",
			},
		},
	},

	{
		"folke/which-key.nvim",
		cmd = "WhichKey",
		event = "VeryLazy",
		version = "*",
		opts_extend = { "spec" },
		opts = function()
			dofile(vim.g.base46_cache .. "whichkey")

			local lmu = require "langmapper.utils"
			local state = require "which-key.state"
			local check_orig = state.check

			state.check = function(state, key)
				if key ~= nil then
					key = lmu.translate_keycode(key, "default", "ru")
				end

				return check_orig(state, key)
			end

			return {}
		end,
		keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
	},

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = function()
			local mode_s = { "n", "x", "o" }
			local mode_R = { "x", "o" }
			local mode_r = "o"

			require("utils").on_load("flash.nvim", function()
				local map = require("langmapper").original_set_keymap
				local labels =
					"олджавыфгнрткепимйцуячсшщзьбюАВЫФОЛДЖЙЦУКЕНГШЩЗ"

				for _, mode in pairs(mode_s) do
					map(mode, "s", "", {
						desc = "Flash",
						callback = require("flash").jump,
					})
					map(mode, "ы", "", {
						desc = "Flash",
						callback = function()
							require("flash").jump {
								labels = labels,
							}
						end,
					})
					map(mode, "S", "", {
						desc = "Flash Treesitter",
						callback = require("flash").treesitter,
					})
					map(mode, "Ы", "", {
						desc = "Flash Treesitter",
						callback = function()
							require("flash").treesitter {
								labels = labels,
							}
						end,
					})
				end

				for _, mode in pairs(mode_R) do
					map(mode, "R", "", {
						desc = "Flash Treesitter (search)",
						callback = require("flash").treesitter_search,
					})
					map(mode, "К", "", {
						desc = "Flash Treesitter (search)",
						callback = function()
							require("flash").treesitter_search {
								labels = labels,
							}
						end,
					})
				end

				map(mode_r, "r", "", {
					desc = "Remote Flash",
					callback = require("flash").remote,
				})
				map(mode_r, "к", "", {
					desc = "Remote Flash",
					callback = function()
						require("flash").remote {
							labels = labels,
						}
					end,
				})
			end)

			return {
				{ mode = mode_s, "s", desc = "Flash" },
				{ mode = mode_s, "S", desc = "Flash Treesitter" },
				{ mode = mode_R, "R", desc = "Flash Treesitter (search)" },
				{ mode = mode_r, "r", desc = "Remote Flash" },
				{
					mode = { "c" },
					"<c-s>",
					function()
						require("flash").toggle()
					end,
					desc = "Toggle Flash Search",
				},
			}
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "LazyFile",
		opts = function()
			dofile(vim.g.base46_cache .. "git")

			return {
				signs = {
					delete = { text = "󰍵" },
					changedelete = { text = "󱕖" },
				},
				current_line_blame = true,
				current_line_blame_opts = { delay = 200 },
				on_attach = function(bufnr)
					local keymaps = {
						{
							"<leader>uD",
							"<cmd>Gitsigns toggle_deleted<cr>",
							desc = "Toggle Deleted Lines",
						},
						{
							"<leader>ghp",
							"<cmd>Gitsigns preview_hunk<cr>",
							desc = "Preview hunk",
						},
						{
							"<leader>ghr",
							"<cmd>Gitsigns reset_hunk<cr>",
							desc = "Reset Hunk",
						},
						{
							"<leader>gc",
							"<cmd>Telescope git_commits<cr>",
							desc = "Git Commits",
						},
						{
							"<leader>gs",
							"<cmd>Telescope git_status<cr>",
							desc = "Git Status",
						},
					}

					for _, keymap in ipairs(keymaps) do
						vim.keymap.set("n", keymap[1], keymap[2], { desc = keymap.desc, buffer = bufnr })
					end
				end,
			}
		end,
	},

	{
		"folke/trouble.nvim",
		event = "VeryLazy",
		cmd = "Trouble",
		dependencies = "folke/todo-comments.nvim",
		---@type trouble.Config
		opts = {
			preview = {
				type = "main",
			},
			modes = {
				lsp_document_symbols = {
					format = "{kind_icon} {symbol.name}",
				},
			},
		},
		config = function(_, opts)
			require("trouble").setup(opts)
			dofile(vim.g.base46_cache .. "trouble")
		end,
		keys = {
			{
				"gd",
				function()
					require("trouble").toggle { mode = "lsp_definitions" }
				end,
				desc = "Show Definitions",
			},
			{
				"gD",
				function()
					require("trouble").toggle { mode = "lsp_declarations" }
				end,
				desc = "Show Declarations",
			},
			{
				"gi",
				function()
					require("trouble").toggle { mode = "lsp_implementations" }
				end,
				desc = "Show Implementations",
			},
			{
				"gR",
				function()
					require("trouble").toggle { mode = "lsp_references" }
				end,
				desc = "Show References",
			},
			{
				"ga",
				function()
					require("trouble").toggle { mode = "lsp" }
				end,
				desc = "Show Definitions/References/...",
			},
			{
				"<leader>cd",
				function()
					require("trouble").toggle { mode = "lsp_type_definitions" }
				end,
				desc = "Show Type Definitions",
			},
			{
				"<leader>xx",
				function()
					require("trouble").toggle { mode = "diagnostics" }
				end,
				desc = "Toggle Diagnostics",
			},
			{
				"<leader>xX",
				function()
					require("trouble").toggle { mode = "diagnostics", filter = { buf = 0 } }
				end,
				desc = "Toggle Diagnostics (buffer)",
			},
			{
				"<leader>xl",
				function()
					require("trouble").toggle { mode = "loclist" }
				end,
				desc = "Toggle Loclist",
			},
			{
				"<leader>xq",
				function()
					require("trouble").toggle { mode = "qflist" }
				end,
				desc = "Toggle Quickfix",
			},
			{
				"<leader>cs",
				function()
					require("trouble").toggle { mode = "symbols", title = false, win = { size = 25, position = "left" } }
				end,
				desc = "Toggle Document Symbols",
			},
			{
				"[q",
				function()
					if require("trouble").is_open() then
						require("trouble").prev { skip_groups = true, jump = true }
					else
						local ok, err = pcall(vim.cmd.cprev)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Previous Trouble/Quickfix Item",
			},
			{
				"]q",
				function()
					if require("trouble").is_open() then
						require("trouble").next { skip_groups = true, jump = true }
					else
						local ok, err = pcall(vim.cmd.cnext)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Next Trouble/Quickfix Item",
			},
		},
	},

	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoQuickFix", "TodoTelescope" },
		event = "LazyFile",
		config = function(_, opts)
			require("todo-comments").setup(opts)
			dofile(vim.g.base46_cache .. "todo")
		end,
		keys = {
			{ "<leader>tt", "<cmd>TodoTrouble<cr>", desc = "Todo-List (trouble)" },
			{ "<leader>tq", "<cmd>TodoQuickFix<cr>", desc = "Todo-List (quickfix)" },
			{ "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find Todo" },
		},
	},
}
