local set_keymaps = require("utils").set_keymaps
local map = require("langmapper").map

local oil = require "oil"

-- stylua: ignore
local keymaps = {
  ["<leader>e"] = {
    func = oil.toggle_float,
    desc = "oil toggle current directory (float)",
  },
  ["<leader>E"] = {
    func = oil.open,
    desc = "oil open current directory",
  },
}

set_keymaps(map, keymaps)
