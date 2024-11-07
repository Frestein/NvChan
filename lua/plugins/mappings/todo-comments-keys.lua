local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map

--- @type Keymap[]
local keymaps = {
	{ "<leader>tt", "<cmd>TodoTrouble<cr>", "todo-comments show the todo-list" },
	{ "<leader>tq", "<cmd>TodoQuickFix<cr>", "todo-comments show quickfix" },
	{ "<leader>fT", "<cmd>TodoTelescope<cr>", "telescope todo-list" },
}

keymap_utils.map(map_handler, keymaps)
