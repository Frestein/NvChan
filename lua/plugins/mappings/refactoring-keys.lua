return {
	{
		mode = { "n", "x" },
		"<leader>rr",
		function()
			require("refactoring").select_refactor()
		end,
		desc = "Select Refactor",
	},
	{
		mode = { "x" },
		"<leader>rv",
		function()
			require("refactoring").refactor "Extract Variable"
		end,
		desc = "Extract Variable",
	},
	{
		mode = { "x" },
		"<leader>re",
		function()
			require("refactoring").refactor "Extract Function"
		end,
		desc = "Extract Function",
	},
	{
		mode = { "x" },
		"<leader>rf",
		function()
			require("refactoring").refactor "Extract Function To File"
		end,
		desc = "Extract Function (file)",
	},
	{
		"<leader>rb",
		function()
			require("refactoring").refactor "Extract Block"
		end,
		desc = "Extract Block",
	},
	{
		"<leader>rB",
		function()
			require("refactoring").refactor "Extract Block To File"
		end,
		desc = "Extract Block (file)",
	},
	{
		mode = { "n", "x" },
		"<leader>ri",
		function()
			require("refactoring").refactor "Inline Variable"
		end,
		desc = "Inline Variable",
	},
	{
		"<leader>rI",
		function()
			require("refactoring").refactor "Inline Function"
		end,
		desc = "Inline Function",
	},
}
