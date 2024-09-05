local map = require("langmapper").map

local aerial = require "aerial"
local telescope = require "telescope"

-- stylua: ignore
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
