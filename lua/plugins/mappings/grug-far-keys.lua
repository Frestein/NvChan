local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map
local grug_far = require "grug-far"

--- @type Keymap[]
local keymaps = {
	{
		"<leader>rw",
		function()
			grug_far.open { prefills = { search = vim.fn.expand "<cword>" } }
		end,
		"grug-far open with word under cursor",
	},
	{
		"<leader>rс",
		function()
			grug_far.open { prefills = { paths = vim.fn.expand "%" } }
		end,
		"grug-far open for current file",
	},
	{
		mode = { "x" },
		"<leader>rC",
		function()
			grug_far.with_visual_selection { prefills = { paths = vim.fn.expand "%" } }
		end,
		"grug-far open with visual selection",
	},
}

keymap_utils.map(map_handler, keymaps)
