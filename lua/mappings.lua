-- vim:fileencoding=utf-8:foldmethod=marker
require "nvchad.mappings"

local map = require("langmapper").map

-- Format{{{

map({ "n", "v" }, "<leader>fm", function()
  if vim.fn.visualmode() ~= "" then
    vim.cmd "'<,'>ConformFormat"
  else
    vim.cmd "ConformFormat"
  end
end, { desc = "Format file or selected text" })

-- }}}
-- Split {{{

local split_toggle = false
local function toggle_split(direction)
  if split_toggle then
    vim.cmd "q"
    split_toggle = false
  else
    if direction == "v" then
      vim.cmd "vsplit"
    elseif direction == "h" then
      vim.cmd "split"
    end
    split_toggle = true
  end
end

map("n", "<D-h>", function()
  toggle_split "h"
end, { desc = "Toggle horizontal sptlt" })
map("n", "<D-v>", function()
  toggle_split "v"
end, { desc = "Toggle vertical sptlt" })

-- }}}
-- Tabufline {{{

map("n", "<C-[>", function()
  require("nvchad.tabufline").prev()
end, { desc = "Goto prev" })

map("n", "<C-]>", function()
  require("nvchad.tabufline").next()
end, { desc = "Goto next" })

-- }}}
-- Snapshot {{{

map("v", "<leader>sc", "<CMD>Silicon<CR>", { desc = "Snapshot code" })

-- }}}
