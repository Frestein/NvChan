local buffer_utils = require "utils.buffer"

local mappings = {
	-- Motion
	{ { "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Move down", expr = true, silent = true } },
	{ { "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Move down", expr = true, silent = true } },
	{ { "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Move up", expr = true, silent = true } },
	{ { "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Move up", expr = true, silent = true } },
	{ "i", "<C-^>", "<ESC>^i", { desc = "Move to beginning of line" } },
	{ "i", "<C-4>", "<End>", { desc = "Move to end of line" } },
	{ "i", "<C-h>", "<Left>", { desc = "Move left" } },
	{ "i", "<C-l>", "<Right>", { desc = "Move right" } },
	{ "i", "<C-j>", "<Down>", { desc = "Move down" } },
	{ "i", "<C-k>", "<Up>", { desc = "Move up" } },

	--- File ---
	{ { "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" } },
	{ "n", "<C-c>", "<cmd>%y+<CR>", { desc = "Copy Whole File" } },
	{
		"n",
		"<leader>cF",
		function()
			vim.fn.setreg("+", vim.fn.expand "%:t")
		end,
		{ desc = "Copy Filename" },
	},
	{
		"n",
		"<leader>cP",
		function()
			vim.fn.setreg("+", vim.fn.expand "%:p")
		end,
		{ desc = "Copy Path" },
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

	--- Comments ---
	{ "n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" } },
	{ "n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" } },
	{ "n", "<leader>/", "gcc", { desc = "Toggle comment", remap = true } },
	{ "v", "<leader>/", "gc", { desc = "Toggle comment", remap = true } },

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
		{ desc = "Move to Left (buffer)" },
	},
	{
		"n",
		"<A-Right>",
		function()
			buffer_utils.move_buf(1)
		end,
		{ desc = "Move to Right (buffer)" },
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
	{ "t", "<C-x>", "<C-\\><C-N>", { desc = "Escape Terminal Mode" } },

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

	--- lazy.nvim ---
	{
		"n",
		"<leader>ll",
		function()
			require("lazy").home()
		end,
		{ desc = "Lazy Home" },
	},
	{
		"n",
		"<leader>ls",
		function()
			require("lazy").sync()
		end,
		{ desc = "Lazy Sync" },
	},
	{
		"n",
		"<leader>lp",
		function()
			require("lazy").profile()
		end,
		{ desc = "Lazy Profile" },
	},

	--- Add undo break-points ---
	{ "i", ",", ",<c-g>u" },
	{ "i", ".", ".<c-g>u" },
	{ "i", ";", ";<c-g>u" },

	--- Other ---
	{ "n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" } },
	{ "n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear Highlights" } },
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
	vim.keymap.set(mode, lhs, rhs, opts)
end
