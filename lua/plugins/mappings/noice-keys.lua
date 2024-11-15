return {
	{
		"<leader>fn",
		function()
			require("noice").cmd "telescope"
		end,
		desc = "Find Notices",
	},
}
