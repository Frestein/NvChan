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

local modes = { "n" }

for key, value in pairs(keymaps) do
  map(modes, key, value.func, { desc = value.desc })
end
