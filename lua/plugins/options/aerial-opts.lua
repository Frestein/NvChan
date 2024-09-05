local options = {
  layout = {
    default_direction = "prefer_left",
  },

  manage_folds = true,

  link_folds_to_tree = true,

  lsp = {
    diagnostics_trigger_update = true,
  },

  on_attach = function(bufnr)
    require("plugins.mappings.aerial-keys").on_attach(bufnr)
  end,
}

return options
