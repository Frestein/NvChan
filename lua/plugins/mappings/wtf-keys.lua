local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map
local wtf = require "wtf"

--- @type Keymap[]
local keymaps = {
	{ "<leader>ws", wtf.search, "wtf search diagnostic with duckduckgo" },
}

keymap_utils.map(map_handler, keymaps)
