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
    -- stylua: ignore
    buttons = {
      { "  Select Session", "Spc q s", function() require("persistence").select() end },
      { "  Find File", "Spc f f", "Telescope find_files" },
      { "  Find Project", "Spc f p", "Telescope project" },
      { "󱐁  Zoxide List", "Spc f Z", "Telescope zoxide list" },
      { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "  Bookmarks", "Spc f m", "Telescope marks" },
      { "  Themes", "Spc t H", "Telescope themes" },
      { "  Mappings", "Spc c h", "NvCheatsheet" },
    },
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
    --- @diagnostic disable-next-line: assign-type-mismatch
    style = "nvchan_colored",
    lspkind_text = false,
  },

  tabufline = { order = { "treeOffset", "buffers", "tabs" } },

  telescope = { style = "borderless" },

  border = { style = "rounded" },
}

M.base46 = {
  theme = "gruvbox",

  hl_override = {
    Comment = {
      fg = "light_grey",
      italic = true,
    },
    ["@comment"] = {
      fg = "light_grey",
      italic = true,
    },
    -- Tabufline {{{
    ["TbFill"] = { bg = "NONE" },
    ["TbBufOn"] = { bg = "NONE" },
    ["TbBufOnClose"] = { bg = "NONE" },
    ["TbBufOff"] = { bg = "NONE" },
    ["TbBufOffClose"] = { bg = "NONE" },
    -- }}}
  },

  hl_add = {
    ["Twilight"] = {
      bg = "black",
      fg = "grey_fg",
    },
    ["GitSignsCurrentLineBlame"] = {
      fg = "light_grey",
      italic = true,
    },
    ["NvimSeparator"] = {
      bg = "none",
      fg = "line",
    },
    ["TroubleStatusline1"] = { fg = "light_grey" },
    ["NeoCodeiumSuggestion"] = { fg = "light_grey" },
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
    ["NvimTreeEndOfBuffer"] = { bg = "NONE" },
    ["NvimTreeWinSeparator"] = { bg = "NONE" },
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

if M.ui.cmp.style == "nvchan" or M.ui.cmp.style == "nvchan_colored" then
  M.base46.hl_override = vim.tbl_extend("force", M.base46.hl_override, {
    ["CmpPmenu"] = { bg = "darker_black" },
  })
  if M.ui.cmp.style == "nvchan_colored" then
    M.base46.hl_override = vim.tbl_extend("force", M.base46.hl_override, {
      ["PmenuSel"] = {
        bg = "grey",
        fg = "NONE",
      },
    })
  end
end

return M
