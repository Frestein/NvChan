local map = require("langmapper").map

local telescope = require "telescope"
local telescope_builtin = require "telescope.builtin"

map("n", "<leader>ff", telescope_builtin.find_files, { desc = "telescope find files" })
map("n", "<leader>fm", telescope_builtin.marks, { desc = "telescope find marks" })
map("n", "<leader>fw", telescope_builtin.live_grep, { desc = "telescope live grep" })
map("n", "<leader>fb", telescope_builtin.buffers, { desc = "telescope find buffers" })
map("n", "<leader>fH", telescope_builtin.help_tags, { desc = "telescope help page" })
map("n", "<leader>fo", telescope_builtin.oldfiles, { desc = "telescope find oldfiles" })
map("n", "<leader>fz", telescope_builtin.current_buffer_fuzzy_find, { desc = "telescope find in current buffer" })
map("n", "<leader>fd", telescope_builtin.diagnostics, { desc = "telescope find diagnostics" })
map("n", "<leader>ft", telescope.extensions.terms.terms, { desc = "telescope find terms" })
map("n", "<leader>th", telescope.extensions.themes.themes, { desc = "telescope nvchad themes" })
