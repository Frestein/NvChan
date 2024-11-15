return {
	{
		"<leader>nf",
		function()
			require "neogen".generate { type = "func" }
		end,
		desc = "Add Function Annotation",
	},
	{
		"<leader>nc",
		function()
			require "neogen".generate { type = "class" }
		end,
		desc = "Add Class Annotation",
	},
	{
		"<leader>nt",
		function()
			require "neogen".generate { type = "type" }
		end,
		desc = "Add Type Annotation",
	},
}
