local set_keymaps = require("utils").set_keymaps
local map = require("langmapper").map

local persistence = require "persistence"

local function close_plugin(plugin_name, close_function)
  local status, plugin = pcall(require, plugin_name)
  if status and plugin[close_function] then
    plugin[close_function]()
  end
end

-- @param save_session boolean Indicates whether to save the session before quitting.
local function quit_all(save_session)
  close_plugin("aerial", "close_all")

  if not save_session then
    persistence.stop()
  end

  vim.schedule(function()
    vim.cmd "quitall"
  end)
end

-- stylua: ignore
local keymaps = {
  ["<leader>qs"] = { func = persistence.select, desc = "session select session" },
  ["<leader>qL"] = { func = persistence.load, desc = "session restore session" },
  ["<leader>ql"] = {
    func = function() persistence.load { last = true } end,
    desc = "session last session",
  },
  ["<leader>qq"] = {
    func = function() quit_all(true) end,
    desc = "session quit all",
  },
  ["<leader>qQ"] = {
    func = function() quit_all(false) end,
    desc = "session quit all without save session",
  },
}

set_keymaps(map, keymaps)
