local set_keymaps = require("utils").set_keymaps
local map = require("langmapper").map

local treesj = require "treesj"

local keymaps = {
	["<leader>m"] = { func = treesj.toggle, desc = "treesj toggle node under cursor" },
	["<leader>M"] = {
		func = function()
			treesj.toggle { split = { recursive = true } }
		end,
		desc = "treesj toggle node recursive under cursor",
	},
	["<leader>j"] = { func = treesj.join, desc = "treesj join node under cursor" },
	["<leader>s"] = { func = treesj.split, desc = "treesj split node under cursor" },
}

set_keymaps(map, keymaps)
