return {
	{
		"Wansmer/langmapper.nvim",
		lazy = false,
		priority = 1,
		opts = {
			default_layout = [[ABCDEFGHIJKLMNOPQRSTUVWXYZ<>:"{}~abcdefghijklmnopqrstuvwxyz,.;'[]`]],
			layouts = {
				ru = {
					id = "ru",
					layout = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯБЮЖЭХЪËфисвуапршолдьтщзйкыегмцчнябюжэхъё",
				},
			},
		},
		config = function(_, opts)
			require("langmapper").setup(opts)
			require("langmapper").hack_get_keymap()
		end,
	},
}
