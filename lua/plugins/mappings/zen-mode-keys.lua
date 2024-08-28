local map = require("langmapper").map

local zen_mode = require "zen-mode"

-- stylua: ignore
local keymaps = {
  ["<leader>z"] = {
    func = zen_mode.toggle,
    desc = "toggle zen-mode",
  },
}

local modes = { "n" }

for key, value in pairs(keymaps) do
  map(modes, key, value.func, { desc = value.desc })
end
