local set_keymaps = require("utils").set_keymaps
local map = require("langmapper").map

local flash = require "flash"

local keymaps = {
  ["s"] = {
    modes = { "n", "x", "o" },
    func = flash.jump,
    desc = "flash jump",
  },
  ["S"] = {
    modes = { "n", "x", "o" },
    func = flash.treesitter,
    desc = "flash treesitter",
  },
  ["R"] = {
    modes = { "x", "o" },
    func = flash.treesitter_search,
    desc = "flash treesitter search",
  },
  ["r"] = {
    modes = { "o" },
    func = flash.remote,
    desc = "flash remote",
  },
  ["<c-s>"] = {
    modes = { "c" },
    func = flash.toggle,
    desc = "flash toggle flash search",
  },
}

set_keymaps(map, keymaps)
