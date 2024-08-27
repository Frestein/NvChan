local map = require("langmapper").map

map("n", "<leader>mm", function()
  vim.cmd "Mason"
end, { desc = "mason open home" })

map("n", "<leader>mu", function()
  vim.cmd "MasonUpdate"
end, { desc = "mason update packages" })
