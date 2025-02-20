return {
	"L3MON4D3/LuaSnip",
	dependencies = "rafamadriz/friendly-snippets",
	config = function()
		local from_lua = require "luasnip.loaders.from_lua"
		local from_snipmate = require "luasnip.loaders.from_snipmate"
		local from_vscode = require "luasnip.loaders.from_vscode"
		local luasnip = require "luasnip"
		local opts = {
			history = true,
			updateevents = "TextChanged,TextChangedI",
		}

		luasnip.config.set_config(opts)

		from_vscode.lazy_load { exclude = vim.g.vscode_snippets_exclude or {} }
		from_vscode.lazy_load { paths = vim.g.vscode_snippets_path or "" }

		from_snipmate.load()
		from_snipmate.lazy_load { paths = vim.g.snipmate_snippets_path or "" }

		from_lua.load()
		from_lua.lazy_load { paths = vim.g.lua_snippets_path or "" }

		vim.api.nvim_create_autocmd("InsertLeave", {
			callback = function()
				if
					luasnip.session.current_nodes[vim.api.nvim_get_current_buf()] and not luasnip.session.jump_active
				then
					luasnip.unlink_current()
				end
			end,
		})
	end,
}
