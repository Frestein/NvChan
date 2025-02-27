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

			return {
				preset = "helix",
				spec = {
					{
						mode = { "n", "v" },
						{ "<leader><tab>", group = "tabs" },
						{ "<leader>l", group = "lazy" },
						{ "<leader>b", group = "buffers" },
						{ "<leader>c", group = "code" },
						{ "<leader>cA", group = "annotations" },
						{ "<leader>cw", group = "workspace" },
						{ "<leader>d", group = "debug" },
						{ "<leader>r", group = "refactor" },
						{ "<leader>f", group = "file/find" },
						{ "<leader>g", group = "git" },
						{ "<leader>gh", group = "hunks" },
						{ "<leader>q", group = "quit/session" },
						{ "<leader>s", group = "search" },
						{ "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
						{ "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
						{ "[", group = "prev" },
						{ "]", group = "next" },
						{ "g", group = "goto" },
						{ "gs", group = "surround" },
						{ "z", group = "fold" },
						{
							"<leader>b",
							group = "buffer",
							expand = function()
								return require("which-key.extras").expand.buf()
							end,
						},
						{
							"<leader>w",
							group = "windows",
							proxy = "<c-w>",
							expand = function()
								return require("which-key.extras").expand.win()
							end,
						},
					},
				},
			}
		end,
		keys = {
			"<leader>",
			"<c-w>",
			'"',
			"'",
			"`",
			"c",
			"v",
			"g",
			{
				"<leader>?",
				function()
					require("which-key").show { global = false }
				end,
				desc = "Buffer Keymaps (which-key)",
			},
			{
				"<c-w><space>",
				function()
					require("which-key").show { keys = "<c-w>", loop = true }
				end,
				desc = "Window Hydra Mode (which-key)",
			},
		},
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
					delete = { text = "" },
					topdelete = { text = "" },
					changedelete = { text = "󱕖" },
				},
				signs_staged = {
					delete = { text = "" },
					topdelete = { text = "" },
					changedelete = { text = "󱕖" },
				},
				current_line_blame = true,
				current_line_blame_opts = { delay = 200 },
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, desc)
						vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
					end

					-- stylua: ignore start
					map("n", "]h", function()
					  if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					  else
						gs.nav_hunk("next")
					  end
					end, "Next Hunk")
					map("n", "[h", function()
					  if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					  else
						gs.nav_hunk("prev")
					  end
					end, "Prev Hunk")
					map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
					map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
					map({ "n", "v" }, "<leader>ghs", "<cmd>Gitsigns stage_hunk<CR>", "Stage Hunk")
					map({ "n", "v" }, "<leader>ghr", "<cmd>Gitsigns reset_hunk<CR>", "Reset Hunk")
					map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
					map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
					map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
					map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
					map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
					map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
					map("n", "<leader>ghd", gs.diffthis, "Diff This")
					map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
					map("n", "<leader>ugd", "<cmd>Gitsigns toggle_deleted<cr>", "Toggle Deleted Lines")
				end,
			}
		end,
	},
	{
		"gitsigns.nvim",
		opts = function()
			Snacks.toggle({
				name = "Git Signs",
				get = function()
					return require("gitsigns.config").config.signcolumn
				end,
				set = function(state)
					require("gitsigns").toggle_signs(state)
				end,
			}):map "<leader>uG"
		end,
	},

	{
		"folke/trouble.nvim",
		event = "VeryLazy",
		cmd = "Trouble",
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
				"gI",
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
				"gy",
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
				desc = "Toggle Symbols",
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
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = "LazyFile",
		config = function(_, opts)
			require("todo-comments").setup(opts)
			dofile(vim.g.base46_cache .. "todo")
		end,
		-- stylua: ignore
		keys = {
			{ "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
			{ "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
			{ "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
			{ "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
			{ "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
			{ "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
		},
	},
}
