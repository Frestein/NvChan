return {
	{
		mode = "v",
		"<leader>ss",
		function()
			require("nvim-silicon").shoot()
		end,
		desc = "Screenshot Code",
	},
	{
		mode = "v",
		"<leader>sf",
		function()
			require("nvim-silicon").file()
		end,
		desc = "Screenshot Code (file)",
	},
	{
		mode = "v",
		"<leader>sc",
		function()
			require("nvim-silicon").clip()
		end,
		desc = "Screenshot Code (clipboard)",
	},
}
