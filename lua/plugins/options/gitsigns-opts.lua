dofile(vim.g.base46_cache .. "git")

return {
	signs = {
		delete = { text = "󰍵" },
		changedelete = { text = "󱕖" },
	},
	current_line_blame = true,
	current_line_blame_opts = { delay = 500 },
	on_attach = function(bufnr)
		require("plugins.mappings.gitsigns-keys").on_attach(bufnr)
	end,
}
