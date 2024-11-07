local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map

local M = {}

M.on_attach = function(bufnr)
	--- @type Keymap[]
	local keymaps = {
		{ "<leader>grh", "<cmd>Telescope reset_hunk<cr>", "telescope reset hunk" },
		{ "<leader>gph", "<cmd>Telescope preview_hunk<cr>", "telescope preview hunk" },
		{ "<leader>gb", "<cmd>telescope blame_line<cr>", "gitsigns blame line" },
		{ "<leader>gtb", "<cmd>Telescope toggle_current_line_blame<cr>", "gitsigns toggle blame line" },
		{ "<leader>gtd", "<cmd>Telescope toggle_deleted<cr>", "gitsigns toggle deleted" },
		{ "<leader>gtn", "<cmd>Telescope toggle_numhl<cr>", "gitsigns toggle number highlight" },
		{ "<leader>gc", "<cmd>Telescope git_commits<cr>", "telescope git commits" },
		{ "<leader>gs", "<cmd>Telescope git_status<cr>", "telescope git status" },
	}
	keymap_utils.add_params_to_desc(keymaps, { buffer = bufnr })
	keymap_utils.map(map_handler, keymaps)
end

return M
