local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map
local persistence = require "persistence"

local function close_plugin(plugin, command)
	local status, require = pcall(require, plugin)
	if status and require[command] then
		require[command]()
	end
end

---@param save_session boolean Indicates whether to save the session before quitting.
local function quit_all(save_session)
	close_plugin("trouble", "close")

	if not save_session then
		persistence.stop()
	end

	vim.schedule(function()
		vim.cmd "quitall"
	end)
end

--- @type Keymap[]
local keymaps = {
	{ "<leader>qs", persistence.select, "session select session" },
	{ "<leader>qL", persistence.load, "session restore session" },
	{
		"<leader>ql",
		function()
			persistence.load { last = true }
		end,
		"session last session",
	},
	{
		"<leader>qq",
		function()
			quit_all(true)
		end,
		"session quit all",
	},
	{
		"<leader>qQ",
		function()
			quit_all(false)
		end,
		"session quit all without save session",
	},
}

keymap_utils.map(map_handler, keymaps)
