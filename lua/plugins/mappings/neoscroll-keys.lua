local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map
local neoscroll = require "neoscroll"

--- @type Keymap[]
local keymaps = {
	{
		"<C-u>",
		function()
			neoscroll.ctrl_u { duration = 320, easing = "sine" }
		end,
		"scroll scroll up half a page",
	},
	{
		"<C-d>",
		function()
			neoscroll.ctrl_d { duration = 320, easing = "sine" }
		end,
		"scroll scroll down half a page",
	},
	{
		"<C-b>",
		function()
			neoscroll.ctrl_b { duration = 420, easing = "circular", info = "cursorline" }
		end,
		"scroll scroll up one full page",
	},
	{
		"<C-f>",
		function()
			neoscroll.ctrl_f { duration = 420, easing = "circular", info = "cursorline" }
		end,
		"scroll scroll down one full page",
	},
	{
		"<C-y>",
		function()
			neoscroll.scroll(-0.1, { move_cursor = false, duration = 100, easing = "linear", info = "cursorline" })
		end,
		"scroll scroll up a little without moving the cursor",
	},
	{
		"<C-e>",
		function()
			neoscroll.scroll(0.1, { move_cursor = false, duration = 100, easing = "linear", info = "cursorline" })
		end,
		"scroll scroll down a little without moving the cursor",
	},
	{
		"zt",
		function()
			neoscroll.zt { half_win_duration = 250 }
		end,
		"scroll move the current line to the top of the window",
	},
	{
		"zz",
		function()
			neoscroll.zz { half_win_duration = 250 }
		end,
		"scroll center the current line in the window",
	},
	{
		"zb",
		function()
			neoscroll.zb { half_win_duration = 250 }
		end,
		"scroll move the current line to the bottom of the window",
	},
}

for _, keymap in pairs(keymaps) do
	keymap.mode = { "n", "v" }
end

keymap_utils.map(map_handler, keymaps)
