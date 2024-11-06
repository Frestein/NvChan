local defaults = require "plugins.options.lspconfig-opts"
local lspconfig = require "lspconfig"

dofile(vim.g.base46_cache .. "lsp")
defaults.diagnostic_config()

for name, opts in pairs(defaults.servers) do
	opts.on_init = defaults.on_init
	opts.capabilities = defaults.capabilities

	opts.on_attach = function(_, bufnr)
		require("plugins.mappings.lspconfig-keys").on_attach(bufnr)
	end

	lspconfig[name].setup(opts)
end
