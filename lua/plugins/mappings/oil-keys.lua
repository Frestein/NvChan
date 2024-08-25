local map = require("langmapper").map

local oil = require "oil"

map("n", "<leader>e", oil.open, { desc = "file open parent directory" })
map("n", "<leader>fl", oil.toggle_float, { desc = "file open parent directory (float)" })
