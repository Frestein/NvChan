require("utils.plugin").lazy_file()

return {
	{ "nvim-lua/plenary.nvim" },
	{ "Luxed/aw-watcher-nvim", lazy = false },
	{ "artemave/workspace-diagnostics.nvim", opts = {} },
	{ "Bilal2453/luvit-meta", lazy = true },

	{
		"Frestein/showkeys",
		cmd = "ShowkeysToggle",
		opts = require "plugins.options.showkeys-opts",
	},

	{
		"folke/lazydev.nvim",
		ft = "lua",
		cmd = "LazyDev",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},

	{
		"folke/snacks.nvim",
		lazy = false,
		priority = 999,
		opts = function()
			return require "plugins.options.snacks-opts"
		end,
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					_G.Snacks = require "snacks"
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
		lazy = true,
		build = function()
			require("base46").load_all_highlights()
		end,
	},

	{
		"Wansmer/langmapper.nvim",
		lazy = false,
		priority = 1000,
		opts = require "plugins.options.langmapper-opts",
		config = function(_, opts)
			require("langmapper").setup(opts)
			require("langmapper").hack_get_keymap()
		end,
	},

	{
		"stevearc/conform.nvim",
		cmd = "ConformInfo",
		keys = { { mode = { "n", "v" }, "<leader>cf", desc = "code format code" } },
		config = function()
			require "plugins.configs.conform-conf"
			require "plugins.mappings.conform-keys"
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
		keys = {
			{ "<c-space>", desc = "treesitter increment selection" },
			{ mode = "x", "<bs>", desc = "treesitter decrement selection" },
		},
		init = function(plugin)
			-- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
			-- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
			-- no longer trigger the **nvim-treesitter** module to be loaded in time.
			-- Luckily, the only things that those plugins need are the custom queries, which we make available
			-- during startup.
			require("lazy.core.loader").add_to_rtp(plugin)
			require "nvim-treesitter.query_predicates"
		end,
		opts = function()
			return require "plugins.options.treesitter-opts"
		end,
		---@param opts TSConfig
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
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
		"L3MON4D3/LuaSnip",
		dependencies = "rafamadriz/friendly-snippets",
		config = function()
			require "plugins.configs.luasnip-conf"
		end,
	},

	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		version = false,
		config = function()
			require "plugins.configs.mini-pairs-conf"
		end,
	},

	{
		"echasnovski/mini.surround",
		event = "VeryLazy",
		version = false,
		opts = require "plugins.options.mini-surround-opts",
	},

	{
		"echasnovski/mini.files",
		event = "VeryLazy",
		version = false,
		keys = {
			{ "<leader>e", desc = "MiniFiles toggle current directory" },
			{ "<leader>E", desc = "MiniFiles toggle root directory" },
		},
		opts = require("plugins.options.mini-files-opts").opts,
		config = function(_, opts)
			require("mini.files").setup(opts)
			require "plugins.mappings.mini-files-keys"
		end,
	},

	{
		"supermaven-inc/supermaven-nvim",
		event = "InsertEnter",
		keys = {
			{ mode = { "i" }, "<C-f>", desc = "supermaven accept suggestion" },
			{ mode = { "i" }, "<C-w>", desc = "supermaven accept word" },
			{ mode = { "i" }, "<C-c>", desc = "supermaven clear suggestion" },
		},
		opts = require "plugins.options.supermaven-opts",
		config = function(_, opts)
			require("supermaven-nvim").setup(opts)
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = "LazyFile",
		config = function()
			require "plugins.configs.indent-blankline-conf"
		end,
	},

	{
		"Frestein/lsp_lines.nvim",
		event = "LspAttach",
		config = function()
			require "plugins.configs.lsplines-conf"
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
		keys = {
			{ "<leader>ff", desc = "telescope find files" },
			{ "<leader>fm", desc = "telescope find marks" },
			{ "<leader>fw", desc = "telescope live grep" },
			{ "<leader>fb", desc = "telescope find buffers" },
			{ "<leader>fh", desc = "telescope help page" },
			{ "<leader>fr", desc = "telescope recent files" },
			{ "<leader>fz", desc = "telescope find in current buffer" },
			{ "<leader>fd", desc = "telescope find diagnostics" },
			{ "<leader>th", desc = "telescope find themes" },
			{ "<leader>fk", desc = "telescope find keymaps" },
		},
		opts = function()
			return require "plugins.options.telescope-opts"
		end,
		config = function(_, opts)
			require("telescope").setup(opts)
			dofile(vim.g.base46_cache .. "telescope")
			require "plugins.mappings.telescope-keys"
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
		keys = { { "<leader>F", "<cmd>Telescope smart_open<cr>", desc = "telescope smart open" } },
	},

	{
		"Marskey/telescope-sg",
		dependencies = "nvim-telescope/telescope.nvim",
		keys = { { "<leader>fW", "<cmd>Telescope ast_grep<cr>", desc = "telescope live grep (sg)" } },
	},

	{
		"tsakirist/telescope-lazy.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		keys = { { "<leader>fP", "<cmd>Telescope lazy<cr>", desc = "telescope installed plugins" } },
	},

	{
		"piersolenski/telescope-import.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		keys = { { "<leader>fi", "<cmd>Telescope import<cr>", desc = "telescope find imports" } },
	},

	{
		"crispgm/telescope-heading.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		keys = { { "<leader>fH", "<cmd>Telescope heading<cr>", desc = "telescope heading list" } },
	},

	{
		"jvgrootveld/telescope-zoxide",
		dependencies = "nvim-telescope/telescope.nvim",
		keys = { { "<leader>zl", "<cmd>Telescope zoxide list<cr>", desc = "telescope zoxide list" } },
	},

	{
		"debugloop/telescope-undo.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		keys = { { "<leader>fu", "<cmd>Telescope undo<cr>", desc = "telescope find undo" } },
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
		keys = { { "<leader>fn", desc = "telescope find notices" } },
		config = function()
			require "plugins.configs.noice-conf"
			require "plugins.mappings.noice-keys"
		end,
	},

	{
		"stevearc/dressing.nvim",
		lazy = true,
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
		keys = {
			{ "<leader>xx", desc = "trouble toggle diagnostics" },
			{ "<leader>xX", desc = "trouble toggle buffer diagnostics" },
			{ "<leader>xL", desc = "trouble toggle location list" },
			{ "<leader>xQ", desc = "trouble toggle quickfix list" },
			{ "<leader>xs", desc = "trouble toggle document symbols" },
			{ "<leader>xS", desc = "trouble LSP definitions / references / ..." },
			{
				"[q",
				function()
					if require("trouble").is_open() then
						require("trouble").prev { skip_groups = true, jump = true }
					else
						local ok, err = pcall(vim.cmd.cprev)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Previous Trouble/Quickfix Item",
			},
			{
				"]q",
				function()
					if require("trouble").is_open() then
						require("trouble").next { skip_groups = true, jump = true }
					else
						local ok, err = pcall(vim.cmd.cnext)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Next Trouble/Quickfix Item",
			},
		},
		opts = require "plugins.options.trouble-opts",
		config = function(_, opts)
			require("trouble").setup(opts)
			dofile(vim.g.base46_cache .. "trouble")
			require "plugins.mappings.trouble-keys"
		end,
	},

	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoQuickFix", "TodoTelescope" },
		event = "LazyFile",
		keys = {
			{ "<leader>tt", desc = "todo-comments show the todo list" },
			{ "<leader>tq", desc = "todo-comments show quickfix" },
			{ "<leader>fT", desc = "telescope todo list" },
		},
		config = function(_, opts)
			require("todo-comments").setup(opts)
			dofile(vim.g.base46_cache .. "todo")
			require "plugins.mappings.todo-comments-keys"
		end,
	},

	{
		"folke/ts-comments.nvim",
		event = "VeryLazy",
		opts = {},
	},

	{
		"michaelrommel/nvim-silicon",
		keys = {
			{ mode = { "v" }, "<leader>ss", desc = "snapshot screenshot code" },
			{ mode = { "v" }, "<leader>sf", desc = "snapshot screenshot code as file" },
			{ mode = { "v" }, "<leader>sc", desc = "snapshot screenshot code to clipboard" },
		},
		opts = require "plugins.options.silicon-opts",
		config = function(_, opts)
			require("nvim-silicon").setup(opts)
			require "plugins.mappings.silicon-keys"
		end,
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
		keys = { { "<leader>fD", "<cmd>Telescope chezmoi find_files<cr>", desc = "telescope find dotfiles" } },
		opts = require "plugins.options.chezmoi-nvim-opts",
		config = function(_, opts)
			require("chezmoi").setup(opts)
		end,
	},

	{
		"alker0/chezmoi.vim",
		lazy = false,
		opts = require "plugins.options.chezmoi-vim-opts",
		config = function(_, opts)
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
		end,
	},

	{
		"folke/zen-mode.nvim",
		keys = { { "<leader>z", desc = "toggle zen-mode" } },
		config = function()
			require "plugins.configs.zen-mode-conf"
			require "plugins.mappings.zen-mode-keys"
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
		event = "VeryLazy",
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
		keys = {
			{ "<leader>qs", desc = "session select session" },
			{ "<leader>qL", desc = "session restore session" },
			{ "<leader>ql", desc = "session restore last session" },
			{ "<leader>qq", desc = "session quit all" },
			{ "<leader>qQ", desc = "session quit all without save session" },
		},
		config = function(_, opts)
			require("persistence").setup(opts)
			require "plugins.mappings.persistence-keys"
		end,
	},

	{
		"Wansmer/symbol-usage.nvim",
		event = "LspAttach",
		opts = require("plugins.options.symbol-usage-opts").opts,
	},

	{
		"stevearc/aerial.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		event = "LazyFile",
		keys = {
			{ "<leader>aa", desc = "aerial toggle" },
			{ "<leader>an", desc = "aerial navigation toggle" },
			{ "<leader>fa", desc = "telescope aerial" },
		},
		opts = require "plugins.options.aerial-opts",
		config = function(_, opts)
			require("aerial").setup(opts)
			require("plugins.mappings.aerial-keys").lazy()
		end,
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
		keys = { { "<leader>o", desc = "overseer toggle" } },
		config = function(_, opts)
			require("overseer").setup(opts)
			require "plugins.mappings.overseer-keys"
		end,
	},

	{
		"karb94/neoscroll.nvim",
		keys = {
			{ mode = { "n", "v" }, "<C-u>", desc = "scroll scroll up half a page" },
			{ mode = { "n", "v" }, "<C-d>", desc = "scroll scroll down half a page" },
			{ mode = { "n", "v" }, "<C-b>", desc = "scroll scroll up one full page" },
			{ mode = { "n", "v" }, "<C-f>", desc = "scroll scroll down one full page" },
			{ mode = { "n", "v" }, "<C-y>", desc = "scroll scroll up a little without moving the cursor" },
			{ mode = { "n", "v" }, "<C-e>", desc = "scroll scroll down a little without moving the cursor" },
			{ mode = { "n", "v" }, "zt", desc = "scroll move the current line to the top of the window" },
			{ mode = { "n", "v" }, "zz", desc = "scroll center the current line in the window" },
			{ mode = { "n", "v" }, "zb", desc = "scroll move the current line to the bottom of the window" },
		},
		opts = require "plugins.options.neoscroll-opts",
		config = function(_, opts)
			require("neoscroll").setup(opts)
			require "plugins.mappings.neoscroll-keys"
		end,
	},

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		keys = {
			{ mode = { "n", "x", "o" }, "s", desc = "flash jump" },
			{ mode = { "n", "x", "o" }, "S", desc = "flash treesitter" },
			{ mode = { "x", "o" }, "R", desc = "flash treesitter search" },
			{ mode = { "o" }, "r", desc = "flash remote" },
			{ mode = { "c" }, "<C-s>", desc = "flash toggle flash search" },
		},
		config = function(_, opts)
			require("flash").setup(opts)
			require "plugins.mappings.flash-keys"
		end,
	},

	{
		"Wansmer/treesj",
		dependencies = "nvim-treesitter/nvim-treesitter",
		keys = {
			{ "<leader>m", desc = "treesj toggle node under cursor" },
			{ "<leader>M", desc = "treesj toggle node recursive under cursor" },
			{ "<leader>j", desc = "treesj join node under cursor" },
			{ "<leader>s", desc = "treesj split node under cursor" },
		},
		opts = require "plugins.options.treesj-opts",
		config = function(_, opts)
			require("treesj").setup(opts)
			require "plugins.mappings.treesj-keys"
		end,
	},

	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		keys = {
			{ mode = { "x" }, "<leader>re", desc = "refactor extract function" },
			{ mode = { "x" }, "<leader>rf", desc = "refactor extract function to file" },
			{ mode = { "x" }, "<leader>rv", desc = "refactor extract variable" },
			{ "<leader>rI", desc = "refactor inline function" },
			{ mode = { "n", "x" }, "<leader>ri", desc = "refactor inline variable" },
			{ "<leader>rb", desc = "refactor extract block" },
			{ "<leader>rB", desc = "refactor extract block to file" },
			{ mode = { "n", "x" }, "<leader>rr", desc = "refactor select refactor" },
		},
		opts = require "plugins.options.refactoring-opts",
		config = function(_, opts)
			require("refactoring").setup(opts)
			require "plugins.mappings.refactoring-keys"
		end,
	},

	{
		"MagicDuck/grug-far.nvim",
		keys = {
			{ "<leader>rw", "grug-far open with word under cursor" },
			{ "<leader>rc", "grug-far open for current file" },
			{ mode = { "x" }, "<leader>rC", "grug-far open with visual selection" },
		},
		opts = require "plugins.options.grug-far-opts",
		config = function(_, opts)
			require("grug-far").setup(opts)
			require "plugins.mappings.grug-far-keys"
		end,
	},

	{
		"andrewferrier/debugprint.nvim",
		event = "VeryLazy",
		opts = {},
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
		keys = { { "<leader>ws", desc = "wtf search diagnostic with duckduckgo" } },
		opts = require "plugins.options.wtf-opts",
		config = function(_, opts)
			require("wtf").setup(opts)
			require "plugins.mappings.wtf-keys"
		end,
	},

	{
		"b0o/schemastore.nvim",
		version = false,
	},

	{
		"echasnovski/mini.pick",
		dependencies = "echasnovski/mini.extra",
		event = "VeryLazy",
		enabled = false,
		version = false,
		keys = {
			{ "<leader>ff", desc = "MiniPick find files" },
			{ "<leader>fw", desc = "MiniPick grep files" },
			{ "<leader>fW", desc = "MiniPick live grep files" },
			{ "<leader>fb", desc = "MiniPick find buffers" },
			{ "<leader>fh", desc = "MiniPick find help" },
			{ "<leader>fr", desc = "MiniPick latest picker" },
			{ "<leader>fz", desc = "MiniPick buffer lines" },
			{ "<leader>fm", desc = "MiniPick marks" },
			{ "<leader>th", desc = "MiniPick find themes" },
			-- spellchecker: disable-line
			{ "<leader>fo", desc = "MiniPick oldfiles" },
			{ "<leader>fs", desc = "MiniPick spell suggestions" },
			{ "<leader>fgb", desc = "MiniPick git branches" },
			{ "<leader>fgc", desc = "MiniPick git commits" },
			{ "<leader>fgf", desc = "MiniPick git files" },
			{ "<leader>fgh", desc = "MiniPick git hunks" },
			{ "<leader>fsh", desc = "MiniPick history" },
			{ "<leader>fhl", desc = "MiniPick highlight groups" },
			{ "<leader>fch", desc = "MiniPick keymaps" },
		},
		config = function(_, opts)
			require("mini.pick").setup(opts)
			require "plugins.mappings.mini-pick-keys"
		end,
	},

	{
		"echasnovski/mini.extra",
		enabled = false,
		version = false,
	},

	{
		"echasnovski/mini.move",
		version = false,
		keys = {
			{ mode = { "n", "x" }, "<M-h>", desc = "code block left" },
			{ mode = { "n", "x" }, "<M-j>", desc = "code block down" },
			{ mode = { "n", "x" }, "<M-k>", desc = "code block up" },
			{ mode = { "n", "x" }, "<M-l>", desc = "code block right" },
		},
		opts = {},
	},

	{
		"nvim-zh/colorful-winsep.nvim",
		event = "WinLeave",
		opts = require "plugins.options.colorful-winsep-opts",
	},

	{
		"b0o/incline.nvim",
		event = "VeryLazy",
		config = function()
			require "plugins.configs.incline-conf"
		end,
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
		cmd = "WhichKey",
		opts_extend = { "spec" },
		opts = function()
			dofile(vim.g.base46_cache .. "whichkey")
			return {}
		end,
	},
}
