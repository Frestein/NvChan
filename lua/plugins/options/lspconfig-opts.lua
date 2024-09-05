require("nvchad.configs.lspconfig").defaults()

local defaults = require "nvchad.configs.lspconfig"

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
}

for name, opts in pairs(servers) do
  opts.on_init = defaults.on_init
  opts.capabilities = defaults.capabilities

  opts.on_attach = function(_, bufnr)
    local map = vim.keymap.set

    local actions_preview = require "actions-preview"

    local function options(desc)
      return { buffer = bufnr, desc = "LSP " .. desc }
    end

    map("n", "gD", vim.lsp.buf.declaration, options "go to declaration")
    map("n", "gd", vim.lsp.buf.definition, options "go to definition")
    map("n", "gi", vim.lsp.buf.implementation, options "go to implementation")
    map("n", "<leader>sh", vim.lsp.buf.signature_help, options "show signature help")
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, options "add workspace folder")
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, options "remove workspace folder")
    map("n", "gr", vim.lsp.buf.references, options "show references")

    map("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, options "list workspace folders")

    map("n", "<leader>D", vim.lsp.buf.type_definition, options "go to type definition")

    map("n", "<leader>ra", function()
      require "nvchad.lsp.renamer"()
    end, options "NvRenamer")

    map({ "n", "v" }, "<leader>ca", function()
      actions_preview.code_actions()
    end, options "code action")
  end

  require("lspconfig")[name].setup(opts)
end
