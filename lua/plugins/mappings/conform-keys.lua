return {
	{
		mode = { "n", "v" },
		"<leader>cf",
		function()
			require("conform").format({ async = true }, function(err)
				if not err then
					local mode = vim.api.nvim_get_mode().mode
					if vim.startswith(string.lower(mode), "v") then
						vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
					end
				end
			end)
		end,
		desc = "Format code",
	},
}
