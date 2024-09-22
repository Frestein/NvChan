require("nvchad.configs.lspconfig").defaults()

local defaults = require "nvchad.configs.lspconfig"

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

local lspconfig = require "lspconfig"
local servers = {
  html = {},
  cssls = {},
  bashls = {},
  hyprls = {},
  taplo = {},
  jsonls = {
    -- lazy-load schemastore when needed
    on_new_config = function(new_config)
      new_config.settings.json.schemas = new_config.settings.json.schemas or {}
      vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
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
        vim.tbl_deep_extend("force", new_config.settings.yaml.schemas or {}, require("schemastore").yaml.schemas())
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

for name, opts in pairs(servers) do
  opts.on_init = defaults.on_init
  opts.capabilities = defaults.capabilities

  opts.on_attach = function(_, bufnr)
    require("plugins.mappings.lspconfig-keys").on_attach(bufnr)
  end

  require("lspconfig")[name].setup(opts)
end
