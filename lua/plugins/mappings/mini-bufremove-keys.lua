local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map
local bufremove = require "mini.bufremove"

--- @type Keymap[]
local keymaps = {
	{
		"<leader>bd",
		function()
			bufremove.delete(0, false)
		end,
		"buffer delete buffer",
	},
	{
		"<leader>bD",
		function()
			bufremove.delete(0, true)
		end,
		"buffer delete buffer (force)",
	},
}

keymap_utils.map(map_handler, keymaps)
