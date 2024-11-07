local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map
local refactoring = require "refactoring"

--- @type Keymap[]
local keymaps = {
	{
		mode = { "x" },
		"<leader>re",
		function()
			refactoring.refactor "Extract Function"
		end,
		"refactor extract function",
	},
	{
		mode = { "x" },
		"<leader>rf",
		function()
			refactoring.refactor "Extract Function To File"
		end,
		"refactor extract function to file",
	},
	{
		mode = { "x" },
		"<leader>rv",
		function()
			refactoring.refactor "Extract Variable"
		end,
		"refactor extract variable",
	},
	{
		"<leader>rI",
		function()
			refactoring.refactor "Inline Function"
		end,
		"refactor inline function",
	},
	{
		mode = { "n", "x" },
		"<leader>ri",
		function()
			refactoring.refactor "Inline Variable"
		end,
		"refactor inline variable",
	},
	{
		"<leader>rb",
		function()
			refactoring.refactor "Extract Block"
		end,
		"refactor extract block",
	},
	{
		"<leader>rB",
		function()
			refactoring.refactor "Extract Block To File"
		end,
		"refactor extract block to file",
	},
	{
		mode = { "n", "x" },
		"<leader>rr",
		refactoring.select_refactor,
		"refactor select refactor",
	},
}

keymap_utils.map(map_handler, keymaps)
