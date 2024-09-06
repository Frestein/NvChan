local opts = require "nvchad.configs.gitsigns"

opts.current_line_blame = true
opts.current_line_blame_opts = { delay = 500 }

opts.on_attach = function(bufnr)
  require("plugins.mappings.gitsigns-keys").on_attach(bufnr)
end

return opts
