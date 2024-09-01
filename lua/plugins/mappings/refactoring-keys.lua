local map = require("langmapper").map

local refactoring = require "refactoring"

-- stylua: ignore
local keymaps = {
  ["<leader>re"] = {
    modes = { "x" },
    func = function() refactoring.refactor('Extract Function') end,
    desc = "refactor extract function",
  },
  ["<leader>rf"] = {
    modes = { "x" },
    func = function() refactoring.refactor('Extract Function To File') end,
    desc = "refactor extract function to file",
  },
  ["<leader>rv"] = {
    modes = { "x" },
    func = function() refactoring.refactor('Extract Variable') end,
    desc = "refactor extract variable",
  },
  ["<leader>rI"] = {
    modes = { "n" },
    func = function() refactoring.refactor('Inline Function') end,
    desc = "refactor inline function",
  },
  ["<leader>ri"] = {
    modes = { "n", "x" },
    func = function() refactoring.refactor('Inline Variable') end,
    desc = "refactor inline variable",
  },
  ["<leader>rb"] = {
    modes = { "n" },
    func = function() refactoring.refactor('Extract Block') end,
    desc = "refactor extract block",
  },
  ["<leader>rB"] = {
    modes = { "n" },
    func = function() refactoring.refactor('Extract Block To File') end,
    desc = "refactor extract block to file",
  },
  ["<leader>rr"] = {
    modes = { "n", "x" },
    func = refactoring.select_refactor,
    desc = "refactor select refactor",
  },
}

for key, value in pairs(keymaps) do
  map(value.modes, key, value.func, { desc = value.desc })
end
