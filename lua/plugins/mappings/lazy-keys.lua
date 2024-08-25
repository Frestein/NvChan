local map = require("langmapper").map

local lazy = require "lazy"

map("n", "<leader>ll", lazy.home, { desc = "lazy open home" })
map("n", "<leader>llp", lazy.log, { desc = "lazy recent updates" })
map("n", "<leader>li", lazy.install, { desc = "lazy install missing plugins" })
map("n", "<leader>lc", lazy.check, { desc = "lazy check updates" })
map("n", "<leader>lu", lazy.update, { desc = "lazy update plugins" })
map("n", "<leader>ls", lazy.sync, { desc = "lazy sync plugins" })
map("n", "<leader>lh", lazy.health, { desc = "lazy open health" })
map("n", "<leader>lp", lazy.profile, { desc = "lazy open profile" })
