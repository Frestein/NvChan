-- vim:fileencoding=utf-8:foldmethod=marker
require "plugins.mappings.lazy-keys"

local map = require("langmapper").map

local tabufline = require "nvchad.tabufline"
local term = require "nvchad.term"

map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "general nvcheatsheet" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "general toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "general toggle relative number" })

map({ "n", "i" }, "<F11>", "<cmd>set spell!<CR>", { desc = "general toggle spell check" })

-- Motion {{{

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "motion down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "motion down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "motion up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "motion up", expr = true, silent = true })

map({ "n", "o", "x" }, "<S-h>", "^", { desc = "motion jump to beginning of line" })
map({ "n", "o", "x" }, "<S-l>", "$", { desc = "motion jump to end of line" })

map("i", "<C-b>", "<ESC>^i", { desc = "motion beginning of line" })
map("i", "<C-e>", "<End>", { desc = "motion end of line" })
map("i", "<C-h>", "<Left>", { desc = "motion left" })
map("i", "<C-l>", "<Right>", { desc = "motion right" })
map("i", "<C-j>", "<Down>", { desc = "motion down" })
map("i", "<C-k>", "<Up>", { desc = "motion up" })

-- }}}
-- File {{{

map("n", "<C-s>", "<cmd>w<CR>", { desc = "file save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "file copy whole file" })

map("n", "<leader>cf", function()
  vim.fn.setreg("+", vim.fn.expand "%:t")
end, { desc = "file copy name" })

map("n", "<leader>cp", function()
  vim.fn.setreg("+", vim.fn.expand "%:p")
end, { desc = "file copy path" })

-- }}}
-- Split {{{

map("n", "<leader>h", "<cmd>split<CR>", { desc = "split horizontal" })
map("n", "<leader>v", "<cmd>vsplit<CR>", { desc = "split vertical" })

-- }}}
-- Code {{{

map("n", "<leader>/", "gcc", { desc = "code toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "code toggle comment", remap = true })

-- }}}
-- Tabufline {{{

map("n", "<S-tab>", tabufline.prev, { desc = "buffer goto prev buffer" })
map("n", "<tab>", tabufline.next, { desc = "buffer goto next buffer" })

map("n", "<A-Left>", function()
  tabufline.move_buf(-1)
end, { desc = "buffer move to left" })

map("n", "<A-Right>", function()
  tabufline.move_buf(1)
end, { desc = "buffer move to right" })

map("n", "<leader>$", "<cmd>tablast<CR>", { desc = "tab last tab" })
map("n", "<leader>^", "<cmd>tabfirst<CR>", { desc = "tab first tab" })

-- }}}
-- Terminal {{{

map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- map("n", "<leader>th", function()
--   term.new { pos = "sp" }
-- end, { desc = "terminal new horizontal term" })
--
-- map("n", "<leader>tv", function()
--   term.new { pos = "vsp" }
-- end, { desc = "terminal new vertical window" })

map({ "n", "t" }, "<leader><M-v>", function()
  term.toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggle vertical term" })

map({ "n", "t" }, "<leader><M-h>", function()
  term.toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggle horizontal term" })

map({ "n", "t" }, "<leader><M-i>", function()
  term.toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

-- }}}
-- WhichKey {{{

map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

-- }}}
-- Blankline {{{

map("n", "<leader>cc", function()
  local config = { scope = {} }
  config.scope.exclude = { language = {}, node_type = {} }
  config.scope.include = { node_type = {} }
  local node = require("ibl.scope").get(vim.api.nvim_get_current_buf(), config)

  if node then
    local start_row, _, end_row, _ = node:range()
    if start_row ~= end_row then
      vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start_row + 1, 0 })
      vim.api.nvim_feedkeys("_", "n", true)
    end
  end
end, { desc = "blankline jump to current context" })

-- }}}
