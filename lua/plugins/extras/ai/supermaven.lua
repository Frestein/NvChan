return {
	"supermaven-inc/supermaven-nvim",
	event = "InsertEnter",
	opts = {
		keymaps = {
			accept_suggestion = "<C-\\>",
			accept_word = "<C-w>",
			clear_suggestion = "<C-c>",
		},
		color = {
			suggestion_color = vim.api.nvim_get_hl(0, { name = "Comment", link = true }).fg,
		},
		log_level = "off",
	},
}
