return {
	{
		"Frestein/ui",
		lazy = false,
		priority = 900,
		config = function()
			require "nvchad"
		end,
	},

	{
		"folke/noice.nvim",
		lazy = false,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		keys = function()
			return {
				{
					"<leader>fn",
					function()
						require("noice").cmd "telescope"
					end,
					desc = "Find Notices",
				},
			}
		end,
		config = function()
			local noice = require "noice"
			local notify = require "notify"
			local opts = {
				lsp = {
					progress = {
						throttle = 1000 / 30,
					},
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
					signature = {
						enabled = true,
						opts = {
							size = {
								max_width = 65,
								max_height = 20,
							},
						},
					},
				},
				presets = {
					command_palette = true,
					long_message_to_split = true,
					lsp_doc_border = true,
				},
				-- Transparency fix
				views = {
					mini = {
						win_options = {
							winblend = 0,
						},
					},
					hover = {
						size = {
							max_width = 80,
						},
					},
				},
			}

			local augroup = vim.api.nvim_create_augroup
			local autocmd = vim.api.nvim_create_autocmd

			local function setup_lsp_specific_options()
				local clients = vim.lsp.get_clients()

				for _, client in ipairs(clients) do
					if client.name == "pyright" or client.name == "basedpyright" then
						opts.lsp.progress.throttle = 1000 / 5
					end
				end
			end

			local symbol_usage_augroup = augroup("noice_symbol_usage", { clear = true })

			autocmd("LspAttach", {
				group = symbol_usage_augroup,
				callback = function()
					setup_lsp_specific_options()
					noice.setup(opts)
				end,
			})

			noice.setup(opts)

			notify.setup {
				merge_duplicates = true,
				render = "wrapped-compact",
				max_width = 50,
				stages = "fade",
				fps = 75,
			}

			dofile(vim.g.base46_cache .. "notify")
		end,
	},

	{
		"nvim-tree/nvim-web-devicons",
		opts = function()
			dofile(vim.g.base46_cache .. "devicons")

			return {
				override = {
					default_icon = { icon = "󰈚", name = "Default" },
					js = { icon = "󰌞", name = "js" },
					ts = { icon = "󰛦", name = "ts" },
					lock = { icon = "󰌾", name = "lock" },
					["robots.txt"] = { icon = "󰚩", name = "robots" },
				},
			}
		end,
	},

	{
		"folke/snacks.nvim",
		opts = function()
			---@type snacks.Config
			return {
				indent = {
					animate = {
						enabled = false,
					},
					enabled = true,
				},
				input = { enabled = false },
				notifier = { enabled = true },
				scope = { enabled = false },
				scroll = {
					enabled = false,
					animate = {
						easing = "linear",
						fps = 75,
						spamming = 1,
						duration = { step = 15, total = 250 },
					},
				},
				words = { enabled = true },
				toggle = {
					map = require("langmapper").map,
					which_key = true,
					notify = true,
				},
				statuscolumn = {
					enabled = true,
					folds = {
						open = true,
						git_hl = true,
					},
				},
			}
		end,
	},

	{
		"folke/snacks.nvim",
		---@type snacks.Config
		opts = {
			dashboard = { enabled = false },
		},
	},

	{ "MunifTanjim/nui.nvim" },
}
