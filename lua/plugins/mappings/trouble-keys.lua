local set_keymaps = require("utils").set_keymaps
local map = require("langmapper").map

local trouble = require "trouble"

local keymaps = {
	["<leader>x"] = {
		func = function()
			trouble.toggle "diagnostics"
		end,
		desc = "trouble toggle diagnostics",
	},
	["<leader>xx"] = {
		func = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
		desc = "trouble toggle buffer diagnostics",
	},
	["<leader>cl"] = {
		func = "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
		desc = "trouble LSP definitions / references / ...",
	},
	["<leader>xl"] = {
		func = function()
			trouble.toggle "loclist"
		end,
		desc = "trouble toggle location list",
	},
	["<leader>xq"] = {
		func = function()
			trouble.toggle "qflist"
		end,
		desc = "trouble toggle quickfix list",
	},
	["<leader>xs"] = {
		func = function()
			trouble.toggle "symbols"
		end,
		desc = "trouble toggle document symbols",
	},
}

set_keymaps(map, keymaps)
