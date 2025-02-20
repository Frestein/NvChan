return {
	{
		"Wansmer/treesj",
		dependencies = "nvim-treesitter/nvim-treesitter",
		opts = {
			use_default_keymaps = false,
		},
		keys = {
			{
				"gS",
				function()
					require("treesj").toggle()
				end,
				desc = "Toggle Arguments",
			},
		},
	},
}
