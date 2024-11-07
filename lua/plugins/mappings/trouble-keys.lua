local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map
local trouble = require "trouble"

--- @type Keymap[]
local keymaps = {
	{
		"<leader>x",
		function()
			trouble.toggle "diagnostics"
		end,
		"trouble toggle diagnostics",
	},
	{ "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "trouble toggle buffer diagnostics" },
	{
		"<leader>cl",
		"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
		"trouble LSP definitions / references / ...",
	},
	{
		"<leader>xl",
		function()
			trouble.toggle "loclist"
		end,
		"trouble toggle location list",
	},
	{
		"<leader>xq",
		function()
			trouble.toggle "qflist"
		end,
		"trouble toggle quickfix list",
	},
	{
		"<leader>xs",
		function()
			trouble.toggle "symbols"
		end,
		"trouble toggle document symbols",
	},
}

keymap_utils.map(map_handler, keymaps)
