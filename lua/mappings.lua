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

map({ "n", "v" }, "<leader>tf", require("actions-preview").code_actions, { desc = "LSP actions preview" })

-- }}}
-- Conform {{{

map({ "n", "v" }, "<leader>fm", function()
  require("conform").format()
end, { desc = "format file or selected text" })

-- }}}
-- Lazy {{{

local lazy = require "lazy"
local lazy_toggle = false

local function toggle_lazy(direction)
  if lazy_toggle then
    vim.cmd "close"
    lazy_toggle = false
  else
    if direction == "home" then
      lazy.home()
    elseif direction == "check" then
      lazy.check()
    elseif direction == "update" then
      lazy.update()
    elseif direction == "sync" then
      lazy.sync()
    end
    lazy_toggle = true
  end
end

map({ "n" }, "<leader>ll", function()
  toggle_lazy "home"
end, { desc = "lazy home" })

map({ "n" }, "<leader>lc", function()
  toggle_lazy "check"
end, { desc = "lazy check updates" })

map({ "n" }, "<leader>lu", function()
  toggle_lazy "update"
end, { desc = "lazy update" })

map({ "n" }, "<leader>ls", function()
  toggle_lazy "sync"
end, { desc = "lazy sync" })

-- }}}
-- Mason {{{

local mason_toggle = false

local function toggle_mason(direction)
  if mason_toggle then
    vim.cmd "close"
    mason_toggle = false
  else
    if direction == "home" then
      vim.cmd "Mason"
      mason_toggle = true
    elseif direction == "install_all" then
      vim.cmd "MasonInstallAll"
      mason_toggle = true
    elseif direction == "update" then
      vim.cmd "MasonUpdate"
    end
  end
end

map({ "n" }, "<leader>mm", function()
  toggle_mason "home"
end, { desc = "mason home" })
map({ "n" }, "<leader>mi", function()
  toggle_mason "install_all"
end, { desc = "mason update" })
map({ "n" }, "<leader>mu", function()
  toggle_mason "update"
end, { desc = "mason update" })

-- }}}
-- Noice {{{

local noice = require "noice"

map("n", "<leader>nd", function()
  noice.cmd("dismiss")
end, { desc = "noice dismiss all visible messages" })
map("n", "<leader>nl", function()
  noice.cmd("last")
end, { desc = "noice show the last message" })
map("n", "<leader>nh", function()
  noice.cmd("history")
end, { desc = "noice show the message history" })
map("n", "<leader>nt", function()
  noice.cmd("telescope")
end, { desc = "noice open message history in telescope" })

-- }}}
-- Neogit {{{

local neogit = require "neogit"

map("n", "<leader>ng", function()
  neogit.open()
end, { desc = "neogit open neogit" })
map("n", "<leader>nl", function()
  neogit.open({ "log" })
end, { desc = "neogit open neogit log" })

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
