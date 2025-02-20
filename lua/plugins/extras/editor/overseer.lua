return {
	{
		"stevearc/overseer.nvim",
		opts = {},
		keys = {
			{
				"<leader>o",
				function()
					require("overseer").toggle()
				end,
				desc = "Toggle Overseer",
			},
		},
	},
}
