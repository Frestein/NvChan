local mode_s = { "n", "x", "o" }
local mode_R = { "x", "o" }
local mode_r = "o"

require("utils").on_load("flash.nvim", function()
	local map = require("langmapper").original_set_keymap
	local labels = "олджавыфгнрткепимйцуячсшщзьбюАВЫФОЛДЖЙЦУКЕНГШЩЗ"

	for _, mode in pairs(mode_s) do
		map(mode, "s", "", {
			desc = "Flash",
			callback = require("flash").jump,
		})
		map(mode, "ы", "", {
			desc = "Flash",
			callback = function()
				require("flash").jump {
					labels = labels,
				}
			end,
		})
		map(mode, "S", "", {
			desc = "Flash Treesitter",
			callback = require("flash").treesitter,
		})
		map(mode, "Ы", "", {
			desc = "Flash Treesitter",
			callback = function()
				require("flash").treesitter {
					labels = labels,
				}
			end,
		})
	end

	for _, mode in pairs(mode_R) do
		map(mode, "R", "", {
			desc = "Flash Treesitter (search)",
			callback = require("flash").treesitter_search,
		})
		map(mode, "К", "", {
			desc = "Flash Treesitter (search)",
			callback = function()
				require("flash").treesitter_search {
					labels = labels,
				}
			end,
		})
	end

	map(mode_r, "r", "", {
		desc = "Remote Flash",
		callback = require("flash").remote,
	})
	map(mode_r, "к", "", {
		desc = "Remote Flash",
		callback = function()
			require("flash").remote {
				labels = labels,
			}
		end,
	})
end)

return {
	{ mode = mode_s, "s", desc = "Flash" },
	{ mode = mode_s, "S", desc = "Flash Treesitter" },
	{ mode = mode_R, "R", desc = "Flash Treesitter (search)" },
	{ mode = mode_r, "r", desc = "Remote Flash" },
	{
		mode = { "c" },
		"<c-s>",
		function()
			require("flash").toggle()
		end,
		desc = "Toggle Flash Search",
	},
}
