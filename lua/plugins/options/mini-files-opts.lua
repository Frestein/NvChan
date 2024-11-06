local M = {}

function M.create_filter(git_status)
	return function(fs_entry)
		local dir = vim.fs.dirname(fs_entry.path)
		local is_dotfile = vim.startswith(fs_entry.name, ".") and fs_entry.name ~= ".."

		-- if no local directory (e.g. for ssh connections), just hide dotfiles
		if not dir then
			return is_dotfile
		end

		if is_dotfile then
			return git_status[dir].tracked[fs_entry.name]
		else
			return not git_status[dir].ignored[fs_entry.name]
		end
	end
end

local git_status = require("utils").new_git_status()

M.opts = {
	content = {
		filter = M.create_filter(git_status),
	},
	options = {
		permanent_delete = false,
	},
	windows = {
		width_preview = 50,
	},
}

return M
