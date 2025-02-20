local function is_man_mode()
	for _, arg in pairs(vim.v.argv) do
		if arg == "+Man!" then
			return true
		end
	end
	return false
end

local function is_not_man_mode()
	return not is_man_mode()
end

if is_man_mode() then
	vim.opt.laststatus = 0
	vim.opt.statusline = " "
end

return {
	{ "Frestein/ui", cond = is_not_man_mode },
	{ "alker0/chezmoi.vim", cond = is_not_man_mode },
	{ "andrewferrier/debugprint.nvim", cond = is_not_man_mode },
	{ "echasnovski/mini.ai", cond = is_not_man_mode },
	{ "echasnovski/mini.files", cond = is_not_man_mode },
	{ "echasnovski/mini.files", cond = is_not_man_mode },
	{ "echasnovski/mini.operators", cond = is_not_man_mode },
	{ "echasnovski/mini.pairs", cond = is_not_man_mode },
	{ "echasnovski/mini.surround", cond = is_not_man_mode },
	{ "folke/todo-comments.nvim", cond = is_not_man_mode },
	{ "folke/trouble.nvim", cond = is_not_man_mode },
	{ "folke/ts-comments.nvim", cond = is_not_man_mode },
	{ "folke/which-key.nvim", cond = is_not_man_mode },
	{ "nvim-treesitter/nvim-treesitter-context", cond = is_not_man_mode },
	{ "nvim-treesitter/nvim-treesitter-textobjects", cond = is_not_man_mode },
	{ "nvim-zh/colorful-winsep.nvim", cond = is_not_man_mode },
}
