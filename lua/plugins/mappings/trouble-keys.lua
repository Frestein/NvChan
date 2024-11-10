local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map
local trouble = require "trouble"

--- @type Keymap[]
local keymaps = {
	{
		"<leader>xx",
		function()
			trouble.toggle "diagnostics"
		end,
		"trouble toggle diagnostics",
	},
	{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "trouble toggle buffer diagnostics" },
	{
		"<leader>xL",
		function()
			trouble.toggle "loclist"
		end,
		"trouble toggle location list",
	},
	{
		"<leader>xQ",
		function()
			trouble.toggle "qflist"
		end,
		"trouble toggle quickfix list",
	},
	{
		"<leader>cs",
		function()
			trouble.toggle "symbols"
		end,
		"trouble toggle document symbols",
	},
	{
		"<leader>cS",
		"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
		"trouble LSP definitions / references / ...",
	},
}

keymap_utils.map(map_handler, keymaps)
