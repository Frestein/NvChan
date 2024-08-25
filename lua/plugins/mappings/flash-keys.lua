local map = require("langmapper").map

local flash = require "flash"

map({ "n", "x", "o" }, "s", flash.jump, { desc = "flash jump" })
map({ "n", "x", "o" }, "S", flash.treesitter, { desc = "flash treesitter" })
map({ "x", "o" }, "R", flash.treesitter_search, { desc = "flash treesitter search" })
map("o", "r", flash.remote, { desc = "flash remote" })
map("c", "<c-s>", flash.toggle, { desc = "flash toggle flash search" })
