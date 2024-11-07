local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map
local treesj = require "treesj"

--- @type Keymap[]
local keymaps = {
	{ "<leader>m", treesj.toggle, "treesj toggle node under cursor" },
	{
		"<leader>M",
		function()
			treesj.toggle { split = { recursive = true } }
		end,
		"treesj toggle node recursive under cursor",
	},
	{ "<leader>j", treesj.join, "treesj join node under cursor" },
	{ "<leader>s", treesj.split, "treesj split node under cursor" },
}

keymap_utils.map(map_handler, keymaps)
