local map = require("langmapper").map

local noice = require "noice"

-- stylua: ignore
local keymaps = {
  ["<leader>nd"] = {
    func = function() noice.cmd "dismiss" end,
    desc = "notices dismiss all visible messages",
  },
  ["<leader>nl"] = {
    func = function() noice.cmd "last" end,
    desc = "notices show the last message",
  },
  ["<leader>nh"] = {
    func = function() noice.cmd "history" end,
    desc = "notices show the notice history",
  },
  ["<leader>fn"] = {
    func = function() noice.cmd "telescope" end,
    desc = "telescope find notices",
  },
}

local modes = { "n" }

for key, value in pairs(keymaps) do
  map(modes, key, value.func, { desc = value.desc })
end
