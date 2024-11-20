local autocmd = vim.api.nvim_create_autocmd
local wo = vim.wo

local function augroup(name)
	return vim.api.nvim_create_augroup("nvchan_" .. name, { clear = true })
end

-- user event that loads after UIEnter + only if file buf is there
autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
	group = augroup "NvFilePost",
	callback = function(args)
		local file = vim.api.nvim_buf_get_name(args.buf)
		local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

		if not vim.g.ui_entered and args.event == "UIEnter" then
			vim.g.ui_entered = true
		end

		if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
			vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
			vim.api.nvim_del_augroup_by_name "nvchan_NvFilePost"

			vim.schedule(function()
				vim.api.nvim_exec_autocmds("FileType", {})

				if vim.g.editorconfig then
					require("editorconfig").config(args.buf)
				end
			end)
		end
	end,
})

autocmd("FileType", {
	pattern = { "norg", "markdown" },
	group = augroup "docs_folds",
	callback = function()
		wo.foldlevel = 99
		wo.conceallevel = 2
	end,
})

autocmd("FileType", {
	pattern = { "lazy" },
	group = augroup "fix_buf",
	callback = function()
		wo.winfixbuf = true
	end,
})

-- Check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup "checktime",
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd "checktime"
		end
	end,
})

-- Restore cursor position
autocmd("BufReadPost", {
	pattern = "*",
	group = augroup "restore_cursor",
	callback = function()
		local line = vim.fn.line "'\""
		if
			line > 1
			and line <= vim.fn.line "$"
			and vim.bo.filetype ~= "commit"
			and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
		then
			vim.cmd 'normal! g`"'
		end
	end,
})

-- Resize splits if window got resized
autocmd({ "VimResized" }, {
	group = augroup "resize_splits",
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd "tabdo wincmd ="
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- Close some filetypes with <q>
autocmd("FileType", {
	group = augroup "close_with_q",
	pattern = {
		"PlenaryTestPopup",
		"checkhealth",
		"dbout",
		"gitsigns-blame",
		"grug-far",
		"help",
		"lspinfo",
		"neotest-output",
		"neotest-output-panel",
		"neotest-summary",
		"notify",
		"qf",
		"snacks_win",
		"spectre_panel",
		"startuptime",
		"tsplayground",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set("n", "q", function()
				vim.cmd "close"
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, {
				buffer = event.buf,
				silent = true,
				desc = "Quit buffer",
			})
		end)
	end,
})

-- Wrap and check for spell in text filetypes
autocmd("FileType", {
	group = augroup "wrap_spell",
	pattern = { "text", "plaintex", "typst", "gitcommit", "markdown", "norg" },
	callback = function()
		wo.wrap = true
		wo.spell = true
	end,
})

-- Fix conceallevel for json files
autocmd({ "FileType" }, {
	group = augroup "json_conceal",
	pattern = { "json", "jsonc", "json5" },
	callback = function()
		wo.conceallevel = 0
	end,
})
