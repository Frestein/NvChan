-- This file  needs to have same structure as nvconfig.lua
---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "nord",
  theme_toggle = { "nord", "onedark" },

  statusline = {
    theme = "default",
    separator_style = "block",
  },

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },

M.base46 = {
  integrations = {
    "notify",
    "neogit",
  }
}

return M
