local set_keymaps = require("utils").set_keymaps
local map = require("langmapper").map

local yazi = require "yazi"

local keymaps = {
  ["<leader>-"] = { func = yazi.yazi, desc = "yazi open" },
}

set_keymaps(map, keymaps)
