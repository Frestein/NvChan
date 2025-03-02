return {
	"neovim/nvim-lspconfig",
	event = "LazyFile",
	config = function()
		local lspconfig = require "lspconfig"
		local schemastore = require "schemastore"

		local M = {}

		M.diagnostic_config = function()
			local x = vim.diagnostic.severity

			vim.diagnostic.config {
				virtual_text = { prefix = "" },
				signs = { text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" } },
				underline = true,
				float = { border = "single" },
			}
		end

		M.on_init = function(client, _)
			if client.supports_method "textDocument/semanticTokens" then
				client.server_capabilities.semanticTokensProvider = nil
			end
		end

		M.capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			require("blink.cmp").get_lsp_capabilities()
		)

		M.capabilities.textDocument.completion.completionItem = {
			documentationFormat = { "markdown", "plaintext" },
			snippetSupport = true,
			preselectSupport = true,
			insertReplaceSupport = true,
			labelDetailsSupport = true,
			deprecatedSupport = true,
			commitCharactersSupport = true,
			tagSupport = { valueSet = { 1 } },
			resolveSupport = {
				properties = {
					"documentation",
					"detail",
					"additionalTextEdits",
				},
			},
		}

		local function get_filetypes(command)
			local filetypes = {}
			local handle = io.popen(command)

			if not handle then
				return filetypes
			end

			local result = handle:read "*a"
			handle:close()

			for line in result:gmatch "[^\n]+" do
				local filetype = line:match "^(%S+):"
				if filetype then
					table.insert(filetypes, filetype)
				end
			end

			return filetypes
		end

		M.servers = {
			html = {},
			cssls = {},
			bashls = {},
			hyprls = {},
			fish_lsp = {},
			taplo = {},
			jsonls = {
				-- lazy-load schemastore when needed
				on_new_config = function(new_config)
					new_config.settings.json.schemas = new_config.settings.json.schemas or {}
					vim.list_extend(new_config.settings.json.schemas, schemastore.json.schemas())
				end,
				settings = {
					json = {
						format = {
							enable = true,
						},
						validate = { enable = true },
					},
				},
			},
			yamlls = {
				-- Have to add this for yamlls to understand that we support line folding
				capabilities = {
					textDocument = {
						foldingRange = {
							dynamicRegistration = false,
							lineFoldingOnly = true,
						},
					},
				},
				-- lazy-load schemastore when needed
				on_new_config = function(new_config)
					new_config.settings.yaml.schemas =
						vim.tbl_deep_extend("force", new_config.settings.yaml.schemas or {}, schemastore.yaml.schemas())
				end,
				settings = {
					redhat = { telemetry = { enabled = false } },
					yaml = {
						keyOrdering = false,
						format = {
							enable = true,
						},
						validate = true,
						schemaStore = {
							-- Must disable built-in schemaStore support to use
							-- schemas from SchemaStore.nvim plugin
							enable = false,
							-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
							url = "",
						},
					},
				},
			},
			ansiblels = {},
			dockerls = {},
			clangd = {},
			marksman = {},
			golangci_lint_ls = {},
			gopls = {
				settings = {
					gopls = {
						gofumpt = true,
						codelenses = {
							gc_details = false,
							generate = true,
							regenerate_cgo = true,
							run_govulncheck = true,
							test = true,
							tidy = true,
							upgrade_dependency = true,
							vendor = true,
						},
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
						analyses = {
							fieldalignment = true,
							nilness = true,
							unusedparams = true,
							unusedwrite = true,
							useany = true,
						},
						usePlaceholders = true,
						completeUnimported = true,
						staticcheck = true,
						directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
						semanticTokens = true,
					},
				},
			},
			-- pyright = {
			-- 	settings = {
			-- 		python = {
			-- 			analysis = {
			-- 				diagnosticMode = "workspace",
			-- 				typeCheckingMode = "off",
			-- 			},
			-- 		},
			-- 	},
			-- },
			basedpyright = {
				settings = {
					basedpyright = {
						analysis = {
							diagnosticMode = "workspace",
							typeCheckingMode = "off",
						},
					},
				},
			},
			-- pylyzer = {},
			ruff = {},
			ast_grep = {
				default_config = {
					cmd = { "ast-grep", "lsp" },
					single_file_support = false,
					root_dir = lspconfig.util.root_pattern(".git", "sgconfig.yml"),
				},
			},
			typos_lsp = {
				init_options = {
					diagnosticSeverity = "Info",
				},
				filetypes = get_filetypes "typos --type-list",
			},
			lua_ls = {
				settings = {
					Lua = {
						hint = {
							enable = true,
							arrayIndex = "Disable",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = {
								vim.fn.expand "$VIMRUNTIME/lua",
								vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
								vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
								vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
								"${3rd}/luv/library",
							},
							maxPreload = 100000,
							preloadFileSize = 10000,
						},
					},
				},
			},
		}

		dofile(vim.g.base46_cache .. "lsp")

		M.diagnostic_config()

		for name, opts in pairs(M.servers) do
			opts.on_init = M.on_init
			opts.capabilities = M.capabilities
			opts.on_attach = function(_, bufnr)
				local lsp = vim.lsp.buf

				-- stylua: ignore
				local keymaps = {
					{ "<Tab>", function() lsp.hover() end, desc = "Show Information" },
					{ "<leader>cS", function() lsp.signature_help() end, desc = "Show Signature" },
					{ "<leader>cwa", function() lsp.add_workspace_folder() end, desc = "Add Folder (LSP)" },
					{ "<leader>cwr", function() lsp.remove_workspace_folder() end, desc = "Remove Folder (LSP)" },
					{ "<leader>cwl", function() print(vim.inspect(lsp.list_workspace_folders())) end, desc = "List Folders (LSP)" },
					{
						"<leader>cwp",
						function()
							for _, client in ipairs(vim.lsp.get_clients()) do
								require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
							end
						end,
						desc = "Populate Diagnostics (LSP)",
					},
					{ "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
					{ "<leader>cr", function() require("live-rename").rename { insert = true } end, desc = "Rename" },
					{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
					{ "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" } },
					{ "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens" },
					{ "<a-p>", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference" },
					{ "<a-n>", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference" },
					{ "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference" },
					{ "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference" },
					{ "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
					{ "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
				}

				for _, keymap in ipairs(keymaps) do
					if keymap.mode then
						vim.keymap.set(keymap.mode, keymap[1], keymap[2], { desc = keymap.desc, buffer = bufnr })
					else
						vim.keymap.set("n", keymap[1], keymap[2], { desc = keymap.desc, buffer = bufnr })
					end
				end
			end

			lspconfig[name].setup(opts)
		end
	end,
}
