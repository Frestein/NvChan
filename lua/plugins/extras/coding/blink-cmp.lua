return {
	{
		"saghen/blink.cmp",
		event = "InsertEnter",
		version = "*",
		build = "cargo build --release",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			{
				"saghen/blink.compat",
				version = "*",
				opts = { impersonate_nvim_cmp = true },
			},
		},
		opts = function()
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
		end,
	},

	{
		"xzbdmw/colorful-menu.nvim",
		opts = {
			ls = {
				lua_ls = {
					-- Maybe you want to dim arguments a bit.
					arguments_hl = "@comment",
				},
				gopls = {
					-- By default, we render variable/function's type in the right most side,
					-- to make them not to crowd together with the original label.

					-- when true:
					-- foo             *Foo
					-- ast         "go/ast"

					-- when false:
					-- foo *Foo
					-- ast "go/ast"
					align_type_to_right = true,
					-- When true, label for field and variable will format like "foo: Foo"
					-- instead of go's original syntax "foo Foo". If align_type_to_right is
					-- true, this option has no effect.
					add_colon_before_type = false,
				},
				-- for lsp_config or typescript-tools
				ts_ls = {
					extra_info_hl = "@comment",
				},
				vtsls = {
					extra_info_hl = "@comment",
				},
				["rust-analyzer"] = {
					-- Such as (as Iterator), (use std::io).
					extra_info_hl = "@comment",
					-- Similar to the same setting of gopls.
					align_type_to_right = true,
				},
				clangd = {
					-- Such as "From <stdio.h>".
					extra_info_hl = "@comment",
					-- Similar to the same setting of gopls.
					align_type_to_right = true,
					-- the hl group of leading dot of "•std::filesystem::permissions(..)"
					import_dot_hl = "@comment",
				},
				zls = {
					-- Similar to the same setting of gopls.
					align_type_to_right = true,
				},
				roslyn = {
					extra_info_hl = "@comment",
				},
				-- The same applies to pyright/pylance
				basedpyright = {
					-- It is usually import path such as "os"
					extra_info_hl = "@comment",
				},

				-- If true, try to highlight "not supported" languages.
				fallback = true,
			},
			-- If the built-in logic fails to find a suitable highlight group,
			-- this highlight is applied to the label.
			fallback_highlight = "@variable",
			-- If provided, the plugin truncates the final displayed text to
			-- this width (measured in display cells). Any highlights that extend
			-- beyond the truncation point are ignored. When set to a float
			-- between 0 and 1, it'll be treated as percentage of the width of
			-- the window: math.floor(max_width * vim.api.nvim_win_get_width(0))
			-- Default 60.
			max_width = 60,
		},
	},
}
