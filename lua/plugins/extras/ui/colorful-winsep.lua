local colors = require("utils").get_base46_colors()

local opts = {
	hi = {
		fg = "#1F3442",
	},
}

if colors then
	opts.hi.fg = colors.line
end

return {
	{
		"nvim-zh/colorful-winsep.nvim",
		event = "WinLeave",
		opts = opts,
	},
}
