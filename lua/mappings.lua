require "plugins.mappings.lazy-keys"

-- Variables

local map = require("langmapper").map

local tabufline = require "nvchad.tabufline"

map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "General Clear highlights" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "General Save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "General Copy whole file" })

map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "Toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "Toggle relative number" })
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "Toggle nvcheatsheet" })

-- Movement

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "movement down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "movement down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "movement up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "movement up", expr = true, silent = true })

map({ "n", "o", "x" }, "<S-h>", "^", { desc = "movement jump to beginning of line" })
map({ "n", "o", "x" }, "<S-l>", "$", { desc = "movement jump to end of line" })

-- File

map("n", "<leader>cf", function()
  vim.fn.setreg("+", vim.fn.expand "%:t")
end, { desc = "file copy name" })

map("n", "<leader>cp", function()
  vim.fn.setreg("+", vim.fn.expand "%:p")
end, { desc = "file copy path" })

-- Split

-- split window
map("n", "<leader>h", function()
  vim.cmd "split"
end, { desc = "split horizontal " })

map("n", "<leader>v", function()
  vim.cmd "vsplit"
end, { desc = "split vertical" })

-- resize window
map("n", "<C-S-Down>", function()
  vim.cmd "resize +2"
end, { desc = "split resize horizontal down" })

map("n", "<C-S-Up>", function()
  vim.cmd "resize -2"
end, { desc = "split resize horizontal up" })

map("n", "<C-S-Left>", function()
  vim.cmd "vertical resize -2"
end, { desc = "split resize vertical down" })

map("n", "<C-S-Right>", function()
  vim.cmd "vertical resize +2"
end, { desc = "split resize vertical up" })

-- Code

-- stay in indent mode
map("v", "<", "<gv", { desc = "code block left" })
map("v", ">", ">gv", { desc = "code block right" })

-- move block
map("v", "<C-j>", ":m '>+1<CR>gv", { desc = "code block down", silent = true })
map("v", "<C-k>", ":m '<-2<CR>gv", { desc = "code block up", silent = true })

-- comment
map("n", "<leader>/", "gcc", { desc = "Toggle Comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

-- global lsp mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP Diagnostic loclist" })

-- Tabufline

map("n", "[b", function()
  tabufline.prev()
end, { desc = "buffer goto prev" })

map("n", "]b", function()
  tabufline.next()
end, { desc = "buffer goto next" })

map("n", "[t", function()
  vim.cmd "tabprev"
end, { desc = "tabufline previous tab" })

map("n", "]t", function()
  vim.cmd "tabnext"
end, { desc = "tabufline next tab" })

map("n", "<leader>^", function()
  vim.cmd "tabfirst"
end, { desc = "tabufline first tab" })

map("n", "<leader>$", function()
  vim.cmd "tablast"
end, { desc = "tabufline last tab" })

map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })

map("n", "<tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<S-tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("n", "<leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

-- Terminal

-- escape terminal mode
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- new terminals
map("n", "<leader>h", function()
  require("nvchad.term").new { pos = "sp" }
end, { desc = "terminal new horizontal term" })

map("n", "<leader>v", function()
  require("nvchad.term").new { pos = "vsp" }
end, { desc = "terminal new vertical window" })

-- toggleable
map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal new horizontal term" })

map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

-- blankline
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
