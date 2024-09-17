local set_keymaps = require("utils").set_keymaps
local map = require("langmapper").map

local smart_splits = require "smart-splits"

local keymaps = {
  ["<C-S-Left>"] = {
    func = smart_splits.resize_left,
    desc = "split resize left",
  },
  ["<C-S-Down>"] = {
    func = smart_splits.resize_down,
    desc = "split resize down",
  },
  ["<C-S-Up>"] = {
    func = smart_splits.resize_up,
    desc = "split resize up",
  },
  ["<C-S-Right>"] = {
    func = smart_splits.resize_right,
    desc = "split resize right",
  },
  ["<C-h>"] = {
    func = smart_splits.move_cursor_left,
    desc = "split move cursor left",
  },
  ["<C-j>"] = {
    func = smart_splits.move_cursor_down,
    desc = "split move cursor down",
  },
  ["<C-k>"] = {
    func = smart_splits.move_cursor_up,
    desc = "split move cursor up",
  },
  ["<C-l>"] = {
    func = smart_splits.move_cursor_right,
    desc = "split move cursor right",
  },
  ["<C-\\>"] = {
    func = smart_splits.move_cursor_previous,
    desc = "split move cursor previous",
  },
  ["<leader><leader>h"] = {
    func = smart_splits.swap_buf_left,
    desc = "split swap buffer left",
  },
  ["<leader><leader>j"] = {
    func = smart_splits.swap_buf_down,
    desc = "split swap buffer down",
  },
  ["<leader><leader>k"] = {
    func = smart_splits.swap_buf_up,
    desc = "split swap buffer up",
  },
  ["<leader><leader>l"] = {
    func = smart_splits.swap_buf_right,
    desc = "split swap buffer right",
  },
}

set_keymaps(map, keymaps)
