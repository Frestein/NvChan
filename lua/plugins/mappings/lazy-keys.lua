local map = require("langmapper").map

local lazy = require "lazy"

-- stylua: ignore
local keymaps = {
  ["<leader>ll"] = {
    func = lazy.home,
    desc = "lazy open home",
  },
  ["<leader>lL"] = {
    func = lazy.log,
    desc = "lazy recent updates",
  },
  ["<leader>li"] = {
    func = lazy.install,
    desc = "lazy install missing plugins",
  },
  ["<leader>lc"] = {
    func = lazy.check,
    desc = "lazy check updates",
  },
  ["<leader>lu"] = {
    func = lazy.update,
    desc = "lazy update plugins",
  },
  ["<leader>ls"] = {
    func = lazy.sync,
    desc = "lazy sync plugins",
  },
  ["<leader>lh"] = {
    func = lazy.health,
    desc = "lazy open health",
  },
  ["<leader>lp"] = {
    func = lazy.profile,
    desc = "lazy open profile",
  },
}

local modes = { "n" }

for key, value in pairs(keymaps) do
  map(modes, key, value.func, { desc = value.desc })
end
