-- vim:fileencoding=utf-8:foldmethod=marker
require "nvchad.mappings"

local map = require("langmapper").map

-- Split {{{

local split_toggle = false
local function toggle_split(direction)
  if split_toggle then
    vim.cmd "close"
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

map("n", "<leader>h", function()
  toggle_split "h"
end, { desc = "split toggle horizontal " })
map("n", "<leader>v", function()
  toggle_split "v"
end, { desc = "split toggle vertical" })

-- }}}
-- Actions-preview {{{

map({ "n", "v" }, "<leader>tf", function()
  require("actions-preview").code_actions()
end, { desc = "LSP actions preview" })

-- }}}
-- Conform {{{

map({ "n", "v" }, "<leader>fm", function()
  require("conform").format()
end, { desc = "format file or selected text" })

-- }}}
-- Lazy {{{

local lazy = require "lazy"

map({ "n" }, "<leader>ll", function()
  lazy.home()
end, { desc = "lazy home" })

map({ "n" }, "<leader>lc", function()
  lazy.check()
end, { desc = "lazy check updates" })

map({ "n" }, "<leader>lu", function()
  lazy.update()
end, { desc = "lazy update" })

map({ "n" }, "<leader>ls", function()
  lazy.sync()
end, { desc = "lazy sync" })

-- }}}
-- Mason {{{

map({ "n" }, "<leader>mm", function()
  vim.cmd "Mason"
end, { desc = "mason home" })

map({ "n" }, "<leader>mi", function()
  vim.cmd "MasonInstallAll"
end, { desc = "mason update" })

map({ "n" }, "<leader>mu", function()
  vim.cmd "MasonUpdate"
end, { desc = "mason update" })

-- }}}
-- Noice {{{

local noice = require "noice"

map("n", "<leader>nd", function()
  noice.cmd "dismiss"
end, { desc = "noice dismiss all visible messages" })

map("n", "<leader>nl", function()
  noice.cmd "last"
end, { desc = "noice show the last message" })

map("n", "<leader>nh", function()
  noice.cmd "history"
end, { desc = "noice show the message history" })

map("n", "<leader>nt", function()
  noice.cmd "telescope"
end, { desc = "noice open message history in telescope" })

-- }}}
-- Neogit {{{

local neogit = require "neogit"

map("n", "<leader>ng", function()
  neogit.open()
end, { desc = "neogit open" })

map("n", "<leader>nl", function()
  neogit.open { "log" }
end, { desc = "neogit log" })

-- }}}
-- Neorg {{{

local neorg_callbacks = require "neorg.core.callbacks"

neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
  keybinds.map_event_to_mode("norg", {
    n = {
      { "<C-l>", "core.integrations.telescope.find_linkable" },
    },
  }, {
    silent = true,
    noremap = true,
  })
end)

-- }}}
-- Nvim-silicon {{{

map("v", "<leader>ss", function()
  require("nvim-silicon").shoot()
end, { desc = "snapshot code screenshot" })

map("v", "<leader>sf", function()
  require("nvim-silicon").file()
end, { desc = "snapshot code screenshot as file" })

map("v", "<leader>sc", function()
  require("nvim-silicon").clip()
end, { desc = "snapshot code screenshot to clipboard" })

-- }}}
-- Zen-mode {{{

map({ "n" }, "<leader>mz", function()
  require("zen-mode").toggle()
end, { desc = "zen-mode toggle zen-mode" })

-- }}}
