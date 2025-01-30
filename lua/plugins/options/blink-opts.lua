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
			draw = {
				treesitter = { "lsp" },
				-- We don't need label_description now because label and label_description are already
				-- combined together in label by colorful-menu.nvim.
				columns = { { "kind_icon" }, { "label", gap = 1 } },
				components = {
					label = {
						text = function(ctx)
							return require("colorful-menu").blink_components_text(ctx)
						end,
						highlight = function(ctx)
							return require("colorful-menu").blink_components_highlight(ctx)
						end,
					},
				},
			},
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},
	},
	snippets = {
		preset = "luasnip",
	},
	sources = {
		default = {
			"lsp",
			"path",
			"snippets",
			"buffer",
			"lazydev",
		},
		providers = {
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				score_offset = 100,
			},
		},
	},
}

return opts
