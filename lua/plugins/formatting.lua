return {
	{
		"stevearc/conform.nvim",
		cmd = "ConformInfo",
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			formatters_by_ft = {
				bash = { "shellharden", "shellcheck", "shfmt" },
				c = { "clang-format" },
				css = { "prettier" },
				dash = { "shfmt" },
				fish = { "fish_indent" },
				go = { "goimports", "gofumpt" },
				html = { "prettier" },
				javascript = { "prettier" },
				json = { "prettier" },
				json5 = { "prettier" },
				jsonc = { "prettier" },
				lua = { "stylua" },
				markdown = { "prettier" },
				python = { "ruff_format", "ruff_organize_imports", "ruff_fix", "black" },
				scss = { "prettier" },
				sh = { "shellharden", "shellcheck", "shfmt" },
				toml = { "taplo" },
				typescript = { "prettier" },
				yaml = { "prettier" },
				zsh = { "shfmt" },
			},
			formatters = {
				prettier = {
					append_args = function()
						return vim.bo.filetype == "jsonc" and { "--trailing-comma", "none" } or {}
					end,
				},
			},
		},
		config = function(_, opts)
			require("conform").setup(opts)

			vim.api.nvim_create_user_command("ConformFormat", function(args)
				local range = nil
				if args.count ~= -1 then
					local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
					range = {
						start = { args.line1, 0 },
						["end"] = { args.line2, end_line:len() },
					}
				end
				require("conform").format { async = true, lsp_fallback = true, range = range }
			end, { range = true })
		end,
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
		keys = {
			{
				mode = { "n", "v" },
				"<leader>cf",
				function()
					require("conform").format({ async = true }, function(err)
						if not err then
							local mode = vim.api.nvim_get_mode().mode
							if vim.startswith(string.lower(mode), "v") then
								vim.api.nvim_feedkeys(
									vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
									"n",
									true
								)
							end
						end
					end)
				end,
				desc = "Format code",
			},
		},
	},
}
