local map = require("langmapper").map

local wtf = require "wtf"

-- stylua: ignore
local keymaps = {
  ["<leader>ws"] = {
    modes = { "n" },
    func = function() require("wtf").search() end,
    desc = "wtf search diagnostic with duckduckgo",
  },
}

for key, value in pairs(keymaps) do
  map(value.modes, key, value.func, { desc = value.desc })
end
