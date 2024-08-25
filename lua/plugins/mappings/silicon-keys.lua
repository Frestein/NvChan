local map = require("langmapper").map

local silicon = require "nvim-silicon"

map("v", "<leader>ss", silicon.shoot, { desc = "snapshot screenshot code" })
map("v", "<leader>sf", silicon.file, { desc = "snapshot screenshot code as file" })
map("v", "<leader>sc", silicon.clip, { desc = "snapshot screenshot code to clipboard" })
