require "nvchad.mappings"

local map = require("langmapper").map
local telescope = require "telescope"
local actions_preview = require "actions-preview"
local conform = require "conform"
local lazy = require "lazy"
local oil = require "oil"
local noice = require "noice"
local neogit = require "neogit"
local resession = require "resession"
local nvim_silicon = require "nvim-silicon"
local zen_mode = require "zen-mode"
local neorg_callbacks = require "neorg.core.callbacks"

-- nvimtree
vim.keymap.del("n", "<leader>e")
vim.keymap.del("n", "<C-n>")

-- oil
vim.keymap.del("n", "<leader>fl")

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
end, { desc = "split horizontal " })

map("n", "<leader>v", function()
  vim.cmd "vsplit"
end, { desc = "split vertical" })

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
-- Tabufline {{{

map("n", "<C-S-[>", function()
  vim.cmd "tabprev"
end, { desc = "Tabufline previous tab" })

map("n", "<C-S-]>", function()
  vim.cmd "tabnext"
end, { desc = "Tabufline next tab" })

map("n", "<leader>^", function()
  vim.cmd "tabfirst"
end, { desc = "Tabufline first tab" })

map("n", "<leader>$", function()
  vim.cmd "tablast"
end, { desc = "Tabufline last tab" })

-- }}}
-- Oil {{{

map("n", "<leader>e", oil.open, { desc = "Oil Open parent directory" })

-- }}}
-- Actions-preview {{{

map({ "n", "v" }, "<leader>ta", function()
  actions_preview.code_actions()
end, { desc = "LSP actions preview" })

-- }}}
-- Conform {{{

map({ "n", "v" }, "<leader>fm", function()
  conform.format()
end, { desc = "format file or selected text" })

-- }}}
-- Lazy {{{

map("n", "<leader>ll", lazy.home, { desc = "lazy home" })
map("n", "<leader>llp", lazy.log, { desc = "lazy recent updates" })
map("n", "<leader>li", lazy.install, { desc = "lazy install missing plugins" })
map("n", "<leader>lc", lazy.check, { desc = "lazy check updates" })
map("n", "<leader>lu", lazy.update, { desc = "lazy update plugins" })
map("n", "<leader>ls", lazy.sync, { desc = "lazy sync plugins" })
map("n", "<leader>lh", lazy.health, { desc = "lazy health" })
map("n", "<leader>lp", lazy.profile, { desc = "lazy profile" })

map("n", "<leader>tlp", function()
  vim.cmd "Telescope lazy"
end, { desc = "lazy view installed plugins" })

-- }}}
-- Mason {{{

map("n", "<leader>mm", function()
  vim.cmd "Mason"
end, { desc = "mason home" })

map("n", "<leader>mi", function()
  vim.cmd "MasonInstallAll"
end, { desc = "mason install all" })

map("n", "<leader>mu", function()
  vim.cmd "MasonUpdate"
end, { desc = "mason update" })

-- }}}
-- Noice {{{

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

map("n", "<leader>gg", neogit.open, { desc = "neogit open" })

map("n", "<leader>gl", function()
  neogit.open { "log" }
end, { desc = "neogit log" })

-- }}}
-- Neorg {{{

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

map("v", "<leader>ss", nvim_silicon.shoot, { desc = "snapshot code screenshot" })
map("v", "<leader>sf", nvim_silicon.file, { desc = "snapshot code screenshot as file" })
map("v", "<leader>sc", nvim_silicon.clip, { desc = "snapshot code screenshot to clipboard" })

-- }}}
-- Zen-mode {{{

map({ "n" }, "<leader>mz", zen_mode.toggle, { desc = "toggle zen-mode" })

-- }}}
-- Project {{{

map("n", "<leader>tp", telescope.extensions.project.project, { desc = "telescope open project" })

-- }}}
-- Resession {{{

map("n", "<leader>ss", resession.save, { desc = "ression save session" })
map("n", "<leader>sl", resession.load, { desc = "ression load session" })
map("n", "<leader>sd", resession.delete, { desc = "ression delete session" })
map("n", "<leader>st", telescope.extensions.resession.resession, { desc = "ression telescope" })

-- }}}
-- Zoxide {{{

map("n", "<leader>zl", telescope.extensions.zoxide.list, { desc = "zoxide list" })

-- }}}
-- vim:fileencoding=utf-8:foldmethod=marker
