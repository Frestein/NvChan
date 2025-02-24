return {
	{
		"folke/snacks.nvim",
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			quickfile = { enabled = true },
			gitbrowse = {
				url_patterns = {
					["github.com"] = {
						branch = "/tree/{branch}",
						file = "/blob/{branch}/{file}#L{line}",
					},
					["gitlab.com"] = {
						branch = "/-/tree/{branch}",
						file = "/-/blob/{branch}/{file}#L{line}",
					},
					["codeberg.org"] = {
						branch = "/src/branch/{branch}",
						file = "/src/branch/{branch}/{file}#L{line}",
					},
				},
			},
		},
		keys = {
			--- Code ---
			{
				"[[",
				function()
					Snacks.words.jump(-vim.v.count1)
				end,
				desc = "Prev Reference",
			},
			{
				"]]",
				function()
					Snacks.words.jump(vim.v.count1)
				end,
				desc = "Next Reference",
			},

			--- Bufferline ---
			{
				"<leader>bd",
				function()
					Snacks.bufdelete()
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>bo",
				function()
					Snacks.bufdelete.other()
				end,
				desc = "Delete Other Buffers",
			},

			--- Lazygit ---
			{
				"<leader>gg",
				function()
					if vim.fn.executable "lazygit" == 1 then
						Snacks.lazygit()
					end
				end,
				desc = "Lazygit (Root Dir)",
			},
			{
				"<leader>gb",
				function()
					if vim.fn.executable "lazygit" == 1 then
						Snacks.git.blame_line()
					end
				end,
				desc = "Git Blame Line",
			},
			{
				"<leader>gB",
				function()
					if vim.fn.executable "lazygit" == 1 then
						Snacks.gitbrowse()
					end
				end,
				desc = "Git Browse",
			},
			{
				"<leader>gf",
				function()
					if vim.fn.executable "lazygit" == 1 then
						Snacks.lazygit.log_file()
					end
				end,
				desc = "Lazygit Current File History",
			},
			{
				"<leader>gl",
				function()
					if vim.fn.executable "lazygit" == 1 then
						Snacks.lazygit.log()
					end
				end,
				desc = "Lazygit Log",
			},

			{
				"<leader>un",
				function()
					Snacks.notifier.hide()
				end,
				desc = "Dismiss All Notifications",
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- Setup some globals for debugging (lazy-loaded)
					_G.dd = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end
					vim.print = _G.dd -- Override print to use snacks for `:=` command

					-- Toggle options
					Snacks.toggle.option("spell", { name = "Spelling" }):map "<leader>us"
					Snacks.toggle.option("wrap", { name = "Wrap" }):map "<leader>uw"
					Snacks.toggle.line_number():map "<leader>ul"
					Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map "<leader>uL"
					Snacks.toggle.diagnostics():map "<leader>ud"
					Snacks.toggle
						.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
						:map "<leader>uc"
					if vim.lsp.inlay_hint then
						Snacks.toggle.inlay_hints():map "<leader>uh"
					end
				end,
			})
		end,
	},

	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		keys = function()
			local function close_plugin(plugin, command)
				local ok, require = pcall(require, plugin)
				if ok and require[command] then
					require[command]()
				end
			end

			---@param save_session boolean Indicates whether to save the session before quitting.
			local function quit_all(save_session)
				close_plugin("trouble", "close")
				close_plugin("dapui", "close")

				if not save_session then
					require("persistence").stop()
				end

				vim.schedule(function()
					vim.cmd "quitall"
				end)
			end

			return {
				{
					"<leader>qs",
					function()
						require("persistence").select()
					end,
					desc = "Select Session",
				},
				{
					"<leader>ql",
					function()
						require("persistence").load { last = true }
					end,
					desc = "Load Session (last)",
				},
				{
					"<leader>qq",
					function()
						quit_all(true)
					end,
					desc = "Close Neovim (save session)",
				},
				{
					"<leader>qQ",
					function()
						quit_all(false)
					end,
					desc = "Close Neovim (discard session)",
				},
			}
		end,
		opts = {},
	},

	{ "nvim-lua/plenary.nvim" },
}
