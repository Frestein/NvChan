local M = {}

M.on_attach = function(bufnr)
	local keymaps = {
		{
			"<leader>uD",
			"<cmd>Gitsigns toggle_deleted<cr>",
			desc = "Toggle Deleted Lines",
		},
		{
			"<leader>ghp",
			"<cmd>Gitsigns preview_hunk<cr>",
			desc = "Preview hunk",
		},
		{
			"<leader>ghr",
			"<cmd>Gitsigns reset_hunk<cr>",
			desc = "Reset Hunk",
		},
		{
			"<leader>gc",
			"<cmd>Telescope git_commits<cr>",
			desc = "Git Commits",
		},
		{
			"<leader>gs",
			"<cmd>Telescope git_status<cr>",
			desc = "Git Status",
		},
	}

	for _, keymap in ipairs(keymaps) do
		vim.keymap.set("n", keymap[1], keymap[2], { desc = keymap.desc, buffer = bufnr })
	end
end

return M
