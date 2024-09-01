local map = require("langmapper").map

local neocodeium = require "neocodeium"

-- stylua: ignore
local keymaps = {
  ["<C-f>"] = {
    modes = { "i" },
    func = function() neocodeium.accept() end,
    desc = "neocodeium accept",
  },
  ["<C-w>"] = {
    modes = { "i" },
    func = function() neocodeium.accept_word() end,
    desc = "neocodeium accept word",
  },
  ["<C-l>"] = {
    modes = { "i" },
    func = function() neocodeium.accept_line() end,
    desc = "neocodeium accept line",
  },
  ["<C-e>"] = {
    modes = { "i" },
    func = function() neocodeium.cycle_or_complete() end,
    desc = "neocodeium cycle or complete",
  },
  ["<C-r>"] = {
    modes = { "i" },
    func = function() neocodeium.cycle_or_complete(-1) end,
    desc = "neocodeium cycle or complete (reverse)",
  },
  ["<C-c>"] = {
    modes = { "i" },
    func = function() neocodeium.clear() end,
    desc = "neocodeium clear",
  },
  ["<leader>tc"] = {
    modes = { "n" },
    func = function() neocodeium.chat() end,
    desc = "neocodeium chat",
  },
}

for key, value in pairs(keymaps) do
  map(value.modes, key, value.func, { desc = value.desc })
end
