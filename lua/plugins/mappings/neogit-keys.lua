local set_keymaps = require("utils").set_keymaps
local map = require("langmapper").map

local neogit = require "neogit"

local keymaps = {
	["<leader>gg"] = { func = neogit.open, desc = "neogit open" },
	["<leader>gl"] = {
		func = function()
			neogit.open { "log" }
		end,
		desc = "neogit log",
	},
}

set_keymaps(map, keymaps)
