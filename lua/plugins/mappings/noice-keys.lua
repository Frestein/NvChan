local map = require("langmapper").map

local noice = require "noice"

map("n", "<leader>nd", function()
  noice.cmd "dismiss"
end, { desc = "notices dismiss all visible messages" })

map("n", "<leader>nl", function()
  noice.cmd "last"
end, { desc = "notices show the last message" })

map("n", "<leader>nh", function()
  noice.cmd "history"
end, { desc = "notices show the notice history" })
