return {
	load = {
		["core.defaults"] = {},
		["core.concealer"] = {},
		["core.completion"] = {
			config = {
				engine = "nvim-cmp",
			},
		},
		["core.dirman"] = {
			config = {
				workspaces = {
					notes = "~/Documents/notes",
				},
				default_workspace = "notes",
			},
		},
		["core.integrations.telescope"] = {
			config = {
				insert_file_link = {
					show_title_preview = true,
				},
			},
		},
	},
}
