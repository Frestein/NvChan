local map = require("langmapper").map

local neogit = require "neogit"

-- stylua: ignore
local keymaps = {
  ["<leader>gg"] = {
    func = neogit.open,
    desc = "neogit open",
  },
  ["<leader>gl"] = {
    func = function() neogit.open { "log" } end,
    desc = "neogit log",
  },
}

local modes = { "n" }

for key, value in pairs(keymaps) do
  map(modes, key, value.func, { desc = value.desc })
end
