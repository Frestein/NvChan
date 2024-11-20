-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.o.rtp = lazypath .. ',' .. vim.o.rtp

local lazyopts = require "plugins.options.lazy-opts"

local augroup = vim.api.nvim_create_augroup("LazyUserGroup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "lazy",
	desc = "Quit lazy with <Esc>",
	callback = function()
		vim.keymap.set("n", "<Esc>", function()
			vim.api.nvim_win_close(0, false)
		end, { buffer = true, nowait = true })
	end,
	group = augroup,
})

-- Setup lazy.nvim
require("lazy").setup({
	{ import = "plugins" },
}, lazyopts)
