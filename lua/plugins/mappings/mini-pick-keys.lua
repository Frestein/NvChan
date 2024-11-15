require("utils").on_load("mini.pick", function()
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
end)

return {
	{
		"<leader>ff",
		function()
			MiniPick.builtin.files { tool = "rg" }
		end,
		desc = "Find Files",
	},
	{
		"<leader>fz",
		function()
			MiniExtra.pickers.buf_lines { scope = "current" }
		end,
		desc = "Find Pattern (buffer)",
	},
	{
		"<leader>fw",
		function()
			MiniPick.builtin.grep()
		end,
		desc = "Find Pattern (grep)",
	},
	{
		"<leader>fW",
		function()
			MiniPick.builtin.grep_live()
		end,
		desc = "Find Pattern (live grep)",
	},
	{
		"<leader>fb",
		function()
			MiniPick.builtin.buffers()
		end,
		desc = "Find Buffers",
	},
	{
		"<leader>fH",
		function()
			MiniPick.builtin.help()
		end,
		desc = "Find Help",
	},
	{
		"<leader>fm",
		function()
			MiniExtra.pickers.marks()
		end,
		desc = "Find Marks",
	},
	{
		"<leader>th",
		function()
			MiniPick.registry.themes()
		end,
		desc = "Find Themes",
	},
	{
		-- spellchecker: disable-line
		"<leader>fo",
		function()
			MiniExtra.pickers.oldfiles()
		end,
		desc = "Find Files (recent)",
	},
	{
		"<leader>fs",
		function()
			MiniExtra.pickers.spellsuggest()
		end,
		desc = "Find Spell Suggestions",
	},
	{
		"<leader>fgb",
		function()
			MiniExtra.pickers.git_branches()
		end,
		desc = "Find Branches",
	},
	{
		"<leader>fgc",
		function()
			MiniExtra.pickers.git_commits()
		end,
		desc = "Find Commits",
	},
	{
		"<leader>fgf",
		function()
			MiniExtra.pickers.git_files()
		end,
		desc = "Find Files (git)",
	},
	{
		"<leader>fgh",
		function()
			MiniExtra.pickers.git_hunks()
		end,
		desc = "Find Hunks",
	},
	{
		"<leader>fsh",
		function()
			MiniExtra.pickers.history()
		end,
		desc = "Find History",
	},
	{
		"<leader>fhl",
		function()
			MiniExtra.pickers.hl_groups()
		end,
		desc = "Find highlights",
	},
	{
		"<leader>fk",
		function()
			MiniExtra.pickers.keymaps()
		end,
		desc = "Find Keymaps",
	},
}
