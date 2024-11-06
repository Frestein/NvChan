local set_keymaps = require("utils").set_keymaps
local map = require("langmapper").map

local bufremove = require "mini.bufremove"

local keymaps = {
	["<leader>bd"] = {
		func = function()
			bufremove.delete(0, false)
		end,
		desc = "buffer delete buffer",
	},
	["<leader>bD"] = {
		func = function()
			bufremove.delete(0, true)
		end,
		desc = "buffer delete buffer (force)",
	},
}

set_keymaps(map, keymaps)
