local M = {}

--- @param name string
function M.get_plugin(name)
	return require("lazy.core.config").spec.plugins[name]
end

function M.is_loaded(name)
	local Config = require "lazy.core.config"
	return Config.plugins[name] and Config.plugins[name]._.loaded
end

---@param name string
---@param fn fun(name:string)
function M.on_load(name, fn)
	if M.is_loaded(name) then
		fn(name)
	else
		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyLoad",
			callback = function(event)
				if event.data == name then
					fn(name)
					return true
				end
			end,
		})
	end
end

---@param fn fun()
function M.on_very_lazy(fn)
	vim.api.nvim_create_autocmd("User", {
		pattern = "VeryLazy",
		callback = function()
			fn()
		end,
	})
end

--- @param name string
function M.opts(name)
	local plugin = M.get_plugin(name)
	if not plugin then
		return {}
	end
	local Plugin = require "lazy.core.plugin"
	return Plugin.values(plugin, "opts", false)
end

--- Checks if the current directory is a Git repository.
--- @return boolean indicating whether the current directory is a Git repository.
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

--- Build git status cache
--- @return table A table that caches ignored and tracked files in the specified Git repository.
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
--- @return table|nil Returns a table containing colors if the loading is successful.
function M.get_base46_colors()
	local ok, colors = pcall(dofile, vim.g.base46_cache .. "colors")
	if not ok then
		vim.notify("Cache file not found. Please restart Neovim.", vim.log.levels.WARN)
		return
	end
	return colors
end

M.CREATE_UNDO = vim.api.nvim_replace_termcodes("<c-G>u", true, true, true)
function M.create_undo()
	if vim.api.nvim_get_mode().mode == "i" then
		vim.api.nvim_feedkeys(M.CREATE_UNDO, "n", false)
	end
end

function M.is_win()
	return vim.uv.os_uname().sysname:find "Windows" ~= nil
end

return M
