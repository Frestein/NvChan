local map = require("langmapper").map

local silicon = require "nvim-silicon"

-- stylua: ignore
local keymaps = {
  ["<leader>ss"] = {
    func = silicon.shoot,
    desc = "snapshot screenshot code",
  },
  ["<leader>sf"] = {
    func = silicon.file,
    desc = "snapshot screenshot code as file",
  },
  ["<leader>sc"] = {
    func = silicon.clip,
    desc = "snapshot screenshot code to clipboard",
  },
}

local modes = { "v" }

for key, value in pairs(keymaps) do
  map(modes, key, value.func, { desc = value.desc })
end
