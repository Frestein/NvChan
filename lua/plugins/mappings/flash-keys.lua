local flash = require "flash"
local keymap_utils = require "utils.keymap"
local langmapper = require "langmapper"
local map_handler = langmapper.map
local original_set_keymap = langmapper.original_set_keymap

local labels = "олджавыфгнрткепимйцуячсшщзьбюАВЫФОЛДЖЙЦУКЕНГШЩЗ"

for _, mode in pairs { "n", "x", "o" } do
	original_set_keymap(mode, "s", "", {
		desc = "Flash",
		callback = flash.jump,
	})
	original_set_keymap(mode, "ы", "", {
		desc = "Flash",
		callback = function()
			flash.jump {
				labels = labels,
			}
		end,
	})
	original_set_keymap(mode, "S", "", {
		desc = "Flash Treesitter",
		callback = flash.treesitter,
	})
	original_set_keymap(mode, "Ы", "", {
		desc = "Flash Treesitter",
		callback = function()
			flash.treesitter {
				labels = labels,
			}
		end,
	})
end

for _, mode in pairs { "x", "o" } do
	original_set_keymap(mode, "R", "", {
		desc = "Flash Treesitter (search)",
		callback = flash.treesitter_search,
	})
	original_set_keymap(mode, "К", "", {
		desc = "Flash Treesitter (search)",
		callback = function()
			flash.treesitter_search {
				labels = labels,
			}
		end,
	})
end

original_set_keymap("o", "r", "", {
	desc = "Remote Flash",
	callback = flash.remote,
})
original_set_keymap("o", "к", "", {
	desc = "Remote Flash",
	callback = function()
		flash.remote {
			labels = labels,
		}
	end,
})

--- @type Keymap[]
local keymaps = {
	{ mode = { "c" }, "<c-s>", flash.toggle, "Toggle Flash Search" },
}

keymap_utils.map(map_handler, keymaps)
