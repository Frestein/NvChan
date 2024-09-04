local map = require("langmapper").map

local overseer = require "overseer"

-- stylua: ignore
local keymaps = {
  ["<leader>o"] = {
    func = function() overseer.toggle() end,
    desc = "overseer toggle",
  },
}

local modes = { "n" }

for key, value in pairs(keymaps) do
  map(modes, key, value.func, { desc = value.desc })
end
