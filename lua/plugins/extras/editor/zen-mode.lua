return {
	{
		"folke/zen-mode.nvim",
		opts = {
			plugins = {
				options = {
					laststatus = 1,
				},
			},
		},
		config = function(_, opts)
			local zen_mode = require "zen-mode"

			local ok, incline = pcall(require, "incline")
			if ok then
				opts.on_open = function()
					incline.disable()
				end

				opts.on_close = function()
					incline.enable()
				end
			end

			zen_mode.setup(opts)
		end,
		keys = {
			{
				"<leader>z",
				function()
					require("zen-mode").toggle()
				end,
				desc = "Toggle Zen-Mode",
			},
		},
	},
}
