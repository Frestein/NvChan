local colors = require("utils").get_base46_colors()

local opts = {
	keymaps = {
		accept_suggestion = "<C-f>",
		accept_word = "<C-w>",
		clear_suggestion = "<C-c>",
	},
	color = {
		suggestion_color = "#ffffff",
	},
	log_level = "off",
}

if colors then
	opts.color.suggestion_color = colors.light_grey
end

return opts
