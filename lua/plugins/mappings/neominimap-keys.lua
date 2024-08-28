local map = require("langmapper").map

local neominimap = require "neominimap"

-- stylua: ignore
local keymaps = {
  ["<leader>nm"] = {
    func = function() neominimap.toggle() end,
    desc = "minimap toggle global minimap",
  },
  ["<leader>nr"] = {
    func = function() neominimap.refresh() end,
    desc = "minimap refresh global minimap",
  },
  ["<leader>nw"] = {
    func = function(bufnr) neominimap.winToggle({ bufnr = bufnr }) end,
    desc = "minimap toggle minimap for current window",
  },
  ["<leader>nt"] = {
    func = function(bufnr) neominimap.tabToggle({ bufnr = bufnr }) end,
    desc = "minimap toggle minimap for current tab",
  },
  ["<leader>nb"] = {
    func = function(bufnr) neominimap.bufToggle({ bufnr = bufnr }) end,
    desc = "minimap toggle minimap for current buffer",
  },
  ["<leader>nf"] = {
    func = function() neominimap.focus() end,
    desc = "minimap switch focus on minimap",
  },
}

local modes = { "n" }

for key, value in pairs(keymaps) do
  map(modes, key, value.func, { desc = value.desc })
end
