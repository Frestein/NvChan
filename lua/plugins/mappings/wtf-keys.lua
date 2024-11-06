local set_keymaps = require("utils").set_keymaps
local map = require("langmapper").map

local wtf = require "wtf"

local keymaps = {
	["<leader>ws"] = { func = wtf.search, desc = "wtf search diagnostic with duckduckgo" },
}

set_keymaps(map, keymaps)
