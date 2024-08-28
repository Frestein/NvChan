local map = require("langmapper").map

map("n", "<leader>tt", function()
  vim.cmd "TodoTrouble"
end, { desc = "todo-comments show the todo-list" })

map("n", "<leader>fT", function()
  vim.cmd "TodoTelescope"
end, { desc = "telescope todo-list" })
