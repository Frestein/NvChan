return {
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
}
