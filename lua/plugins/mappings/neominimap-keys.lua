local set_keymaps = require("utils").set_keymaps
local map = require("langmapper").map

local neominimap = require "neominimap"

-- stylua: ignore
local keymaps = {
  ["<leader>nm"] = { func = neominimap.toggle, desc = "minimap toggle global minimap" },
  ["<leader>nf"] = { func = neominimap.focus, desc = "minimap switch focus on minimap" },
  ["<leader>nr"] = { func = neominimap.refresh, desc = "minimap refresh global minimap" },
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
}

set_keymaps(map, keymaps)
