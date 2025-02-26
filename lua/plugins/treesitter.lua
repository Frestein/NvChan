return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		event = { "LazyFile", "VeryLazy" },
		lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		opts_extend = { "ensure_installed" },
		keys = {
			{ "<c-space>", desc = "treesitter increment selection" },
			{ mode = "x", "<bs>", desc = "treesitter decrement selection" },
		},
		opts = function()
			pcall(function()
				dofile(vim.g.base46_cache .. "syntax")
				dofile(vim.g.base46_cache .. "treesitter")
			end)

			---@type string
			local xdg_config = vim.env.XDG_CONFIG_HOME or vim.env.HOME .. "/.config"

			---@param path string
			local function have(path)
				return vim.uv.fs_stat(vim.env.HOME .. "/" .. path) or vim.uv.fs_stat(xdg_config .. "/" .. path) ~= nil
			end

			vim.filetype.add {
				extension = { rasi = "rasi", rofi = "rasi", wofi = "rasi" },
				filename = {
					["vifmrc"] = "vim",
				},
				pattern = {
					["%.env%.[%w_.-]+"] = "sh",
					[".*/.*%.hl"] = "hyprlang",
					[".*/ghostty/config"] = "bash",
					[".*/hypr.+%.conf"] = "hyprlang",
					[".*/kitty/.+%.conf"] = "bash",
					[".*/mako/config"] = "dosini",
					[".*/waybar/config"] = "jsonc",
					[".*/zathura/themes/.+"] = "zathurarc",
					[".*/kanata/.+"] = "lisp",
				},
			}

			---@type TSConfig
			---@diagnostic disable-next-line: missing-fields
			local opts = {
				highlight = { enable = true, use_languagetree = true },
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
				textobjects = {
					select = {
						enable = true,
						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							-- You can optionally set descriptions to the mappings (used in the desc parameter of
							-- nvim_buf_set_keymap) which plugins like which-key display
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
							-- You can also use captures from other query groups like `locals.scm`
							["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
						},
						-- You can choose the select mode (default is charwise 'v')
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * method: eg 'v' or 'o'
						-- and should return the mode ('v', 'V', or '<c-v>') or a table
						-- mapping query_strings to modes.
						selection_modes = {
							["@parameter.outer"] = "v", -- charwise
							["@function.outer"] = "V", -- linewise
							["@class.outer"] = "<c-v>", -- blockwise
						},
						-- If you set this to `true` (default is `false`) then any textobject is
						-- extended to include preceding or succeeding whitespace. Succeeding
						-- whitespace has priority in order to act similarly to eg the built-in
						-- `ap`.
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * selection_mode: eg 'v'
						-- and should return true or false
						include_surrounding_whitespace = true,
					},
					move = {
						enable = true,
						goto_next_start = {
							["]f"] = "@function.outer",
							["]c"] = "@class.outer",
							["]a"] = "@parameter.inner",
						},
						goto_next_end = {
							["]F"] = "@function.outer",
							["]C"] = "@class.outer",
							["]A"] = "@parameter.inner",
						},
						goto_previous_start = {
							["[f"] = "@function.outer",
							["[c"] = "@class.outer",
							["[a"] = "@parameter.inner",
						},
						goto_previous_end = {
							["[F"] = "@function.outer",
							["[C"] = "@class.outer",
							["[A"] = "@parameter.inner",
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>a"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>A"] = "@parameter.inner",
						},
					},
					lsp_interop = {
						enable = true,
						border = "none",
						floating_preview_opts = {},
						peek_definition_code = {
							["<leader>df"] = "@function.outer",
							["<leader>dF"] = "@class.outer",
						},
					},
				},
				ensure_installed = {
					"bash",
					"c",
					"css",
					"desktop",
					"diff",
					"dockerfile",
					"git_config",
					"git_rebase",
					"gitattributes",
					"gitcommit",
					"gitignore",
					"go",
					"gomod",
					"gosum",
					"gowork",
					"html",
					"ini",
					"json",
					"json5",
					"jsonc",
					"lua",
					"luadoc",
					"luap",
					"markdown",
					"markdown_inline",
					"norg",
					"python",
					"regex",
					"toml",
					"vim",
					"vimdoc",
					"xml",
					"yaml",
				},
			}

			local function add(lang)
				if type(opts.ensure_installed) == "table" then
					table.insert(opts.ensure_installed, lang)
				end
			end

			if have "hypr" then
				add "hyprlang"
			end

			if have "fish" then
				add "fish"
			end

			if have "rofi" or have "wofi" then
				add "rasi"
			end

			if have "zathura" then
				add "zathurarc"
			end

			if have ".Xresources" then
				add "xresources"
			end

			return opts
		end,
		---@param opts TSConfig
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
		init = function(plugin)
			-- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
			-- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
			-- no longer trigger the **nvim-treesitter** module to be loaded in time.
			-- Luckily, the only things that those plugins need are the custom queries, which we make available
			-- during startup.
			require("lazy.core.loader").add_to_rtp(plugin)
			require "nvim-treesitter.query_predicates"
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "VeryLazy",
		opts = function()
			local tsc = require "treesitter-context"
			Snacks.toggle({
				name = "Treesitter Context",
				get = tsc.enabled,
				set = function(state)
					if state then
						tsc.enable()
					else
						tsc.disable()
					end
				end,
			}):map "<leader>ut"

			return {
				multiwindow = true,
				mode = "cursor",
				max_lines = 3,
			}
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "VeryLazy",
		config = function()
			local utils = require "utils"
			-- If treesitter is already loaded, we need to run config again for textobjects
			if utils.is_loaded "nvim-treesitter" then
				local opts = utils.opts "nvim-treesitter"
				require("nvim-treesitter.configs").setup { textobjects = opts.textobjects }
			end

			-- When in diff mode, we want to use the default
			-- vim text objects c & C instead of the treesitter ones.
			local configs = require "nvim-treesitter.configs"
			local move = require "nvim-treesitter.textobjects.move" ---@type table<string,fun(...)>
			for name, fn in pairs(move) do
				if name:find "goto" == 1 then
					move[name] = function(q, ...)
						if vim.wo.diff then
							local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
							for key, query in pairs(config or {}) do
								if q == query and key:find "[%]%[][cC]" then
									vim.cmd("normal! " .. key)
									return
								end
							end
						end
						return fn(q, ...)
					end
				end
			end
		end,
	},
}
