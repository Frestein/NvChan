return {
	{
		"<leader>rw",
		function()
			require("grug-far").open { prefills = { search = vim.fn.expand "<cword>" } }
		end,
		desc = "Search Word",
	},
	{
		"<leader>rс",
		function()
			require("grug-far").open { prefills = { paths = vim.fn.expand "%" } }
		end,
		desc = "Open grug-far (current file)",
	},
	{
		mode = { "x" },
		"<leader>rC",
		function()
			require("grug-far").with_visual_selection { prefills = { paths = vim.fn.expand "%" } }
		end,
		desc = "Search Visual Selection",
	},
}
