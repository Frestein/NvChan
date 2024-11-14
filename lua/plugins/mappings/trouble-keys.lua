local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map
local trouble = require "trouble"

--- @type Keymap[]
local keymaps = {
	{
		"gd",
		function()
			trouble.toggle { mode = "lsp_definitions" }
		end,
		"LSP Definitions",
	},
	{
		"gD",
		function()
			trouble.toggle { mode = "lsp_declarations" }
		end,
		"LSP Declarations",
	},
	{
		"gi",
		function()
			trouble.toggle { mode = "lsp_implementations" }
		end,
		"LSP Implementations",
	},
	{
		"gR",
		function()
			trouble.toggle { mode = "lsp_references" }
		end,
		"LSP References",
	},
	{
		"ga",
		function()
			trouble.toggle { mode = "lsp" }
		end,
		"LSP Definitions/References/...",
	},
	{
		"<leader>cd",
		function()
			trouble.toggle { mode = "lsp_type_definitions" }
		end,
		"LSP Type Definitions",
	},
	{
		"<leader>xx",
		function()
			trouble.toggle { mode = "diagnostics" }
		end,
		"Toggle Diagnostics",
	},
	{
		"<leader>xX",
		function()
			trouble.toggle { mode = "diagnostics", filter = { buf = 0 } }
		end,
		"Toggle Diagnostics (buffer)",
	},
	{
		"<leader>xl",
		function()
			trouble.toggle { mode = "loclist" }
		end,
		"Toggle Loclist",
	},
	{
		"<leader>xq",
		function()
			trouble.toggle { mode = "qflist" }
		end,
		"Toggle Quickfix",
	},
	{
		"<leader>cs",
		function()
			trouble.toggle { mode = "symbols", title = false, win = { size = 25, position = "left" } }
		end,
		"Toggle Document Symbols",
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
		"Previous Trouble/Quickfix Item",
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

keymap_utils.map(map_handler, keymaps)
