local set_keymaps = require("utils").set_keymaps
local map = require("langmapper").map

local keymaps = {
  ["<leader>mm"] = { func = "<cmd>Mason<cr>", desc = "mason open home" },
  ["<leader>mu"] = { func = "<cmd>MasonUpdate<cr>", desc = "mason update packages" },
  ["<leader>mi"] = { func = "<cmd>MasonInstallAll<cr>", desc = "mason install all packages" },
}

set_keymaps(map, keymaps)
