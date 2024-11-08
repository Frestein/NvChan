local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map
local telescope = require "telescope"
local telescope_builtin = require "telescope.builtin"

--- @type Keymap[]
local keymaps = {
	{ "<leader>ff", telescope_builtin.find_files, "telescope find files" },
	{ "<leader>fm", telescope_builtin.marks, "telescope find marks" },
	{ "<leader>fw", telescope_builtin.live_grep, "telescope live grep" },
	{ "<leader>fb", telescope_builtin.buffers, "telescope find buffers" },
	{ "<leader>fh", telescope_builtin.help_tags, "telescope help page" },
	-- spellchecker: disable-line
	{ "<leader>fr", telescope_builtin.oldfiles, "telescope recent files" },
	{ "<leader>fz", telescope_builtin.current_buffer_fuzzy_find, "telescope find in current buffer" },
	{ "<leader>fd", telescope_builtin.diagnostics, "telescope find diagnostics" },
	{ "<leader>ft", telescope.extensions.terms.terms, "telescope find terms" },
	{ "<leader>th", telescope.extensions.themes.themes, "telescope find themes" },
}

keymap_utils.map(map_handler, keymaps)
