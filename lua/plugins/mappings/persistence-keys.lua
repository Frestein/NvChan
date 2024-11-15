local function close_plugin(plugin, command)
	local ok, require = pcall(require, plugin)
	if ok and require[command] then
		require[command]()
	end
end

---@param save_session boolean Indicates whether to save the session before quitting.
local function quit_all(save_session)
	close_plugin("trouble", "close")

	if not save_session then
		require("persistence").stop()
	end

	vim.schedule(function()
		vim.cmd "quitall"
	end)
end

return {
	{
		"<leader>qs",
		function()
			require("persistence").select()
		end,
		desc = "Select Session",
	},
	{
		"<leader>ql",
		function()
			require("persistence").load { last = true }
		end,
		desc = "Load Session (last)",
	},
	{
		"<leader>qq",
		function()
			quit_all(true)
		end,
		desc = "Close Neovim (save session)",
	},
	{
		"<leader>qQ",
		function()
			quit_all(false)
		end,
		desc = "Close Neovim (discard session)",
	},
}
