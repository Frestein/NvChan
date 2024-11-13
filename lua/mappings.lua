require "plugins.mappings.lazy-keys"

local buffer_utils = require "utils.buffer"
local map = require("langmapper").map

local mappings = {
	-- Motion
	{ { "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "motion down", expr = true, silent = true } },
	{ { "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "motion down", expr = true, silent = true } },
	{ { "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "motion up", expr = true, silent = true } },
	{ { "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "motion up", expr = true, silent = true } },
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
		"<leader>cF",
		function()
			vim.fn.setreg("+", vim.fn.expand "%:t")
		end,
		{ desc = "file copy name" },
	},
	{
		"n",
		"<leader>cP",
		function()
			vim.fn.setreg("+", vim.fn.expand "%:p")
		end,
		{ desc = "file copy path" },
	},

	--- Windows ---
	-- Move to window using the <ctrl> hjkl keys
	{ "n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true } },
	{ "n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true } },
	{ "n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true } },
	{ "n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true } },
	-- Resize window using <ctrl> arrow keys
	{ "n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" } },
	{ "n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" } },
	{ "n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" } },
	{ "n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" } },

	--- Keywordprg ---
	{ "n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" } },

	--- Comments ---
	{ "n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" } },
	{ "n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" } },
	{ "n", "<leader>/", "gcc", { desc = "code toggle comment", remap = true } },
	{ "v", "<leader>/", "gc", { desc = "code toggle comment", remap = true } },

	--- Code ---
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

	--- Bufferline ---
	{ "n", "<S-h>", buffer_utils.prev, { desc = "Prev Buffer" } },
	{ "n", "<S-l>", buffer_utils.next, { desc = "Next Buffer" } },
	{ "n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" } },
	{
		"n",
		"<leader>bd",
		function()
			Snacks.bufdelete()
		end,
		{ desc = "Delete Buffer" },
	},
	{
		"n",
		"<leader>bo",
		function()
			Snacks.bufdelete.other()
		end,
		{ desc = "Delete Other Buffers" },
	},
	{ "n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" } },
	{
		"n",
		"<A-Left>",
		function()
			buffer_utils.move_buf(-1)
		end,
		{ desc = "buffer move to left" },
	},
	{
		"n",
		"<A-Right>",
		function()
			buffer_utils.move_buf(1)
		end,
		{ desc = "buffer move to right" },
	},

	--- Tabs ---
	{ "n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" } },
	{ "n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" } },
	{ "n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" } },
	{ "n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" } },
	{ "n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" } },
	{ "n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" } },
	{ "n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" } },

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

	--- Add undo break-points ---
	{ "i", ",", ",<c-g>u" },
	{ "i", ".", ".<c-g>u" },
	{ "i", ";", ";<c-g>u" },

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
