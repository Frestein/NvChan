local map = require("langmapper").map

local persistence = require "persistence"

-- stylua: ignore
local keymaps = {
  ["<leader>qS"] = {
    func = persistence.select,
    desc = "session select session",
  },
  ["<leader>qs"] = {
    func = persistence.load,
    desc = "session restore session",
  },
  ["<leader>ql"] = {
    func = function() persistence.load { last = true } end,
    desc = "session last session",
  },
  ["<leader>qd"] = {
    func = persistence.stop,
    desc = "session don't save current session",
  },
}

local modes = { "n" }

for key, value in pairs(keymaps) do
  map(modes, key, value.func, { desc = value.desc })
end
