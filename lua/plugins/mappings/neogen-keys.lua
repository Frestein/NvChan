local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map
local neogen = require "neogen"

--- @type Keymap[]
local keymaps = {
	{
		"<leader>nf",
		function()
			neogen.generate { type = "func" }
		end,
		"Neogen Function",
	},
	{
		"<leader>nc",
		function()
			neogen.generate { type = "class" }
		end,
		"Neogen Function",
	},
	{
		"<leader>nt",
		function()
			neogen.generate { type = "type" }
		end,
		"Neogen Function",
	},
}

keymap_utils.map(map_handler, keymaps)
