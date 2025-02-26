local buffer_utils = require "utils.buffer"

local mappings = {
	-- Motion
	{ { "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Move Down", expr = true, silent = true } },
	{ { "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Move Down", expr = true, silent = true } },
	{ { "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Move Up", expr = true, silent = true } },
	{ { "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Move Up", expr = true, silent = true } },
	{ "i", "<C-h>", "<Left>", { desc = "Move Left" } },
	{ "i", "<C-l>", "<Right>", { desc = "Move Right" } },
	{ "i", "<C-j>", "<Down>", { desc = "Move Down" } },
	{ "i", "<C-k>", "<Up>", { desc = "Move Up" } },
	{ "i", "<C-^>", "<ESC>^i", { desc = "Move Beginning of Line" } },
	{ "i", "<C-4>", "<End>", { desc = "Move End of Line" } },

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

	--- Bufferline ---
	{ "n", "J", buffer_utils.prev, { desc = "Prev Buffer" } },
	{ "n", "K", buffer_utils.next, { desc = "Next Buffer" } },
	{ "n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" } },
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
	{ "t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" } },
	{ "t", "<C-x>", "<C-\\><C-N>", { desc = "Escape Terminal Mode" } },

	--- lazy.nvim ---
	{
		"n",
		"<leader>ll",
		function()
			require("lazy").home()
		end,
		{ desc = "Home" },
	},
	{
		"n",
		"<leader>ls",
		function()
			require("lazy").sync()
		end,
		{ desc = "Sync" },
	},
	{
		"n",
		"<leader>lp",
		function()
			require("lazy").profile()
		end,
		{ desc = "Profile" },
	},

	--- Add undo break-points ---
	{ "i", ",", ",<c-g>u" },
	{ "i", ".", ".<c-g>u" },
	{ "i", ";", ";<c-g>u" },

	--- Other ---
	{
		"n",
		"gj",
		function()
			local count = vim.v.count > 0 and vim.v.count or 1
			vim.cmd("join " .. count)
		end,
		{ desc = "Join" },
	},
	{ "n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" } },
	{ "n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear Highlights" } },
	{
		"n",
		"<leader>wd",
		function()
			require("modules.web").search()
		end,
		{ desc = "Search Diagnostic (web)" },
	},
}

for _, mapping in ipairs(mappings) do
	local mode, l, r, opts = table.unpack(mapping)
	vim.keymap.set(mode, l, r, opts)
end
