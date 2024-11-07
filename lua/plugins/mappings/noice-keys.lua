local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map
local noice = require "noice"

--- @type Keymap[]
local keymaps = {
	{
		-- spellchecker: disable-line
		"<leader>nd",
		function()
			noice.cmd "dismiss"
		end,
		"notices dismiss all visible messages",
	},
	{
		"<leader>nl",
		function()
			noice.cmd "last"
		end,
		"notices show the last message",
	},
	{
		"<leader>nh",
		function()
			noice.cmd "history"
		end,
		"notices show the notice history",
	},
	{
		"<leader>fn",
		function()
			noice.cmd "telescope"
		end,
		"telescope find notices",
	},
}

keymap_utils.map(map_handler, keymaps)
