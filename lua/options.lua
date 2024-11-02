local opt = vim.opt
local o = vim.o
local g = vim.g

o.laststatus = 3
o.scrolloff = 5
o.showmode = false

o.clipboard = "unnamedplus"
o.cursorline = true
local cursor_options = {
  "n-v-c:block",
  "i-ci-ve:ver25",
  "r-cr:hor20",
  "o:hor50",
  "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
  "sm:block-blinkwait175-blinkoff150-blinkon175",
}
o.guicursor = table.concat(cursor_options, ",")
o.cursorlineopt = "both"

-- Indenting
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

-- Numbers
o.number = true
o.numberwidth = 2
o.relativenumber = true
o.ruler = false

-- disable nvim intro
opt.shortmess:append "sI"

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.undofile = true

-- Folds. Start with folds open
o.foldlevelstart = 99
o.foldlevel = 99

-- Swap
o.updatetime = 250 -- interval for writing swap file to disk, also used by gitsigns
o.swapfile = false

-- Spell checking
o.spelllang = "en_us"
o.spellfile = os.getenv "HOME" .. "/.config/nvim/spell/en.utf-8.add"

-- Transparent background
o.pumblend = 15

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

-- disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH
