local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map
local conform = require "conform"

--- @type Keymap[]
local keymaps = {
	{
		mode = { "n", "v" },
		"<leader>cf",
		function()
			conform.format({ async = true }, function(err)
				if not err then
					local mode = vim.api.nvim_get_mode().mode
					if vim.startswith(string.lower(mode), "v") then
						vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
					end
				end
			end)
		end,
		"code format code",
	},
}

keymap_utils.map(map_handler, keymaps)
