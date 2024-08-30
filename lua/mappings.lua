-- vim:fileencoding=utf-8:foldmethod=marker
require "plugins.mappings.lazy-keys"

local map = require("langmapper").map

local tabufline = require "nvchad.tabufline"
local term = require "nvchad.term"

vim.g.maplocalleader = "\\"

map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "general nvcheatsheet" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "general toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "general toggle relative number" })

map("n", "<leader>qq", function()
  if vim.fn.exists ":Neominimap" == 2 then
    vim.cmd "Neominimap off"

    if vim.fn.exists ":AerialCloseAll" == 2 then
      vim.cmd "AerialCloseAll"
    end

    vim.defer_fn(function()
      vim.cmd "quitall"
    end, 1)
  else
    if vim.fn.exists ":AerialCloseAll" == 2 then
      vim.cmd "AerialCloseAll"
    end

    vim.cmd "quitall"
  end
end, { desc = "general quit all" })

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

map("n", "<C-S-Down>", "<cmd>resize +2<CR>", { desc = "split resize horizontal down" })
map("n", "<C-S-Up>", "<cmd>resize -2<CR>", { desc = "split resize horizontal up" })
map("n", "<C-S-Left>", "<cmd>vertical resize -2<CR>", { desc = "split resize vertical down" })
map("n", "<C-S-Right>", "<cmd>vertical resize +2<CR>", { desc = "split resize vertical up" })

map("n", "<C-h>", "<C-w>h", { desc = "split switch window left" })
map("n", "<C-j>", "<C-w>j", { desc = "split switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "split switch window up" })
map("n", "<C-l>", "<C-w>l", { desc = "split switch window right" })

-- }}}
-- Code {{{

-- stay in indent mode
map("v", "<", "<gv", { desc = "code block left" })
map("v", ">", ">gv", { desc = "code block right" })

-- move block
map("v", "<C-j>", ":m '>+1<CR>gv", { desc = "code block down", silent = true })
map("v", "<C-k>", ":m '<-2<CR>gv", { desc = "code block up", silent = true })

map("n", "<leader>/", "gcc", { desc = "code toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "code toggle comment", remap = true })

-- }}}
-- Tabufline {{{

map("n", "<leader>x", tabufline.close_buffer, { desc = "tabufline close buffer" })
map("n", "[b", tabufline.prev, { desc = "tabufline goto prev buffer" })
map("n", "]b", tabufline.next, { desc = "tabufline goto next buffer" })
map("n", "<S-tab>", tabufline.prev, { desc = "tabufline goto prev buffer" })
map("n", "<tab>", tabufline.next, { desc = "tabufline goto next buffer" })

map("n", "[t", "<cmd>tabprev<CR>", { desc = "tabufline previous tab" })
map("n", "]t", "<cmd>tabnext<CR>", { desc = "tabufline next tab" })
map("n", "<leader>$", "<cmd>tablast<CR>", { desc = "tabufline last tab" })
map("n", "<leader>^", "<cmd>tabfirst<CR>", { desc = "tabufline first tab" })
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "tabufline new buffer" })

-- }}}
-- Terminal {{{

map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

map("n", "<leader>th", function()
  term.new { pos = "sp" }
end, { desc = "terminal new horizontal term" })

map("n", "<leader>tv", function()
  term.new { pos = "vsp" }
end, { desc = "terminal new vertical window" })

map({ "n", "t" }, "<A-v>", function()
  term.toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggle vertical term" })

map({ "n", "t" }, "<A-h>", function()
  term.toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggle horizontal term" })

map({ "n", "t" }, "<A-i>", function()
  term.toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

-- }}}
-- LSP {{{

map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "lsp diagnostic loclist" })

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
