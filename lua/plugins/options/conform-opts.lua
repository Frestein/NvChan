---@module "conform"
---@type conform.setupOpts
return {
	formatters_by_ft = {
		bash = { "shellharden", "shellcheck", "shfmt" },
		c = { "clang-format" },
		css = { "prettier" },
		fish = { "fish_indent" },
		go = { "goimports", "gofumpt" },
		html = { "prettier" },
		javascript = { "prettier" },
		json = { "prettier" },
		json5 = { "prettier" },
		jsonc = { "prettier" },
		lua = { "stylua" },
		markdown = { "prettier" },
		python = { "ruff_format", "black" },
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
}
