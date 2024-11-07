local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map
local smart_splits = require "smart-splits"

--- @type Keymap[]
local keymaps = {
	{ "<C-S-Left>", smart_splits.resize_left, "split resize left" },
	{ "<C-S-Down>", smart_splits.resize_down, "split resize down" },
	{ "<C-S-Up>", smart_splits.resize_up, "split resize up" },
	{ "<C-S-Right>", smart_splits.resize_right, "split resize right" },
	{ "<C-h>", smart_splits.move_cursor_left, "split move cursor left" },
	{ "<C-j>", smart_splits.move_cursor_down, "split move cursor down" },
	{ "<C-k>", smart_splits.move_cursor_up, "split move cursor up" },
	{ "<C-l>", smart_splits.move_cursor_right, "split move cursor right" },
	{ "<C-\\>", smart_splits.move_cursor_previous, "split move cursor previous" },
	{ "<leader><leader>h", smart_splits.swap_buf_left, "split swap buffer left" },
	{ "<leader><leader>j", smart_splits.swap_buf_down, "split swap buffer down" },
	{ "<leader><leader>k", smart_splits.swap_buf_up, "split swap buffer up" },
	{ "<leader><leader>l", smart_splits.swap_buf_right, "split swap buffer right" },
}

keymap_utils.map(map_handler, keymaps)
