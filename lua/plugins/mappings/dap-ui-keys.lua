return {
	{
		"<leader>du",
		function()
			require("dapui").toggle {}
		end,
		desc = "Dap UI",
	},
	{
		mode = { "n", "v" },
		"<leader>de",
		function()
			require("dapui").eval()
		end,
		desc = "Eval",
	},
}
