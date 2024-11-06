local set_keymaps = require("utils").set_keymaps
local map = require("langmapper").map

local zen_mode = require "zen-mode"

local keymaps = {
	["<leader>z"] = { func = zen_mode.toggle, desc = "toggle zen-mode" },
}

set_keymaps(map, keymaps)
