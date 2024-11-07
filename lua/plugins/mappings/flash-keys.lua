local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map
local flash = require "flash"

--- @type Keymap[]
local keymaps = {
	{ mode = { "n", "x", "o" }, "s", flash.jump, "flash jump" },
	{ mode = { "n", "x", "o" }, "S", flash.treesitter, "flash treesitter" },
	{ mode = { "x", "o" }, "R", flash.treesitter_search, "flash treesitter search" },
	{ mode = { "o" }, "r", flash.remote, "flash remote" },
	{ mode = { "c" }, "<c-s>", flash.toggle, "flash toggle flash search" },
}

keymap_utils.map(map_handler, keymaps)
