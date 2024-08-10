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
}

for name, options in pairs(servers) do
  options.on_init = defaults.on_init
  options.on_attach = defaults.on_attach
  options.capabilities = defaults.capabilities

  require("lspconfig")[name].setup(options)
end
