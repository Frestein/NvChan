local set_keymaps = require("utils").set_keymaps
local map = require("langmapper").map

local grug_far = require "grug-far"

local keymaps = {
	["<leader>rw"] = {
		func = function()
			grug_far.open { prefills = { search = vim.fn.expand "<cword>" } }
		end,
		desc = "grug-far open with word under cursor",
	},
	["<leader>rс"] = {
		func = function()
			grug_far.open { prefills = { paths = vim.fn.expand "%" } }
		end,
		desc = "grug-far open for current file",
	},
	["<leader>rC"] = {
		modes = { "x" },
		func = function()
			grug_far.with_visual_selection { prefills = { paths = vim.fn.expand "%" } }
		end,
		desc = "grug-far open with visual selection",
	},
}

set_keymaps(map, keymaps)
