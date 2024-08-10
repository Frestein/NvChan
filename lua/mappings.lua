-- vim:fileencoding=utf-8:foldmethod=marker
require "nvchad.mappings"

local map = require("langmapper").map

-- File {{{

map("n", "<leader>cf", function()
  vim.fn.setreg("+", vim.fn.expand "%:t")
end, { desc = "file copy name" })

map("n", "<leader>cp", function()
  vim.fn.setreg("+", vim.fn.expand "%:p")
end, { desc = "file copy path" })

-- }}}
-- Split {{{

-- Split window
map("n", "<leader>h", function()
  vim.cmd "split"
end, { desc = "split toggle horizontal " })

map("n", "<leader>v", function()
  vim.cmd "vsplit"
end, { desc = "split toggle vertical" })

-- Resize split window
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

map({ "n" }, "<leader>lt", function()
  vim.cmd "Telescope lazy"
end, { desc = "lazy telescope" })

-- }}}
-- Mason {{{

map({ "n" }, "<leader>mm", function()
  vim.cmd "Mason"
end, { desc = "mason home" })

map({ "n" }, "<leader>mi", function()
  vim.cmd "MasonInstallAll"
end, { desc = "mason install all" })

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
