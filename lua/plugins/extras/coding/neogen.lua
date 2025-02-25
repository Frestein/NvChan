return {
	"danymat/neogen",
	keys = {
		{
			"<leader>cAf",
			function()
				require("neogen").generate { type = "func" }
			end,
			desc = "Add Function Annotation",
		},
		{
			"<leader>cAc",
			function()
				require("neogen").generate { type = "class" }
			end,
			desc = "Add Class Annotation",
		},
		{
			"<leader>cAt",
			function()
				require("neogen").generate { type = "type" }
			end,
			desc = "Add Type Annotation",
		},
	},
	opts = {},
}
