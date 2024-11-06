return {
	backend = "vim",
	telescope_opts = {
		sorting_strategy = "descending",
		layout_strategy = "vertical",
		layout_config = {
			vertical = {
				prompt_position = "bottom",
				preview_width = 0.55,
			},
			width = 0.45,
			height = 0.8,
			preview_cutoff = 1,
			preview_height = function(_, _, max_lines)
				local h = math.floor(max_lines * 0.5)
				return math.max(h, 10)
			end,
		},
	},
}
