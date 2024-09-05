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
    local map = require("langmapper").map

    local aerial = require "aerial"

    -- stylua: ignore
    local keymaps = {
      ["{"] = {
        func = function() aerial.prev() end,
        desc = "aerial previous"
      },
      ["}"] = {
        func = function() aerial.next() end,
        desc = "aerial next"
      },
      ["<leader>af"] = {
        func = function() aerial.focus() end,
        desc = "aerial focus"
      },
      ["<leader>ao"] = {
        func = function() aerial.open() end,
        desc = "aerial open"
      },
      ["<leader>aO"] = {
        func = function() aerial.open_all() end,
        desc = "aerial open all"
      },
      ["<leader>ac"] = {
        func = function() aerial.close() end,
        desc = "aerial close"
      },
      ["<leader>aC"] = {
        func = function() aerial.close_all() end,
        desc = "aerial close all"
      },
    }

    local modes = { "n" }

    for key, value in pairs(keymaps) do
      map(modes, key, value.func, { desc = value.desc, buffer = bufnr })
    end
  end,
}

return options
