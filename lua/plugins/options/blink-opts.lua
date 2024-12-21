dofile(vim.g.base46_cache .. "cmp")

---@module 'blink.cmp'
---@type blink.cmp.Config | { sources: { compat: string[] } }
local opts = {
	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono",
	},
	completion = {
		menu = {
			border = "single",
			scrollbar = false,
			winblend = vim.o.pumblend,
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},
	},
	snippets = {
		expand = function(snippet)
			require("luasnip").lsp_expand(snippet)
		end,
		active = function(filter)
			if filter and filter.direction then
				return require("luasnip").jumpable(filter.direction)
			end
			return require("luasnip").in_snippet()
		end,
		jump = function(direction)
			require("luasnip").jump(direction)
		end,
	},
	sources = {
		default = {
			"lsp",
			"path",
			"snippets",
			"buffer",
			"lazydev",
			"luasnip",
		},
		providers = {
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				score_offset = 100,
			},
			luasnip = {
				name = "luasnip",
				module = "blink.compat.source",
				score_offset = -3,
				opts = {
					use_show_condition = false,
					show_autosnippets = true,
				},
			},
		},
	},
}

return opts
