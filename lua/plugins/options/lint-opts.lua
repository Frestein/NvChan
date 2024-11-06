return {
	events = {
		"BufReadPost",
		"BufWritePost",
		"InsertLeave",
		"TextChanged",
	},
	linters_by_ft = {
		["yaml.ansible"] = { "ansible_lint" },
		bash = { "shellharden", "shellcheck" },
		dockerfile = { "hadolint" },
		go = { "golangcilint" },
		gomod = { "golangcilint" },
		lua = { "selene" },
		python = { "ruff" },
		yaml = { "yamllint" },
	},
}
