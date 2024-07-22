-- This file  needs to have same structure as nvconfig.lua
---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "nord",
  theme_toggle = { "nord", "onedark" },

  statusline = {
    theme = "minimal",
    separator_style = "block",
  },

  cmp = {
    style = "flat_light",
  },

  telescope = {
    style = "bordered"
  },

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },

  border = {
    style = "rounded",
  },

  -- lsp = {
  --   signature = false,
  -- },
}

M.base46 = {
  integrations = {
    "notify",
    "neogit",
  },
}

return M
