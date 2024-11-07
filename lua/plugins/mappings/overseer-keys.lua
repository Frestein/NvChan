local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map
local overseer = require "overseer"

--- @type Keymap[]
local keymaps = {
	{
		"<leader>o",
		function()
			overseer.toggle()
		end,
		"overseer toggle",
	},
}

keymap_utils.map(map_handler, keymaps)
