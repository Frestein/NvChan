local statusline = require "modules.statusline"

---@type ChadrcConfig
local M = {}

M.nvdash = {
	load_on_startup = false,
}

M.ui = {
	statusline = {
		theme = "minimal",
		separator_style = "block",
		modules = {
			trouble = statusline.trouble,
			lazy = statusline.lazy,
		},
		order = {
			"mode",
			"file",
			"git",
			"%=",
			"lsp_msg",
			"trouble",
			"%=",
			"diagnostics",
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
		--- tabufline ---
		TbFill = { bg = "NONE" },
		TbBufOn = { bg = "NONE" },
		TbBufOnClose = { bg = "NONE" },
		TbBufOff = { bg = "NONE" },
		TbBufOffClose = { bg = "NONE" },
	},
	hl_add = {
		NvimSeparator = {
			bg = "NONE",
			fg = "line",
		},
		WinBar = {
			fg = "light_grey",
			bg = "NONE",
		},
		WinBarNC = {
			fg = "light_grey",
			bg = "NONE",
		},
		StatusLineNC = {
			fg = "light_grey",
			bg = "black",
		},
		FloatBorder = {
			fg = "light_grey",
			bg = "darker_black",
		},
		--- mini.files ---
		MiniFilesTitle = {
			fg = "light_grey",
			bg = "darker_black",
		},
		MiniFilesTitleFocused = {
			fg = { "light_grey", 10 },
			bg = "darker_black",
		},
		--- blink.cmp ---
		BlinkCmpGhostText = {
			fg = "light_grey",
			bg = "black2",
		},
		BlinkCmpMenuBorder = {
			fg = "light_grey",
			bg = "one_bg",
		},
		--- snacks.nvim ---
		SnacksIndent = {
			fg = { "grey", -8 },
		},
		SnacksIndentScope = {
			fg = "grey",
		},
		SnacksIndentChunk = {
			fg = "grey",
		},
		--- noice.nvim ---
		NoiceLspProgressTitle = {
			fg = { "white", -20 },
		},
		--- foldtext.lua ---
		FoldedSpace = {
			fg = "NONE",
			bg = "NONE",
		},
		FoldedIcon = {
			fg = "NONE",
		},
		FoldedText = {
			bg = "NONE",
			fg = "light_grey",
			italic = true,
		},
		--- lazy.nvim  ---
		LazyUpdates = {
			fg = "green",
			bg = "NONE",
		},
		--- highlight-undo.nvim ---
		HighlightUndo = {
			bg = { "black", "blue", 40 },
		},
		HighlightRedo = {
			bg = { "black", "red", 40 },
		},
		--- twilight.nvim ---
		Twilight = {
			bg = "black",
			fg = "grey_fg",
		},
		--- gitsigns.nvim ---
		GitSignsCurrentLineBlame = {
			fg = "light_grey",
			italic = true,
		},
		--- trouble.nvim ---
		TroubleStatusline1 = {
			fg = "light_grey",
			bg = "black",
		},
		TroubleSeparatorHighlight = {
			fg = "yellow",
			bg = "one_bg",
		},
		--- symbol-usage.nvim ---
		SymbolUsageRounding = {
			fg = "NONE",
		},
		SymbolUsageContent = {
			bg = "NONE",
			fg = "light_grey",
			italic = true,
		},
		SymbolUsageRef = {
			fg = "nord_blue",
			bg = "NONE",
			italic = true,
		},
		SymbolUsageDef = {
			fg = "dark_purple",
			bg = "NONE",
			italic = true,
		},
		SymbolUsageImpl = {
			fg = "yellow",
			bg = "NONE",
			italic = true,
		},
	},

	integrations = {
		"diffview",
		"notify",
		"todo",
		"dap",
		"trouble",
		"rainbowdelimiters",
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
