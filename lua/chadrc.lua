-- vim:fileencoding=utf-8:foldmethod=marker

local dashboard = require "modules.dashboard.config"
local statusline = require "modules.statusline"

---@type ChadrcConfig
local M = {}

M.nvdash = {
	header = dashboard.get_header(),
	buttons = dashboard.buttons,
	load_on_startup = true,
}

M.ui = {
	statusline = {
		theme = "minimal",
		separator_style = "block",
		modules = {
			trouble = statusline.trouble,
			lazy = statusline.lazy,
			aw = statusline.aw,
		},
		order = {
			"mode",
			"file",
			"git",
			"%=",
			"lsp_msg",
			"trouble",
			"%=",
			"lsp",
			"lazy",
			"cwd",
			"cursor",
		},
	},
	cmp = {
		style = "default",
		lspkind_text = false,
	},
	tabufline = { order = { "treeOffset", "buffers", "tabs" } },
	telescope = { style = "borderless" },
	border = { style = "rounded" },
}

M.base46 = {
	theme = "gruvbox",
	transparency = false,
	hl_override = {
		Comment = {
			fg = "light_grey",
			italic = true,
		},
		["@comment"] = {
			fg = "light_grey",
			italic = true,
		},
		-- Tabufline {{{
		["TbFill"] = { bg = "NONE" },
		["TbBufOn"] = { bg = "NONE" },
		["TbBufOnClose"] = { bg = "NONE" },
		["TbBufOff"] = { bg = "NONE" },
		["TbBufOffClose"] = { bg = "NONE" },
		-- }}}
	},
	hl_add = {
		["NvimSeparator"] = {
			bg = "NONE",
			fg = "line",
		},
		["WinBar"] = {
			fg = "light_grey",
			bg = "NONE",
		},
		["WinBarNC"] = {
			fg = "light_grey",
			bg = "NONE",
		},
		["StatusLineNC"] = {
			fg = "light_grey",
			bg = "black",
		},
		["AwConnected"] = {
			fg = { "light_grey", 5 },
		},
		-- noice.nvim {{{
		["NoiceLspProgressTitle"] = {
			fg = { "white", -20 },
		},
		-- }}}
		-- foldtext.lua {{{
		["FoldedSpace"] = {
			fg = "NONE",
			bg = "NONE",
		},
		["FoldedIcon"] = {
			fg = "NONE",
		},
		["FoldedText"] = {
			bg = "NONE",
			fg = "light_grey",
			italic = true,
		},
		-- }}}
		-- lazy.nvim statusline module
		["LazyUpdates"] = {
			fg = "green",
			bg = "NONE",
		},
		-- highlight-undo.nvim {{{
		["HighlightUndo"] = {
			bg = { "black", "blue", 40 },
		},
		["HighlightRedo"] = {
			bg = { "black", "red", 40 },
		},
		-- }}}
		-- twilight.nvim {{{
		["Twilight"] = {
			bg = "black",
			fg = "grey_fg",
		},
		-- }}}
		-- gitsigns.nvim {{{
		["GitSignsCurrentLineBlame"] = {
			fg = "light_grey",
			italic = true,
		},
		-- }}}
		-- trouble.nvim {{{
		["TroubleStatusline1"] = {
			fg = "light_grey",
			bg = "black",
		},
		["TroubleSeparatorHighlight"] = {
			fg = "yellow",
			bg = "one_bg",
		},
		-- }}}
		-- neocodeium {{{
		["NeoCodeiumSuggestion"] = { fg = "light_grey" },
		-- }}}
		-- nvim-tree.lua {{{
		["NvimTreeEndOfBuffer"] = { bg = "NONE" },
		["NvimTreeWinSeparator"] = { bg = "NONE" },
		-- }}}
		-- symbol-usage.nvim {{{
		["SymbolUsageRounding"] = {
			fg = "NONE",
		},
		["SymbolUsageContent"] = {
			bg = "NONE",
			fg = "light_grey",
			italic = true,
		},
		["SymbolUsageRef"] = {
			fg = "nord_blue",
			bg = "NONE",
			italic = true,
		},
		["SymbolUsageDef"] = {
			fg = "dark_purple",
			bg = "NONE",
			italic = true,
		},
		["SymbolUsageImpl"] = {
			fg = "yellow",
			bg = "NONE",
			italic = true,
		},
		-- }}}
	},

	integrations = {
		"blankline",
		"cmp",
		"defaults",
		"devicons",
		"diffview",
		"git",
		"notify",
		"statusline",
		"syntax",
		"tbline",
		"telescope",
		"todo",
		"treesitter",
		"trouble",
		"whichkey",
	},
}

M.cheatsheet = {
	theme = "simple",
	excluded_groups = {
		":help (i)",
		":help",
		"LM (x)",
		"LSP (v)",
		"Nvim",
		"Opens",
		"autopairs",
		"general (i)",
		"motion (x)",
		"scroll (v)",
		"terminal (t)",
	},
}

M.lsp = {
	signature = false,
}

return M
