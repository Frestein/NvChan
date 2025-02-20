return {
	"zeioth/garbage-day.nvim",
	dependencies = "neovim/nvim-lspconfig",
	event = "LspAttach",
	opts = {
		grace_period = 60 * 10,
	},
}
