-- vim:fileencoding=utf-8:foldmethod=marker
---@type ChadrcConfig
local M = {}

M.ui = {
  nvdash = {
    header = {
      "⡆⣿⣿⣦⠹⣳⣳⣕⢅⠈⢗⢕⢕⢕⢕⢕⢈⢆⠟⠋⠉⠁⠉⠉⠁⠈⠼⢐⢕",
      "⡗⢰⣶⣶⣦⣝⢝⢕⢕⠅⡆⢕⢕⢕⢕⢕⣴⠏⣠⡶⠛⡉⡉⡛⢶⣦⡀⠐⣕",
      "⡝⡄⢻⢟⣿⣿⣷⣕⣕⣅⣿⣔⣕⣵⣵⣿⣿⢠⣿⢠⣮⡈⣌⠨⠅⠹⣷⡀⢱",
      "⡝⡵⠟⠈⢀⣀⣀⡀⠉⢿⣿⣿⣿⣿⣿⣿⣿⣼⣿⢈⡋⠴⢿⡟⣡⡇⣿⡇⡀",
      "⡝⠁⣠⣾⠟⡉⡉⡉⠻⣦⣻⣿⣿⣿⣿⣿⣿⣿⣿⣧⠸⣿⣦⣥⣿⡇⡿⣰⢗",
      "⠁⢰⣿⡏⣴⣌⠈⣌⠡⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣬⣉⣉⣁⣄⢖⢕⢕",
      "⡀⢻⣿⡇⢙⠁⠴⢿⡟⣡⡆⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣵⣵",
      "⡻⣄⣻⣿⣌⠘⢿⣷⣥⣿⠇⣿⣿⣿⣿⣿⣿⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      "⣷⢄⠻⣿⣟⠿⠦⠍⠉⣡⣾⣿⣿⣿⣿⣿⣿⢸⣿⣦⠙⣿⣿⣿⣿⣿⣿⣿⣿",
      "⡕⡑⣑⣈⣻⢗⢟⢞⢝⣻⣿⣿⣿⣿⣿⣿⣿⠸⣿⠿⠃⣿⣿⣿⣿⣿⣿⡿⠁",
      "",
      "Hello, master!",
    },
    load_on_startup = true,
  },

  statusline = {
    theme = "minimal",
    separator_style = "block",
    modules = {
      navic = function()
        return require("statusline").navic()
      end,
      lazy = function()
        return require("statusline").lazy()
      end,
    },
    order = {
      "mode",
      "file",
      "lazy",
      "git",
      "%=",
      "lsp_msg",
      "navic",
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
}

M.base46 = {
  theme = "nord",
  theme_toggle = { "nord", "onedark" },

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    -- Tabufline {{{
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
    -- }}}
    -- Navic {{{
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
    -- }}}
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
    -- Symbol-Usage {{{
    ["SymbolUsageRounding"] = {
      fg = "one_bg",
      italic = true,
    },
    ["SymbolUsageContent"] = {
      bg = "one_bg",
      fg = "grey_fg",
      italic = true,
    },
    ["SymbolUsageRef"] = {
      fg = "nord_blue",
      bg = "one_bg",
      italic = true,
    },
    ["SymbolUsageDef"] = {
      fg = "dark_purple",
      bg = "one_bg",
      italic = true,
    },
    ["SymbolUsageImpl"] = {
      fg = "yellow",
      bg = "one_bg",
      italic = true,
    },
    -- }}}
  },

  integrations = {
    "notify",
    "neogit",
    "navic",
  },

  transparency = true,
}

return M
