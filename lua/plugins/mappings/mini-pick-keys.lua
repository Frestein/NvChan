local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map

local function reload_theme(name)
	require("chadrc").base46.theme = name
	require("base46").load_all_highlights()
	vim.api.nvim_exec_autocmds("User", { pattern = "NvChadThemeReload" })
end

local hooks = {
	pre_hooks = {},
	post_hooks = {},
}

vim.api.nvim_create_autocmd({ "User" }, {
	pattern = "MiniPickStart",
	group = vim.api.nvim_create_augroup("minipick-pre-hooks", { clear = true }),
	"Invoke pre_hook for specific picker based on source.name.",
	callback = function(...)
		local opts = MiniPick.get_picker_opts() or {}
		local pre_hook = hooks.pre_hooks[opts.source.name] or function(...) end
		pre_hook(...)
	end,
})

vim.api.nvim_create_autocmd({ "User" }, {
	pattern = "MiniPickStop",
	group = vim.api.nvim_create_augroup("minipick-post-hooks", { clear = true }),
	"Invoke post_hook for specific picker based on source.name.",
	callback = function(...)
		local opts = MiniPick.get_picker_opts() or {}
		local post_hook = hooks.post_hooks[opts.source.name] or function(...) end
		post_hook(...)
	end,
})

local selected_theme

hooks.pre_hooks.Themes = function()
	selected_theme = require("chadrc").base46.theme
end

hooks.post_hooks.Themes = function()
	reload_theme(selected_theme)
end

MiniPick.registry.themes = function()
	local themes = require("nvchad.utils").list_themes()
	return MiniPick.start {
		source = {
			name = "Themes",
			items = themes,
			choose = function(item)
				selected_theme = item
			end,
			preview = function(buf_id, item)
				reload_theme(item)
				vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, { item })
			end,
		},
	}
end

--- @type Keymap[]
local keymaps = {
	{
		"<leader>ff",
		function()
			MiniPick.builtin.files { tool = "rg" }
		end,
		"MiniPick find files",
	},
	{ "<leader>fw", MiniPick.builtin.grep, "MiniPick grep files" },
	{ "<leader>fW", MiniPick.builtin.grep_live, "MiniPick live grep files" },
	{ "<leader>fb", MiniPick.builtin.buffers, "MiniPick find buffers" },
	{ "<leader>fH", MiniPick.builtin.help, "MiniPick find help" },
	{ "<leader>fr", MiniPick.builtin.resume, "MiniPick latest picker" },
	{
		"<leader>fz",
		function()
			MiniExtra.pickers.buf_lines { scope = "current" }
		end,
		"MiniPick buffer lines",
	},
	{ "<leader>fm", MiniExtra.pickers.marks, "MiniPick marks" },
	{ "<leader>th", MiniPick.registry.themes, "MiniPick find themes" },
	-- spellchecker: disable-line
	{ "<leader>fo", MiniExtra.pickers.oldfiles, "MiniPick oldfiles" },
	{ "<leader>fs", MiniExtra.pickers.spellsuggest, "MiniPick spell suggestions" },
	{ "<leader>fgb", MiniExtra.pickers.git_branches, "MiniPick git branches" },
	{ "<leader>fgc", MiniExtra.pickers.git_commits, "MiniPick git commits" },
	{ "<leader>fgf", MiniExtra.pickers.git_files, "MiniPick git files" },
	{ "<leader>fgh", MiniExtra.pickers.git_hunks, "MiniPick git hunks" },
	{ "<leader>fsh", MiniExtra.pickers.history, "MiniPick history" },
	{ "<leader>fhl", MiniExtra.pickers.hl_groups, "MiniPick highlight groups" },
	{ "<leader>fch", MiniExtra.pickers.keymaps, "MiniPick keymaps" },
}

keymap_utils.map(map_handler, keymaps)
