return {
	{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
	{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Find Files (recent)" },
	{ "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Find Pattern (live grep)" },
	{ "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find Pattern (buffer)" },
	{
		"<leader>fb",
		"<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=true<cr>",
		desc = "Find Buffers",
	},
	{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
	{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Find Diagnostics" },
	{ "<leader>th", "<cmd>Telescope themes<cr>", desc = "Find Themes" },
	{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Find Keymaps" },
	{ "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Find Marks" },
}
