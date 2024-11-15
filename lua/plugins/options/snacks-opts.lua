-- Terminal Mappings
local function term_nav(dir)
	---@param self snacks.terminal
	return function(self)
		return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function()
			vim.cmd.wincmd(dir)
		end)
	end
end

local map_handler = require("langmapper").map

---@type snacks.Config
return {
	bigfile = { enabled = true },
	notifier = { enabled = true },
	quickfile = { enabled = true },
	words = { enabled = true },
	toggle = {
		map = map_handler,
	},
	terminal = {
		win = {
			keys = {
				nav_h = { "<C-h>", term_nav "h", desc = "Go to Left Window", expr = true, mode = "t" },
				nav_j = { "<C-j>", term_nav "j", desc = "Go to Lower Window", expr = true, mode = "t" },
				nav_k = { "<C-k>", term_nav "k", desc = "Go to Upper Window", expr = true, mode = "t" },
				nav_l = { "<C-l>", term_nav "l", desc = "Go to Right Window", expr = true, mode = "t" },
			},
		},
	},
	statuscolumn = {
		enabled = true,
		folds = {
			open = true,
			git_hl = true,
		},
	},
	gitbrowse = {
		url_patterns = {
			["github.com"] = {
				branch = "/tree/{branch}",
				file = "/blob/{branch}/{file}#L{line}",
			},
			["gitlab.com"] = {
				branch = "/-/tree/{branch}",
				file = "/-/blob/{branch}/{file}#L{line}",
			},
			["codeberg.org"] = {
				branch = "/src/branch/{branch}",
				file = "/src/branch/{branch}/{file}#L{line}",
			},
		},
	},
}
