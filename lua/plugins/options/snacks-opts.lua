---@type snacks.Config
return {
	bigfile = { enabled = true },
	dashboard = { enabled = false },
	indent = {
		animate = {
			enabled = false,
		},
		enabled = true,
	},
	input = { enabled = false },
	notifier = { enabled = true },
	quickfile = { enabled = true },
	scope = { enabled = false },
	scroll = {
		enabled = false,
		animate = {
			easing = "linear",
			fps = 75,
			spamming = 1,
			duration = { step = 15, total = 250 },
		},
	},
	words = { enabled = true },
	toggle = {
		map = require("langmapper").map,
		which_key = true,
		notify = true,
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
