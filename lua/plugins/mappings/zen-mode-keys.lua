local map = require("langmapper").map

local zen_mode = require "zen-mode"

map({ "n" }, "<leader>mz", zen_mode.toggle, { desc = "toggle zen-mode" })
