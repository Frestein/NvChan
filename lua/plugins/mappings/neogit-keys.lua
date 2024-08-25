local map = require("langmapper").map

local neogit = require "neogit"

map("n", "<leader>gg", neogit.open, { desc = "neogit open" })

map("n", "<leader>gl", function()
  neogit.open { "log" }
end, { desc = "neogit log" })
