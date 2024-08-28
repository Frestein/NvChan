local map = require("langmapper").map

map("n", "<leader>td", function()
  vim.cmd "Trouble diagnostics toggle"
end, { desc = "toggle diagnostics" })
