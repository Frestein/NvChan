local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map
local neogit = require "neogit"

--- @type Keymap[]
local keymaps = {
	{ "<leader>gg", neogit.open, "neogit open" },
	{
		"<leader>gl",
		function()
			neogit.open { "log" }
		end,
		"neogit log",
	},
}

keymap_utils.map(map_handler, keymaps)
