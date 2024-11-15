return {
	{
		"gd",
		function()
			require("trouble").toggle { mode = "lsp_definitions" }
		end,
		desc = "Show Definitions",
	},
	{
		"gD",
		function()
			require("trouble").toggle { mode = "lsp_declarations" }
		end,
		desc = "Show Declarations",
	},
	{
		"gi",
		function()
			require("trouble").toggle { mode = "lsp_implementations" }
		end,
		desc = "Show Implementations",
	},
	{
		"gR",
		function()
			require("trouble").toggle { mode = "lsp_references" }
		end,
		desc = "Show References",
	},
	{
		"ga",
		function()
			require("trouble").toggle { mode = "lsp" }
		end,
		desc = "Show Definitions/References/...",
	},
	{
		"<leader>cd",
		function()
			require("trouble").toggle { mode = "lsp_type_definitions" }
		end,
		desc = "Show Type Definitions",
	},
	{
		"<leader>xx",
		function()
			require("trouble").toggle { mode = "diagnostics" }
		end,
		desc = "Toggle Diagnostics",
	},
	{
		"<leader>xX",
		function()
			require("trouble").toggle { mode = "diagnostics", filter = { buf = 0 } }
		end,
		desc = "Toggle Diagnostics (buffer)",
	},
	{
		"<leader>xl",
		function()
			require("trouble").toggle { mode = "loclist" }
		end,
		desc = "Toggle Loclist",
	},
	{
		"<leader>xq",
		function()
			require("trouble").toggle { mode = "qflist" }
		end,
		desc = "Toggle Quickfix",
	},
	{
		"<leader>cs",
		function()
			require("trouble").toggle { mode = "symbols", title = false, win = { size = 25, position = "left" } }
		end,
		desc = "Toggle Document Symbols",
	},
	{
		"[q",
		function()
			if require("trouble").is_open() then
				require("trouble").prev { skip_groups = true, jump = true }
			else
				local ok, err = pcall(vim.cmd.cprev)
				if not ok then
					vim.notify(err, vim.log.levels.ERROR)
				end
			end
		end,
		desc = "Previous Trouble/Quickfix Item",
	},
	{
		"]q",
		function()
			if require("trouble").is_open() then
				require("trouble").next { skip_groups = true, jump = true }
			else
				local ok, err = pcall(vim.cmd.cnext)
				if not ok then
					vim.notify(err, vim.log.levels.ERROR)
				end
			end
		end,
		desc = "Next Trouble/Quickfix Item",
	},
}
