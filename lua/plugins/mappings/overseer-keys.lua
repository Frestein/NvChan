local set_keymaps = require("utils").set_keymaps
local map = require("langmapper").map

local overseer = require "overseer"

-- stylua: ignore
local keymaps = {
  ["<leader>o"] = {
    func = function() overseer.toggle() end,
    desc = "overseer toggle",
  },
}

set_keymaps(map, keymaps)
