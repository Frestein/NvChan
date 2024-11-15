local opts = require "plugins.options.chezmoi-vim-opts"

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
