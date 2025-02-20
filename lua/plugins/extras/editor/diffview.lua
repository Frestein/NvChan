return {
	{
		"sindrets/diffview.nvim",
		opts = function()
			dofile(vim.g.base46_cache .. "diffview")
			return {}
		end,
	},
}
