-- This file  needs to have same structure as nvconfig.lua
---@type ChadrcConfig
local M = {}

M.ui = {
  statusline = {
    theme = "minimal",
    separator_style = "block",
  },

  cmp = {
    style = "flat_light",
  },

  telescope = {
    style = "bordered",
  },

  border = {
    style = "rounded",
  },

  -- lsp = {
  --   signature = false,
  -- },
}

M.base46 = {
  theme = "nord",
  theme_toggle = { "nord", "onedark" },

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },

  integrations = {
    "notify",
    "neogit",
  },

  transparency = false,
}

return M
