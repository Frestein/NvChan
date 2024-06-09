-- vim:fileencoding=utf-8:foldmethod=marker
require "nvchad.mappings"

local map = require("langmapper").map

-- LSP {{{

map({ "n", "v" }, "<leader>tf", require("actions-preview").code_actions, { desc = "LSP actions preview" })

-- }}}
-- Format {{{

map({ "n", "v" }, "<leader>fm", function()
  require("conform").format()
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
-- Neogit {{{

map("n", "<leader>ng", "<CMD>Neogit<CR>", { desc = "Neogit open" })

-- }}}
-- Snapshot {{{

map("v", "<leader>ss", function()
  require("nvim-silicon").shoot()
end, { desc = "Snapshot code screenshot" })
map("v", "<leader>sf", function()
  require("nvim-silicon").file()
end, { desc = "Snapshot code screenshot as file" })
map("v", "<leader>sc", function()
  require("nvim-silicon").clip()
end, { desc = "Snapshot code screenshot to clipboard" })

-- }}}
