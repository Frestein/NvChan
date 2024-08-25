local map = require("langmapper").map

local telescope = require "telescope"
local telescope_builtin = require "telescope.builtin"

map("n", "<leader>ff", telescope_builtin.find_files, { desc = "telescope find files" })
map("n", "<leader>fm", telescope_builtin.marks, { desc = "telescope find marks" })
map("n", "<leader>fw", telescope_builtin.live_grep, { desc = "telescope live grep" })
map("n", "<leader>fb", telescope_builtin.buffers, { desc = "telescope find buffers" })
map("n", "<leader>fh", telescope_builtin.help_tags, { desc = "telescope help page" })
map("n", "<leader>fo", telescope_builtin.oldfiles, { desc = "telescope find oldfiles" })
map("n", "<leader>fz", telescope_builtin.current_buffer_fuzzy_find, { desc = "telescope find in current buffer" })
map("n", "<leader>ftd", telescope_builtin.diagnostics, { desc = "telescope find diagnostics" })
map("n", "<leader>pt", telescope.extensions.terms.terms, { desc = "telescope pick hidden term" })
map("n", "<leader>th", telescope.extensions.themes.themes, { desc = "telescope nvchad themes" })
map("n", "<leader>fip", telescope.extensions.lazy.lazy, { desc = "telescope installed plugins" })
map("n", "<leader>fs", telescope.extensions.resession.resession, { desc = "telescope find sessions" })
map("n", "<leader>zl", telescope.extensions.zoxide.list, { desc = "telescope zoxide list" })
map("n", "<leader>fd", telescope.extensions.chezmoi.find_files, { desc = "telescope find dotfiles" })
map("n", "<leader>fp", telescope.extensions.project.project, { desc = "telescope find projects" })
map("n", "<leader>fn", telescope.extensions.noice.noice, { desc = "telescope find notices" })
map("n", "<leader>fu", telescope.extensions.undo.undo, { desc = "telescope find undo" })
