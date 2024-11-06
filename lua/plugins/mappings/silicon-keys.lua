local set_keymaps = require("utils").set_keymaps
local map = require("langmapper").map

local silicon = require "nvim-silicon"

local keymaps = {
	["<leader>ss"] = {
		func = silicon.shoot,
		desc = "snapshot screenshot code",
	},
	["<leader>sf"] = {
		func = silicon.file,
		desc = "snapshot screenshot code as file",
	},
	["<leader>sc"] = {
		func = silicon.clip,
		desc = "snapshot screenshot code to clipboard",
	},
}

for _, keymap in pairs(keymaps) do
	keymap.modes = { "v" }
end

set_keymaps(map, keymaps)
