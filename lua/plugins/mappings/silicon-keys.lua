local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map
local silicon = require "nvim-silicon"

--- @type Keymap[]
local keymaps = {
	{ "<leader>ss", silicon.shoot, "snapshot screenshot code" },
	{ "<leader>sf", silicon.file, "snapshot screenshot code as file" },
	{ "<leader>sc", silicon.clip, "snapshot screenshot code to clipboard" },
}

for _, keymap in pairs(keymaps) do
	keymap.mode = { "v" }
end

keymap_utils.map(map_handler, keymaps)
