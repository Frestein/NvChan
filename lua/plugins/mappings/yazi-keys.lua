local map = require("langmapper").map

local yazi = require("yazi")

-- stylua: ignore
local keymaps = {
  ["<leader>-"] = {
    func = yazi.yazi,
    desc = "yazi open",
  },
}

local modes = { "n" }

for key, value in pairs(keymaps) do
  map(modes, key, value.func, { desc = value.desc })
end
