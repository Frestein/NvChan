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

local has_cmp, cmp = pcall(require, "cmp_nvim_lsp")
local has_blink, blink = pcall(require, "blink.cmp")

M.capabilities = vim.tbl_deep_extend(
	"force",
	{},
	vim.lsp.protocol.make_client_capabilities(),
	has_cmp and cmp.default_capabilities() or {},
	has_blink and blink.get_lsp_capabilities() or {}
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
	pyright = {
		root_dir = lspconfig.util.root_pattern(".git", "setup.py", "pyproject.toml", "requirements.txt"),
		settings = {
			python = {
				analysis = {
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					typeCheckingMode = "off",
				},
			},
		},
	},
	ruff = {
		root_dir = lspconfig.util.root_pattern(".git", "setup.py", "pyproject.toml", "requirements.txt"),
	},
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

return M
