local map = require("langmapper").map

map("n", "<leader>mm", function()
  vim.cmd "Mason"
end, { desc = "mason open home" })

map("n", "<leader>mi", function()
  vim.cmd "MasonInstallAll"
end, { desc = "mason install all packages" })

map("n", "<leader>mu", function()
  vim.cmd "MasonUpdate"
end, { desc = "mason update packages" })
