local map = require("langmapper").map

local aerial = require "aerial"
local telescope = require "telescope"

local M = {}

function M.lazy()
  local keymaps = {
    ["<leader>a"] = {
      func = aerial.toggle,
      desc = "aerial toggle",
    },
    ["<leader>an"] = {
      func = aerial.nav_toggle,
      desc = "aerial navigation toggle",
    },
    ["<leader>fa"] = {
      func = telescope.extensions.aerial.aerial,
      desc = "telescope aerial",
    },
  }

  local modes = { "n" }

  for key, value in pairs(keymaps) do
    map(modes, key, value.func, { desc = value.desc })
  end
end

function M.on_attach(bufnr)
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
end

return M
