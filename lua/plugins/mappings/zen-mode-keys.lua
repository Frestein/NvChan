local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map
local zen_mode = require "zen-mode"

--- @type Keymap[]
local keymaps = {
	{ "<leader>z", zen_mode.toggle, "toggle zen-mode" },
}

keymap_utils.map(map_handler, keymaps)
