local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map
local lazy = require "lazy"

--- @type Keymap[]
local keymaps = {
	{ "<leader>ll", lazy.home, "lazy open home" },
	{ "<leader>lL", lazy.log, "lazy recent updates" },
	{ "<leader>li", lazy.install, "lazy install missing plugins" },
	{ "<leader>lc", lazy.check, "lazy check updates" },
	{ "<leader>lu", lazy.update, "lazy update plugins" },
	{ "<leader>ls", lazy.sync, "lazy sync plugins" },
	{ "<leader>lh", lazy.health, "lazy open health" },
	{ "<leader>lp", lazy.profile, "lazy open profile" },
}

keymap_utils.map(map_handler, keymaps)
