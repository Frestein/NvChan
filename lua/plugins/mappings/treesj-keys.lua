local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map
local treesj = require "treesj"

--- @type Keymap[]
local keymaps = {
	{ "gS", treesj.toggle, "Toggle arguments" },
}

keymap_utils.map(map_handler, keymaps)
