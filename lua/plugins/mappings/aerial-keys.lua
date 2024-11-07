local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map
local aerial = require "aerial"
local telescope = require "telescope"

local M = {}

function M.lazy()
	--- @type Keymap[]
	local keymaps = {
		{ "<leader>aa", aerial.toggle, "aerial toggle" },
		{ "<leader>an", aerial.nav_toggle, "aerial navigation toggle" },
		{ "<leader>fa", telescope.extensions.aerial.aerial, "telescope aerial" },
	}
	keymap_utils.map(map_handler, keymaps)
end

function M.on_attach(bufnr)
	--- @type Keymap[]
	local keymaps = {
		{ "{", aerial.prev, "aerial previous" },
		{ "}", aerial.next, "aerial next" },
		{ "<leader>af", aerial.focus, "aerial focus" },
		{ "<leader>ao", aerial.open, "aerial open" },
		{ "<leader>aO", aerial.open_all, "aerial open all" },
		{ "<leader>ac", aerial.close, "aerial close" },
		{ "<leader>aC", aerial.close_all, "aerial close all" },
	}
	keymap_utils.add_params_to_desc(keymaps, { buffer = bufnr })
	keymap_utils.map(map_handler, keymaps)
end

return M
