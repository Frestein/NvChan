local map = require("langmapper").map

local persistence = require "persistence"

map("n", "<leader>qS", persistence.select, { desc = "session select session" })
map("n", "<leader>qs", persistence.load, { desc = "session restore session" })
map("n", "<leader>ql", function()
  persistence.load { last = true }
end, { desc = "session last session" })
map("n", "<leader>qd", persistence.stop, { desc = "session don't save current session" })
