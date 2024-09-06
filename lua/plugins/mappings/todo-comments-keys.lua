local set_keymaps = require("utils").set_keymaps
local map = require("langmapper").map

local keymaps = {
  ["<leader>tt"] = { func = "<cmd>TodoTrouble<cr>", desc = "todo-comments show the todo-list" },
  ["<leader>tq"] = { func = "<cmd>TodoQuickFix<cr>", desc = "todo-comments show quickfix" },
  ["<leader>fT"] = { func = "<cmd>TodoTelescope<cr>", desc = "telescope todo-list" },
}

set_keymaps(map, keymaps)
