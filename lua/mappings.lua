require "plugins.mappings.lazy-keys"

local map = require("langmapper").map
local tabufline = require "nvchad.tabufline"

local mappings = {
	-- Motion
	{ { "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "motion down", expr = true, silent = true } },
	{ { "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "motion down", expr = true, silent = true } },
	{ { "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "motion up", expr = true, silent = true } },
	{ { "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "motion up", expr = true, silent = true } },
	{ { "n", "o", "x" }, "<S-h>", "^", { desc = "motion jump to beginning of line" } },
	{ { "n", "o", "x" }, "<S-l>", "$", { desc = "motion jump to end of line" } },
	{ "i", "<C-b>", "<ESC>^i", { desc = "motion beginning of line" } },
	{ "i", "<C-e>", "<End>", { desc = "motion end of line" } },
	{ "i", "<C-h>", "<Left>", { desc = "motion left" } },
	{ "i", "<C-l>", "<Right>", { desc = "motion right" } },
	{ "i", "<C-j>", "<Down>", { desc = "motion down" } },
	{ "i", "<C-k>", "<Up>", { desc = "motion up" } },

	--- File ---
	{ { "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" } },
	{ "n", "<C-c>", "<cmd>%y+<CR>", { desc = "file copy whole file" } },
	{
		"n",
		"<leader>cf",
		function()
			vim.fn.setreg("+", vim.fn.expand "%:t")
		end,
		{ desc = "file copy name" },
	},
	{
		"n",
		"<leader>cp",
		function()
			vim.fn.setreg("+", vim.fn.expand "%:p")
		end,
		{ desc = "file copy path" },
	},

	--- Windows ---
	{ "n", "<leader>w", "<c-w>", { desc = "Windows", remap = true } },
	{ "n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true } },
	{ "n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true } },
	{ "n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true } },

	--- Code ---
	{ "n", "<leader>/", "gcc", { desc = "code toggle comment", remap = true } },
	{ "v", "<leader>/", "gc", { desc = "code toggle comment", remap = true } },
	{
		"n",
		"[[",
		function()
			Snacks.words.jump(-vim.v.count1)
		end,
		{ desc = "Prev Reference" },
	},
	{
		"n",
		"]]",
		function()
			Snacks.words.jump(vim.v.count1)
		end,
		{ desc = "Next Reference" },
	},

	--- Tabufline ---
	{
		"n",
		"<leader>bd",
		function()
			Snacks.bufdelete()
		end,
		{ desc = "Delete Buffer" },
	},
	{ "n", "<S-tab>", tabufline.prev, { desc = "buffer goto prev buffer" } },
	{ "n", "<tab>", tabufline.next, { desc = "buffer goto next buffer" } },
	{
		"n",
		"<A-Left>",
		function()
			tabufline.move_buf(-1)
		end,
		{ desc = "buffer move to left" },
	},
	{
		"n",
		"<A-Right>",
		function()
			tabufline.move_buf(1)
		end,
		{ desc = "buffer move to right" },
	},
	{ "n", "<leader>$", "<cmd>tablast<CR>", { desc = "tab last tab" } },
	{ "n", "<leader>^", "<cmd>tabfirst<CR>", { desc = "tab first tab" } },

	--- Terminal ---
	{
		"n",
		"<C-/>",
		function()
			Snacks.terminal()
		end,
		{ desc = "Terminal (cwd)" },
	},
	{ "t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" } },
	{ "t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" } },

	--- Lazygit ---
	{
		"n",
		"<leader>gg",
		function()
			if vim.fn.executable "lazygit" == 1 then
				Snacks.lazygit()
			end
		end,
		{ desc = "Lazygit (Root Dir)" },
	},
	{
		"n",
		"<leader>gb",
		function()
			if vim.fn.executable "lazygit" == 1 then
				Snacks.git.blame_line()
			end
		end,
		{ desc = "Git Blame Line" },
	},
	{
		"n",
		"<leader>gB",
		function()
			if vim.fn.executable "lazygit" == 1 then
				Snacks.gitbrowse()
			end
		end,
		{ desc = "Git Browse" },
	},
	{
		"n",
		"<leader>gf",
		function()
			if vim.fn.executable "lazygit" == 1 then
				Snacks.lazygit.log_file()
			end
		end,
		{ desc = "Lazygit Current File History" },
	},
	{
		"n",
		"<leader>gl",
		function()
			if vim.fn.executable "lazygit" == 1 then
				Snacks.lazygit.log()
			end
		end,
		{ desc = "Lazygit Log" },
	},

	--- Which-Key ---
	{ "n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" } },
	{
		"n",
		"<leader>wk",
		function()
			vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
		end,
		{ desc = "whichkey query lookup" },
	},

	--- Blankline ---
	{
		"n",
		"<leader>cc",
		function()
			local config = { scope = {} }
			config.scope.exclude = { language = {}, node_type = {} }
			config.scope.include = { node_type = {} }
			local node = require("ibl.scope").get(vim.api.nvim_get_current_buf(), config)

			if node then
				local start_row, _, end_row, _ = node:range()
				if start_row ~= end_row then
					vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start_row + 1, 0 })
					vim.api.nvim_feedkeys("_", "n", true)
				end
			end
		end,
		{ desc = "blankline jump to current context" },
	},

	--- Other ---
	{ "n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" } },
	{
		"n",
		"<leader>un",
		function()
			Snacks.notifier.hide()
		end,
		{ desc = "Dismiss All Notifications" },
	},
}

for _, mapping in ipairs(mappings) do
	local mode, lhs, rhs, opts = table.unpack(mapping)
	map(mode, lhs, rhs, opts)
end

-- Toggle options
Snacks.toggle.option("spell", { name = "Spelling" }):map "<leader>us"
Snacks.toggle.option("wrap", {name = "Wrap"}):map("<leader>uw")
Snacks.toggle.line_number():map("<leader>ul")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map "<leader>uL"
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.option("conceallevel", {off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2}):map("<leader>uc")
if vim.lsp.inlay_hint then
  Snacks.toggle.inlay_hints():map("<leader>uh")
end
