local map = require("langmapper").map

-- stylua: ignore
local keymaps = {
  ["<leader>tt"] = {
    func = "<cmd>TodoTrouble<cr>",
    desc = "todo-comments show the todo-list",
  },
  ["<leader>tq"] = {
    func = "<cmd>TodoQuickFix<cr>",
    desc = "todo-comments show quickfix",
  },
  ["<leader>fT"] = {
    func = "<cmd>TodoTelescope<cr>",
    desc = "telescope todo-list",
  },
}

local modes = { "n" }

for key, value in pairs(keymaps) do
  map(modes, key, value.func, { desc = value.desc })
end
