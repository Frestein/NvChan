local set_keymaps = require("utils").set_keymaps
local map = require("langmapper").map

local aerial = require "aerial"
local telescope = require "telescope"

local M = {}

function M.lazy()
  local keymaps = {
    ["<leader>aa"] = { func = aerial.toggle, desc = "aerial toggle" },
    ["<leader>an"] = { func = aerial.nav_toggle, desc = "aerial navigation toggle" },
    ["<leader>fa"] = { func = telescope.extensions.aerial.aerial, desc = "telescope aerial" },
  }

  set_keymaps(map, keymaps)
end

function M.on_attach(bufnr)
  local keymaps = {
    ["{"] = { func = aerial.prev, desc = "aerial previous" },
    ["}"] = { func = aerial.next, desc = "aerial next" },
    ["<leader>af"] = { func = aerial.focus, desc = "aerial focus" },
    ["<leader>ao"] = { func = aerial.open, desc = "aerial open" },
    ["<leader>aO"] = { func = aerial.open_all, desc = "aerial open all" },
    ["<leader>ac"] = { func = aerial.close, desc = "aerial close" },
    ["<leader>aC"] = { func = aerial.close_all, desc = "aerial close all" },
  }

  set_keymaps(map, keymaps, bufnr)
end

return M
