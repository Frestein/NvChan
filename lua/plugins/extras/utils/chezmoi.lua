return {
	{
		"xvzc/chezmoi.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"alker0/chezmoi.vim",
		},
		opts = {
			edit = {
				watch = true,
			},
			notification = {
				on_open = false,
				on_apply = false,
			},
		},
		keys = { { "<leader>fD", "<cmd>Telescope chezmoi find_files<cr>", desc = "Find Dotfiles" } },
	},

	{
		"alker0/chezmoi.vim",
		lazy = false,
		opts = {
			use_tmp_buffer = true,
			source_dir_path = os.getenv "HOME" .. "/.local/share/chezmoi",
		},
		init = function(_, opts)
			for key, value in pairs(opts) do
				vim.g["chezmoi#" .. key] = value
			end

			vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
				pattern = { os.getenv "HOME" .. "/.local/share/chezmoi/*" },
				callback = function(ev)
					local bufnr = ev.buf
					local edit_watch = function()
						require("chezmoi.commands.__edit").watch(bufnr)
					end
					vim.schedule(edit_watch)
				end,
			})
		end,
	},
}
