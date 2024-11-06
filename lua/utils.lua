local M = {}

--- Sets key mappings for the specified modes.
-- @param map The function used to set the key mappings.
-- @param keymaps A table containing keys and their parameters (functions and descriptions).
-- Each entry can include:
--   - `func`: The function to be called when the key is pressed.
--   - `desc`: A description of the key.
--   - `modes` (optional): A table of modes for the key mapping. If not provided, defaults to normal mode ("n").
-- @param bufnr (optional) The buffer number, if key mappings should be set only for a specific buffer.
function M.set_keymaps(map, keymaps, bufnr)
	for key, value in pairs(keymaps) do
		local modes = value.modes or "n"
		local options = { desc = value.desc }
		if bufnr then
			options.buffer = bufnr
		end
		map(modes, key, value.func, options)
	end
end

--- Checks if the current directory is a Git repository.
-- @return boolean indicating whether the current directory is a Git repository.
function M.is_git_repo()
	local handle = io.popen "git rev-parse --is-inside-work-tree 2>/dev/null"
	if handle then
		local result = handle:read "*a"
		handle:close()
		return result:match "^true" ~= nil
	end
	return false
end

-- Helper function to parse output
local function parse_output(proc)
	local result = proc:wait()
	local ret = {}
	if result.code == 0 then
		for line in vim.gsplit(result.stdout, "\n", { plain = true, trimempty = true }) do
			-- Remove trailing slash
			line = line:gsub("/$", "")
			ret[line] = true
		end
	end
	return ret
end

-- Build git status cache
-- @return A table that caches ignored and tracked files in the specified Git repository.
function M.new_git_status()
	return setmetatable({}, {
		__index = function(self, key)
			local ignore_proc = vim.system(
				{ "git", "ls-files", "--ignored", "--exclude-standard", "--others", "--directory" },
				{ cwd = key, text = true }
			)
			local tracked_proc = vim.system({ "git", "ls-tree", "HEAD", "--name-only" }, { cwd = key, text = true })
			local ret = { ignored = parse_output(ignore_proc), tracked = parse_output(tracked_proc) }

			rawset(self, key, ret)
			return ret
		end,
	})
end

--- Get the current color scheme from the base46 cache.
-- @return table|nil Returns a table containing colors if the loading is successful.
function M.get_base46_colors()
	local success, colors = pcall(dofile, vim.g.base46_cache .. "colors")
	if not success then
		vim.notify("Cache file not found. Please restart Neovim.", vim.log.levels.WARN)
		return nil
	end
	return colors
end

M.CREATE_UNDO = vim.api.nvim_replace_termcodes("<c-G>u", true, true, true)
function M.create_undo()
	if vim.api.nvim_get_mode().mode == "i" then
		vim.api.nvim_feedkeys(M.CREATE_UNDO, "n", false)
	end
end

return M
