-- This file  needs to have same structure as nvconfig.lua
---@type ChadrcConfig
local M = {}

M.ui = {
  statusline = {
    theme = "minimal",
    separator_style = "block",
    modules = {
      navic_statusline = function()
        local navic = require "nvim-navic"

        if navic.is_available() then
          return navic.get_location()
        else
          return ""
        end
      end,
      lazy = function()
        local lazy_status = require "lazy.status"
        if lazy_status.has_updates() then
          return ("%#LazyUpdates#" .. " " .. lazy_status.updates() .. " ")
        else
          return ""
        end
      end,
    },
    order = {
      "mode",
      "file",
      "lazy",
      "git",
      "%=",
      "lsp_msg",
      "navic_statusline",
      "%=",
      "diagnostics",
      "lsp",
      "cwd",
      "cursor",
    },
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
    ["TbFill"] = {
      bg = "NONE",
    },
    ["TbBufOn"] = {
      bg = "NONE",
    },
    ["TbBufOnClose"] = {
      bg = "NONE",
    },
    ["TbBufOff"] = {
      bg = "NONE",
    },
    ["TbBufOffClose"] = {
      bg = "NONE",
    },
    ["NavicIconsColor"] = {
      bg = "NONE",
    },
    ["NavicIconsInterface"] = {
      bg = "NONE",
    },
    ["NavicIconsFile"] = {
      bg = "NONE",
    },
    ["NavicIconsClass"] = {
      bg = "NONE",
    },
    ["NavicIconsUnit"] = {
      bg = "NONE",
    },
    ["NavicIconsEnum"] = {
      bg = "NONE",
    },
    ["NavicIconsProperty"] = {
      bg = "NONE",
    },
    ["NavicIconsModule"] = {
      bg = "NONE",
    },
    ["NavicIconsFolder"] = {
      bg = "NONE",
    },
    ["NavicIconsConstructor"] = {
      bg = "NONE",
    },
    ["NavicIconsMethod"] = {
      bg = "NONE",
    },
    ["NavicIconsKeyword"] = {
      bg = "NONE",
    },
    ["NavicIconsType"] = {
      bg = "NONE",
    },
    ["NavicIconsStructure"] = {
      bg = "NONE",
    },
    ["NavicIconsText"] = {
      bg = "NONE",
    },
    ["NavicIconsSnippet"] = {
      bg = "NONE",
    },
    ["NavicIconsVariable"] = {
      bg = "NONE",
    },
    ["NavicIconsField"] = {
      bg = "NONE",
    },
    ["NavicIconsIdentifier"] = {
      bg = "NONE",
    },
    ["NavicIconsFunction"] = {
      bg = "NONE",
    },
    ["NavicIconsConstant"] = {
      bg = "NONE",
    },
    ["NavicSeparator"] = {
      bg = "NONE",
    },
    ["NavicText"] = {
      bg = "NONE",
    },
    ["NavicIconsNull"] = {
      bg = "NONE",
    },
    ["NavicIconsKey"] = {
      bg = "NONE",
    },
    ["NavicIconsObject"] = {
      bg = "NONE",
    },
    ["NavicIconsArray"] = {
      bg = "NONE",
    },
    ["NavicIconsBoolean"] = {
      bg = "NONE",
    },
    ["NavicIconsNumber"] = {
      bg = "NONE",
    },
    ["NavicIconsString"] = {
      bg = "NONE",
    },
    ["NavicIconsPackage"] = {
      bg = "NONE",
    },
    ["NavicIconsNamespace"] = {
      bg = "NONE",
    },
    ["NavicIconsTypeParameter"] = {
      bg = "NONE",
    },
    ["NavicIconsOperator"] = {
      bg = "NONE",
    },
    ["NavicIconsEvent"] = {
      bg = "NONE",
    },
    ["NavicIconsValue"] = {
      bg = "NONE",
    },
    ["NavicIconsStruct"] = {
      bg = "NONE",
    },
    ["NavicIconsEnumMember"] = {
      bg = "NONE",
    },
    ["NavicIconsReference"] = {
      bg = "NONE",
    },
  },

  hl_add = {
    ["LazyUpdates"] = {
      fg = "green",
      bg = "NONE",
    },
    ["WinBar"] = {
      fg = "light_grey",
      bg = "NONE",
    },
    ["WinBarNC"] = {
      fg = "light_grey",
      bg = "NONE",
    },
    ["StatusLineNC"] = {
      fg = "light_grey",
      bg = "black",
    },
    ["NvimTreeEndOfBuffer"] = {
      bg = "NONE",
    },
    ["NvimTreeWinSeparator"] = {
      bg = "NONE",
    },
  },

  integrations = {
    "notify",
    "neogit",
    "navic",
  },

  transparency = true,
}

return M
