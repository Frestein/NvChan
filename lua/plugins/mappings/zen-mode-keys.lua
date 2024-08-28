local map = require("langmapper").map

local zen_mode = require "zen-mode"

map("n", "<leader>z", zen_mode.toggle, { desc = "toggle zen-mode" })
