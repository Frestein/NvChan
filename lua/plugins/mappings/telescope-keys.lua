local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map

--- @type Keymap[]
local keymaps = {
	{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
	{ "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Telescope find marks" },
	{ "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Telescope live grep" },
	{
		"<leader>fb",
		"<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=true<cr>",
		desc = "Telescope find buffers",
	},
	{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope help page" },
	{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Telescope recent files" },
	{ "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Telescope find in current buffer" },
	{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Telescope find diagnostics" },
	{ "<leader>th", "<cmd>Telescope themes<cr>", desc = "Telescope find themes" },
	{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Telescope find keymaps" },
}

keymap_utils.map(map_handler, keymaps)
