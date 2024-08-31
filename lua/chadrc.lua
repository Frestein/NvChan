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
      trouble = function()
        return require("statusline").trouble()
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
      "trouble",
      "%=",
      "diagnostics",
      "lsp",
      "cwd",
      "cursor",
    },
  },

  cmp = {
    style = "atom",
    lspkind_text = false,
  },

  tabufline = {
    order = { "treeOffset", "buffers", "tabs" },
  },

  telescope = {
    style = "bordered",
  },

  border = {
    style = "rounded",
  },
}

M.base46 = {
  theme = "palenight",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    ["CmpPmenu"] = {
      bg = "darker_black",
    },
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
    "trouble",
    "todo",
  },

  transparency = false,
}

return M
