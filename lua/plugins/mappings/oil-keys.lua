local set_keymaps = require("utils").set_keymaps
local map = require("langmapper").map

local oil = require "oil"

-- stylua: ignore
local keymaps = {
  ["<leader>e"] = {
    func = oil.open,
    desc = "file open parent directory",
  },
  ["<leader>fl"] = {
    func = oil.toggle_float,
    desc = "file open parent directory (float)",
  },
}

set_keymaps(map, keymaps)
