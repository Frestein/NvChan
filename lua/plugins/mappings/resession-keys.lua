local map = require("langmapper").map

local resession = require "resession"

map("n", "<leader>rs", resession.save, { desc = "session save session" })
map("n", "<leader>rl", resession.load, { desc = "session load session" })
map("n", "<leader>rd", resession.delete, { desc = "session delete session" })
