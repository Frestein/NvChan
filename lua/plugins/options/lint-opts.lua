return {
	events = {
		"BufReadPost",
		"BufWritePost",
		"InsertLeave",
	},
	linters_by_ft = {
		["yaml.ansible"] = { "ansible_lint" },
		bash = { "shellcheck", "bash" },
		dockerfile = { "hadolint" },
		fish = { "fish" },
		go = { "golangcilint" },
		gomod = { "golangcilint" },
		lua = { "selene" },
		python = { "ruff" },
		sh = { "shellcheck", "bash" },
		systemd = { "systemd-analyze" },
		yaml = { "yamllint" },
		zsh = { "zsh" },
	},
	-- Extension to easily override linter options
	-- or add custom linters.
	---@type table<string,table>
	linters = {
		selene = {
			-- `condition` is another LazyVim extension that allows you to
			-- dynamically enable/disable linters based on the context.
			condition = function(ctx)
				return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
			end,
		},
	},
}
