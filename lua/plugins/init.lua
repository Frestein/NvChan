require("utils.plugin").lazy_file()
local mini_utils = require "utils.mini"
local utils = require "utils"

return {
	{ "Bilal2453/luvit-meta" },

	{ "nvim-lua/plenary.nvim" },

	{
		"Luxed/aw-watcher-nvim",
		lazy = false,
	},

	{
		"andrewferrier/debugprint.nvim",
		event = "VeryLazy",
		opts = {},
	},

	{
		"artemave/workspace-diagnostics.nvim",
		opts = {},
	},

	{
		"b0o/schemastore.nvim",
		version = false,
	},

	{
		"echasnovski/mini.extra",
		enabled = false,
		version = false,
	},

	{
		"echasnovski/mini.operators",
		event = "VeryLazy",
		opts = {},
	},

	{
		"saecki/live-rename.nvim",
		opts = {},
	},

	{
		"folke/lazydev.nvim",
		ft = "lua",
		cmd = "LazyDev",
		opts = {
			library = {
				"lazy.nvim",
				"snacks.nvim",
				"mini.files",
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},

	{
		"folke/snacks.nvim",
		lazy = false,
		priority = 1000,
		opts = function()
			return require "plugins.options.snacks-opts"
		end,
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- Setup some globals for debugging (lazy-loaded)
					_G.dd = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end
					vim.print = _G.dd -- Override print to use snacks for `:=` command

					-- Toggle options
					Snacks.toggle.option("spell", { name = "Spelling" }):map "<leader>us"
					Snacks.toggle.option("wrap", { name = "Wrap" }):map "<leader>uw"
					Snacks.toggle.line_number():map "<leader>ul"
					Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map "<leader>uL"
					Snacks.toggle.diagnostics():map "<leader>ud"
					Snacks.toggle
						.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
						:map "<leader>uc"
					if vim.lsp.inlay_hint then
						Snacks.toggle.inlay_hints():map "<leader>uh"
					end
				end,
			})
		end,
	},

	{
		"Frestein/ui",
		lazy = false,
		priority = 900,
		config = function()
			require "nvchad"
		end,
	},

	{
		"Frestein/base46",
		build = function()
			require("base46").load_all_highlights()
		end,
	},

	{
		"Wansmer/langmapper.nvim",
		lazy = false,
		priority = 1,
		opts = require "plugins.options.langmapper-opts",
		config = function(_, opts)
			require("langmapper").setup(opts)
			require("langmapper").hack_get_keymap()
		end,
	},

	{
		"stevearc/conform.nvim",
		cmd = "ConformInfo",
		keys = require "plugins.mappings.conform-keys",
		config = function()
			require "plugins.configs.conform-conf"
		end,
	},

	{
		"neovim/nvim-lspconfig",
		event = "LazyFile",
		config = function()
			require "plugins.configs.lspconfig-conf"
		end,
	},

	{
		"mfussenegger/nvim-lint",
		event = "LazyFile",
		config = function()
			require "plugins.configs.lint-conf"
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		event = { "LazyFile", "VeryLazy" },
		lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		opts_extend = { "ensure_installed" },
		keys = require "plugins.mappings.treesitter-keys",
		opts = function()
			return require "plugins.options.treesitter-opts"
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
			return require "plugins.options.treesitter-context-opts"
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "VeryLazy",
		config = function()
			require "plugins.configs.treesitter-textobjects-conf"
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		enabled = false,
		url = "https://github.com/iguanacucumber/magazine.nvim",
		event = "VeryLazy",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp", url = "https://github.com/iguanacucumber/mag-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua", url = "https://github.com/iguanacucumber/mag-nvim-lua" },
			{ "hrsh7th/cmp-buffer", url = "https://github.com/iguanacucumber/mag-buffer" },
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
		},
		opts = function()
			return require "plugins.options.cmp-opts"
		end,
	},

	{
		"saghen/blink.cmp",
		lazy = false,
		build = "cargo build --release",
		opts_extend = {
			"sources.completion.enabled_providers",
			"sources.compat",
		},
		opts = function()
			return require "plugins.options.blink-opts"
		end,
	},

	{
		"L3MON4D3/LuaSnip",
		dependencies = "rafamadriz/friendly-snippets",
		config = function()
			require "plugins.configs.luasnip-conf"
		end,
	},

	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		opts = require "plugins.options.mini-pairs-opts",
		config = function(_, opts)
			mini_utils.pairs(opts)
		end,
	},

	{
		"echasnovski/mini.ai",
		event = "VeryLazy",
		config = function()
			return require "plugins.configs.mini-ai-conf"
		end,
	},

	{
		"echasnovski/mini.surround",
		event = "VeryLazy",
		keys = function(_, keys)
			-- Populate the keys based on the user's options
			local opts = utils.opts "mini.surround"
			local mappings = {
				{ opts.mappings.add, desc = "Add Surrounding", mode = { "n", "v" } },
				{ opts.mappings.delete, desc = "Delete Surrounding" },
				{ opts.mappings.find, desc = "Find Right Surrounding" },
				{ opts.mappings.find_left, desc = "Find Left Surrounding" },
				{ opts.mappings.highlight, desc = "Highlight Surrounding" },
				{ opts.mappings.replace, desc = "Replace Surrounding" },
				{ opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
			}
			mappings = vim.tbl_filter(function(m)
				return m[1] and #m[1] > 0
			end, mappings)
			return vim.list_extend(mappings, keys)
		end,
		opts = require "plugins.options.mini-surround-opts",
	},

	{
		"echasnovski/mini.files",
		event = "VeryLazy",
		version = false,
		keys = function()
			return require "plugins.mappings.mini-files-keys"
		end,
		opts = require("plugins.options.mini-files-opts").opts,
	},

	{
		"supermaven-inc/supermaven-nvim",
		event = "InsertEnter",
		opts = require "plugins.options.supermaven-opts",
		config = function(_, opts)
			require("supermaven-nvim").setup(opts)
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = "LazyFile",
		keys = require "plugins.mappings.indent-blankline-keys",
		config = function()
			require "plugins.configs.indent-blankline-conf"
		end,
	},

	{
		"echasnovski/mini.indentscope",
		event = "LazyFile",
		opts = function()
			return require "plugins.options.mini-indentscope-opts"
		end,
		config = function(_, opts)
			require("mini.indentscope").setup(opts)
		end,
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"Trouble",
					"alpha",
					"dashboard",
					"fzf",
					"help",
					"lazy",
					"mason",
					"neo-tree",
					"notify",
					"snacks_notif",
					"snacks_terminal",
					"snacks_win",
					"toggleterm",
					"trouble",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},

	{
		"ray-x/go.nvim",
		ft = { "go", "gomod" },
		config = function(_, opts)
			require("go").setup(opts)
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		event = "VeryLazy",
		dependencies = "nvim-lua/plenary.nvim",
		keys = require "plugins.mappings.telescope-keys",
		opts = function()
			return require "plugins.options.telescope-opts"
		end,
		config = function(_, opts)
			require("telescope").setup(opts)
			dofile(vim.g.base46_cache .. "telescope")
		end,
	},

	{
		"danielfalk/smart-open.nvim",
		dependencies = {
			"kkharji/sqlite.lua",
			"nvim-telescope/telescope.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
			},
		},
		branch = "0.2.x",
		keys = { { "<leader><leader>", "<cmd>Telescope smart_open<cr>", desc = "Find Files (smart)" } },
	},

	{
		"Marskey/telescope-sg",
		dependencies = "nvim-telescope/telescope.nvim",
		keys = { { "<leader>fW", "<cmd>Telescope ast_grep<cr>", desc = "Find Pattern (sg)" } },
	},

	{
		"piersolenski/telescope-import.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		keys = { { "<leader>fi", "<cmd>Telescope import<cr>", desc = "Find Imports" } },
	},

	{
		"crispgm/telescope-heading.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		keys = { { "<leader>fH", "<cmd>Telescope heading<cr>", desc = "Find Headings" } },
	},

	{
		"jvgrootveld/telescope-zoxide",
		dependencies = "nvim-telescope/telescope.nvim",
		keys = { { "<leader>zl", "<cmd>Telescope zoxide list<cr>", desc = "Zoxide List" } },
	},

	{
		"debugloop/telescope-undo.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		keys = { { "<leader>fu", "<cmd>Telescope undo<cr>", desc = "Find Undo" } },
	},

	{
		"tzachar/highlight-undo.nvim",
		keys = { { "u" }, { "<C-r>" }, { "p" }, { "P" } },
		opts = {},
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "LazyFile",
		opts = function()
			return require "plugins.options.gitsigns-opts"
		end,
	},

	{
		"sindrets/diffview.nvim",
		opts = function()
			dofile(vim.g.base46_cache .. "diffview")
			return {}
		end,
	},

	{
		"folke/noice.nvim",
		lazy = false,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		keys = function()
			return require "plugins.mappings.noice-keys"
		end,
		config = function()
			require "plugins.configs.noice-conf"
		end,
	},

	{
		"stevearc/dressing.nvim",
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load { plugins = { "dressing.nvim" } }
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load { plugins = { "dressing.nvim" } }
				return vim.ui.input(...)
			end
		end,
	},

	{
		"folke/trouble.nvim",
		event = "VeryLazy",
		cmd = "Trouble",
		dependencies = "folke/todo-comments.nvim",
		keys = require "plugins.mappings.trouble-keys",
		opts = require "plugins.options.trouble-opts",
		config = function(_, opts)
			require("trouble").setup(opts)
			dofile(vim.g.base46_cache .. "trouble")
		end,
	},

	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoQuickFix", "TodoTelescope" },
		event = "LazyFile",
		keys = require "plugins.mappings.todo-comments-keys",
		config = function(_, opts)
			require("todo-comments").setup(opts)
			dofile(vim.g.base46_cache .. "todo")
		end,
	},

	{
		"folke/ts-comments.nvim",
		event = "VeryLazy",
		opts = {},
	},

	{
		"michaelrommel/nvim-silicon",
		keys = require "plugins.mappings.silicon-keys",
		opts = require "plugins.options.silicon-opts",
	},

	{
		"rachartier/tiny-code-action.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		keys = { { "<leader>ca", desc = "LSP code action" } },
		opts = require "plugins.options.tiny-code-action-opts",
		config = function(_, opts)
			require("tiny-code-action").setup(opts)
		end,
	},

	{
		"okuuva/auto-save.nvim",
		version = "*",
		event = "InsertLeave",
		opts = require "plugins.options.auto-save-opts",
	},

	{
		"xvzc/chezmoi.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"alker0/chezmoi.vim",
		},
		keys = { { "<leader>fD", "<cmd>Telescope chezmoi find_files<cr>", desc = "Find Dotfiles" } },
		opts = require "plugins.options.chezmoi-nvim-opts",
		config = function(_, opts)
			require("chezmoi").setup(opts)
		end,
	},

	{
		"alker0/chezmoi.vim",
		lazy = false,
		init = function()
			require "plugins.configs.chezmoi-vim-conf"
		end,
	},

	{
		"folke/zen-mode.nvim",
		keys = require "plugins.mappings.zen-mode-keys",
		config = function()
			require "plugins.configs.zen-mode-conf"
		end,
	},

	{
		"folke/twilight.nvim",
		opts = require "plugins.options.twilight-opts",
	},

	{
		"nvim-neorg/neorg",
		version = "*",
		ft = "norg",
		opts = require "plugins.options.neorg-opts",
		config = function(_, opts)
			require("neorg").setup(opts)
			require "plugins.mappings.neorg-keys"
		end,
	},

	{
		"nvim-neorg/neorg-telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},

	{
		"lukas-reineke/headlines.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		ft = { "markdown", "norg" },
		opts = {},
	},

	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		keys = function()
			return require "plugins.mappings.persistence-keys"
		end,
		opts = {},
	},

	{
		"Wansmer/symbol-usage.nvim",
		event = "LspAttach",
		opts = require("plugins.options.symbol-usage-opts").opts,
	},

	{
		"nvim-tree/nvim-web-devicons",
		opts = function()
			return require "plugins.options.web-devicons-opts"
		end,
	},

	{
		"stevearc/overseer.nvim",
		enabled = false,
		keys = require "plugins.mappings.overseer-keys",
		opts = {},
	},

	{
		"karb94/neoscroll.nvim",
		keys = function()
			return require "plugins.mappings.neoscroll-keys"
		end,
		opts = require "plugins.options.neoscroll-opts",
	},

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		keys = function()
			return require "plugins.mappings.flash-keys"
		end,
		opts = {},
	},

	{
		"Wansmer/treesj",
		dependencies = "nvim-treesitter/nvim-treesitter",
		keys = require "plugins.mappings.treesj-keys",
		opts = require "plugins.options.treesj-opts",
	},

	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		keys = require "plugins.mappings.refactoring-keys",
		opts = require "plugins.options.refactoring-opts",
	},

	{
		"MagicDuck/grug-far.nvim",
		keys = require "plugins.mappings.grug-far-keys",
		opts = require "plugins.options.grug-far-opts",
	},

	{
		"folke/drop.nvim",
		event = "VimEnter",
		opts = require "plugins.options.drop-opts",
	},

	{
		"zeioth/garbage-day.nvim",
		dependencies = "neovim/nvim-lspconfig",
		event = "LspAttach",
		opts = require "plugins.options.garbage-day-opts",
	},

	{
		"m4xshen/hardtime.nvim",
		enabled = false,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
		},
		event = "VeryLazy",
		opts = require "plugins.options.hardtime-opts",
	},

	{
		"piersolenski/wtf.nvim",
		dependencies = "MunifTanjim/nui.nvim",
		keys = require "plugins.mappings.wtf-keys",
		opts = require "plugins.options.wtf-opts",
	},

	{
		"echasnovski/mini.pick",
		enabled = false,
		event = "VeryLazy",
		version = false,
		dependencies = "echasnovski/mini.extra",
		keys = function()
			return require "plugins.mappings.mini-pick-keys"
		end,
		opts = {},
	},

	{
		"echasnovski/mini.move",
		keys = require "plugins.mappings.mini-move-keys",
		opts = {},
	},

	{
		"nvim-zh/colorful-winsep.nvim",
		event = "WinLeave",
		opts = require "plugins.options.colorful-winsep-opts",
	},

	{
		"b0o/incline.nvim",
		enabled = false,
		event = "VeryLazy",
		config = function()
			require "plugins.configs.incline-conf"
		end,
	},

	{
		"folke/which-key.nvim",
		cmd = "WhichKey",
		event = "VeryLazy",
		version = "*",
		keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
		opts_extend = { "spec" },
		opts = function()
			return require "plugins.options.which-key-opts"
		end,
	},

	{
		"danymat/neogen",
		keys = require "plugins.mappings.neogen-keys",
		opts = {},
	},

	{
		"lewis6991/hover.nvim",
		event = "VeryLazy",
		keys = require "plugins.mappings.hover-keys",
		opts = {},
		init = function()
			utils.on_load("hover.nvim", function()
				vim.api.nvim_create_autocmd("LspAttach", {
					callback = function()
						require "hover.providers.lsp"
					end,
				})
				require "hover.providers.fold_preview"
				require "hover.providers.diagnostic"
				require "hover.providers.man"
			end)
		end,
	},
}
