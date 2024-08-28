local map = require("langmapper").map

-- stylua: ignore
local keymaps = {
  ["<leader>mm"] = {
    func = "<cmd>Mason<cr>",
    desc = "mason open home",
  },
  ["<leader>mi"] = {
    func = "<cmd>MasonInstallAll<cr>",
    desc = "mason install all packages",
  },
  ["<leader>mu"] = {
    func = "<cmd>MasonUpdate<cr>",
    desc = "mason update packages",
  },
}

local modes = { "n" }

for key, value in pairs(keymaps) do
  map(modes, key, value.func, { desc = value.desc })
end
