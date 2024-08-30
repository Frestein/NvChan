local map = require("langmapper").map

local grug_far = require "grug-far"

-- stylua: ignore
local keymaps = {
  ["<leader>rw"] = {
    modes = { "n" },
    func = function() grug_far.open { prefills = { search = vim.fn.expand "<cword>" } } end,
    desc = "grug-far open with word under cursor",
  },
  ["<leader>rс"] = {
    modes = { "n" },
    func = function() grug_far.open { prefills = { paths = vim.fn.expand "%" } } end,
    desc = "grug-far open for current file",
  },
  ["<leader>rC"] = {
    modes = { "x" },
    func = function() grug_far.with_visual_selection { prefills = { paths = vim.fn.expand "%" } } end,
    desc = "grug-far open with visual selection",
  },
}

for key, value in pairs(keymaps) do
  map(value.modes, key, value.func, { desc = value.desc })
end
