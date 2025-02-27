vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Load compatibility and default options
require "compat"
require "options"

-- Load plugins
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.o.rtp = lazypath .. "," .. vim.o.rtp

local augroup = vim.api.nvim_create_augroup("LazyUserGroup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "lazy",
	desc = "Quit lazy with <Esc>",
	callback = function()
		vim.keymap.set("n", "<Esc>", function()
			vim.api.nvim_win_close(0, false)
		end, { buffer = true, nowait = true })
	end,
	group = augroup,
})

require("lazy").setup({
	{ import = "plugins" },
	{ import = "plugins.extras.ai.supermaven" },
	{ import = "plugins.extras.coding.blink-cmp" },
	{ import = "plugins.extras.coding.luasnip" },
	{ import = "plugins.extras.coding.neogen" },
	{ import = "plugins.extras.coding.telescope" },
	{ import = "plugins.extras.debug.dap" },
	{ import = "plugins.extras.debug.debugprint" },
	{ import = "plugins.extras.editor.diffview" },
	{ import = "plugins.extras.editor.highlight-undo" },
	{ import = "plugins.extras.editor.live-rename" },
	{ import = "plugins.extras.editor.mini-align" },
	{ import = "plugins.extras.editor.mini-files" },
	{ import = "plugins.extras.editor.mini-move" },
	{ import = "plugins.extras.editor.mini-operators" },
	{ import = "plugins.extras.editor.rainbow-delimiters" },
	{ import = "plugins.extras.editor.refactoring" },
	{ import = "plugins.extras.editor.tiny-code-actions" },
	{ import = "plugins.extras.editor.treesj" },
	{ import = "plugins.extras.editor.workspace-diagnostics" },
	{ import = "plugins.extras.fun.drop" },
	{ import = "plugins.extras.lang.go" },
	{ import = "plugins.extras.lang.json" },
	{ import = "plugins.extras.lang.yaml" },
	{ import = "plugins.extras.optimizations.garbage-day" },
	{ import = "plugins.extras.optimizations.man-mode" },
	{ import = "plugins.extras.ui.colorful-winsep" },
	{ import = "plugins.extras.ui.symbol-usage" },
	{ import = "plugins.extras.utils.auto-save" },
	{ import = "plugins.extras.utils.langmapper" },
	{ import = "plugins.extras.utils.neoscroll" },
	{ import = "plugins.extras.utils.silicon" },
}, {
	defaults = { lazy = true },
	checker = { enabled = true },
	install = { colorscheme = { "nvchad" } },
	ui = {
		icons = {
			ft = "",
			cmd = "󰞷",
			lazy = "󰂠 ",
			event = "󰪓",
			loaded = "",
			not_loaded = "",
			keys = " ",
			source = "",
			runtime = "󰢱",
			require = "󰌹",
			start = "",
			list = {
				"●",
				"",
				"",
				"",
			},
		},
		custom_keys = {
			["<localleader>y"] = {
				function(plugin)
					require("lazy.util").float_term { "yazi", plugin.dir }
				end,
				desc = "Open yazi in plugin dir",
			},
		},
	},
	dev = {
		---@type string | fun(plugin: LazyPlugin): string directory where you store your local plugin projects
		path = "~/Projects/plugins/nvim/",
		---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
		patterns = { "Frestein" }, -- For example {"folke"}
		fallback = true, -- Fallback to git when local plugin doesn't exist
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"2html_plugin",
				"tohtml",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
				"matchit",
				"tar",
				"tarPlugin",
				"rrhelper",
				"spellfile_plugin",
				"vimball",
				"vimballPlugin",
				"zip",
				"zipPlugin",
				"tutor",
				"rplugin",
				"syntax",
				"synmenu",
				"optwin",
				"compiler",
				"bugreport",
				"ftplugin",
			},
		},
	},
})

-- Load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- Load autocmds and mappings
require "autocmds"
require "mappings"

-- Load modules
require("modules.improve-visual-block").setup()
require "modules.punto-switcher"

-- Automap keybindings
require("langmapper").automapping { global = true, buffer = false }
