-- vim:fileencoding=utf-8:foldmethod=marker
require "nvchad.mappings"

local map = vim.keymap.set

-- file {{{

map("n", "<leader>sh", ":vsplit<CR>", { desc = "Vertical sptlt" })
map("n", "<leader>sv", ":split<CR>", { desc = "Horizontal sptlt" })
map("n", "<leader>cw", ":close<CR>", { desc = "Close window" })

-- }}}
-- tabufline {{{

map("n", "<C-]>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<C-[>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

-- }}}
-- snapshot {{{

map("v", "<leader>sc", ":Silicon<CR>", { desc = "Snapshot code" })

-- }}}
