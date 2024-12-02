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
		compat = {},
		completion = {
			enabled_providers = {
				"lsp",
				"path",
				"snippets",
				"buffer",
				"lazydev",
				"luasnip",
			},
		},
		providers = {
			-- dont show LuaLS require statements when lazydev has items
			lsp = {
				name = "LSP",
				module = "blink.cmp.sources.lsp",
				fallback_for = { "lazydev" },
			},
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
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

local enabled = opts.sources.completion.enabled_providers
for _, source in ipairs(opts.sources.compat or {}) do
	opts.sources.providers[source] = vim.tbl_deep_extend(
		"force",
		{ name = source, module = "blink.compat.source" },
		opts.sources.providers[source] or {}
	)
	if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
		table.insert(enabled, source)
	end
end

return opts
