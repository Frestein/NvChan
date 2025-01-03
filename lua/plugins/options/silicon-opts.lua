return {
	font = "Maple Mono NF=34",
	to_clipboard = true,
	theme = "gruvbox-dark",
	pad_horiz = 40,
	pad_vert = 40,
	background = "#EDDCB1",
	language = function()
		return vim.bo.filetype
	end,
	window_title = function()
		return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
	end,
	output = function()
		return "~/Pictures/Screenshots/" .. os.date "!%Y-%m-%dT%H-%M-%SZ" .. "_code.png"
	end,
}
