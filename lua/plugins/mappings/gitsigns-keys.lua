local set_keymaps = require("utils").set_keymaps
local map = require("langmapper").map

local gitsigns = package.loaded.gitsigns
local telescope_builtin = require "telescope.builtin"

local M = {}

M.on_attach = function(bufnr)
  local keymaps = {
    ["<leader>grh"] = { func = gitsigns.reset_hunk, desc = "gitsigns reset hunk" },
    ["<leader>gph"] = { func = gitsigns.preview_hunk, desc = "gitsigns preview hunk" },
    ["<leader>gb"] = { func = gitsigns.blame_line, desc = "gitsigns blame line" },
    ["<leader>gtb"] = { func = gitsigns.toggle_current_line_blame, desc = "gitsigns toggle blame line" },
    ["<leader>gtd"] = { func = gitsigns.toggle_deleted, desc = "gitsigns toggle deleted" },
    ["<leader>gtn"] = { func = gitsigns.toggle_numhl, desc = "gitsigns toggle number highlight" },
    ["<leader>gc"] = { func = telescope_builtin.git_commits, desc = "telescope git commits" },
    ["<leader>gs"] = { func = telescope_builtin.git_status, desc = "telescope git status" },
  }

  for _, keymap in pairs(keymaps) do
    keymap.modes = { "n" }
  end

  set_keymaps(map, keymaps, bufnr)
end

return M
