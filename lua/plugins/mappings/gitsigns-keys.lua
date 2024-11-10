local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map

local M = {}

M.on_attach = function(bufnr)
	--- @type Keymap[]
	local keymaps = {
		{ "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>", "telescope reset hunk" },
		{ "<leader>ghp", "<cmd>Gitsigns preview_hunk<cr>", "telescope preview hunk" },
		{ "<leader>gd", "<cmd>Gitsigns toggle_deleted<cr>", "gitsigns toggle deleted" },
		{ "<leader>gc", "<cmd>Telescope git_commits<cr>", "telescope git commits" },
		{ "<leader>gs", "<cmd>Telescope git_status<cr>", "telescope git status" },
	}
	keymap_utils.add_params_to_desc(keymaps, { buffer = bufnr })
	keymap_utils.map(map_handler, keymaps)
end

return M
