require("nvchad.configs.lspconfig").defaults()

local defaults = require "nvchad.configs.lspconfig"

local lspconfig = require "lspconfig"
local servers = {
  html = {},
  cssls = {},
  bashls = {},
  hyprls = {},
  taplo = {},
  yamlls = {},
  ansiblels = {},
  dockerls = {},
  clangd = {},
  marksman = {},
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

for name, options in pairs(servers) do
  options.on_init = defaults.on_init
  options.capabilities = defaults.capabilities

  options.on_attach = function(_, bufnr)
    local map = vim.keymap.set

    local actions_preview = require "actions-preview"

    local function opts(desc)
      return { buffer = bufnr, desc = "LSP " .. desc }
    end

    map("n", "gD", vim.lsp.buf.declaration, opts "go to declaration")
    map("n", "gd", vim.lsp.buf.definition, opts "go to definition")
    map("n", "gi", vim.lsp.buf.implementation, opts "go to implementation")
    map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "show signature help")
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "add workspace folder")
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "remove workspace folder")
    map("n", "gr", vim.lsp.buf.references, opts "show references")

    map("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts "list workspace folders")

    map("n", "<leader>D", vim.lsp.buf.type_definition, opts "go to type definition")

    map("n", "<leader>ra", function()
      require "nvchad.lsp.renamer"()
    end, opts "NvRenamer")

    map({ "n", "v" }, "<leader>ca", function()
      actions_preview.code_actions()
    end, opts "code action")
  end

  require("lspconfig")[name].setup(options)
end
