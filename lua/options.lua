local g = vim.g
local o = vim.o

local function escape(str)
	local escape_chars = [[;,."|\]]
	return vim.fn.escape(str, escape_chars)
end

local en = [[qwertyuiop[]asdfghjkl;zxcvbnm,.]]
local ru = [[йцукенгшщзхъфывапролджячсмитьбю]]
local en_shift = [[QWERTYUIOP{}ASDFGHJKL:ZXCVBNM<>]]
local ru_shift = [[ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЯЧСМИТЬБЮ]]
local langmap = vim.fn.join({
	escape(ru_shift) .. ";" .. escape(en_shift),
	escape(ru) .. ";" .. escape(en),
}, ",")

local options = {
	--- UI ---
	number = true,
	numberwidth = 2,
	relativenumber = true,
	ruler = false,
	showmode = false,
	pumblend = 15,
	laststatus = 3,
	scrolloff = 5,
	cursorline = true,
	signcolumn = "yes",
	guicursor = table.concat({
		"n-v-c:block",
		"i-ci-ve:ver25",
		"r-cr:hor20",
		"o:hor50",
		"a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
		"sm:block-blinkwait175-blinkoff150-blinkon175",
	}, ","),
	cursorlineopt = "both",
	fillchars = table.concat({
		"eob: ",
		"fold: ",
		"foldopen:",
		"foldclose:",
		"foldsep: ", -- or "│" to use bar for show fold area
	}, ","),

	--- Indents, Spaces, Tabulation ---
	smartindent = true,
	expandtab = false,
	shiftwidth = 4,
	tabstop = 4,
	softtabstop = 4,

	--- Search ---
	ignorecase = true,
	smartcase = true,
	hlsearch = true,
	infercase = true,

	--- Folds ---
	foldlevelstart = 99,
	foldlevel = 99,
	foldmethod = "expr",
	foldexpr = "nvim_treesitter#foldexpr()",
	foldtext = require "modules.foldtext",

	--- Swap ---
	swapfile = false,

	-- Interval for writing swap file to disk, also used by gitsigns
	updatetime = 250,

	--- Spell Checking ---
	spelllang = "en_us",
	spellfile = os.getenv "HOME" .. "/.config/nvim/spell/en.utf-8.add",

	--- Other ---
	timeoutlen = 400,
	clipboard = "unnamedplus",
	undofile = true,
	splitbelow = true,
	splitright = true,
	mouse = "a",
	langmap = langmap,

	-- Disable nvim intro
	shortmess = o.shortmess .. "sI",

	-- Go to previous/next line with h,l,left arrow and right arrow
	-- when cursor reaches end/beginning of line
	whichwrap = o.whichwrap .. "<,>,[,],h,l",
}

-- Disable default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

for option_name, value in pairs(options) do
	-- To avoid errors on toggle nvim version
	local ok, _ = pcall(vim.api.nvim_get_option_info2, option_name, {})
	if ok then
		o[option_name] = value
	else
		vim.notify("Option " .. option_name .. " is not supported", vim.log.levels.WARN)
	end
end
