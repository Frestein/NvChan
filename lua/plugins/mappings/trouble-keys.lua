local map = require("langmapper").map

-- stylua: ignore
local keymaps = {
  ["<leader>td"] = {
    func = "<cmd>Trouble diagnostics toggle<cr>",
    desc = "toggle diagnostics",
  },
}

local modes = { "n" }

for key, value in pairs(keymaps) do
  map(modes, key, value.func, { desc = value.desc })
end
