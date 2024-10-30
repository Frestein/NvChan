-- vim:fileencoding=utf-8:foldmethod=marker

local statusline = require "statusline"

math.randomseed(os.time())

local headers = {
  {
    "                             ",
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
    "                             ",
    "       Hello, master!      ",
    "                             ",
  },
  {
    "                            ",
    "     ▄▄         ▄ ▄▄▄▄▄▄▄   ",
    "   ▄▀███▄     ▄██ █████▀    ",
    "   ██▄▀███▄   ███           ",
    "   ███  ▀███▄ ███           ",
    "   ███    ▀██ ███           ",
    "   ███      ▀ ███           ",
    "   ▀██ █████▄▀█▀▄██████▄    ",
    "     ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀   ",
    "                            ",
    "     Powered By  eovim    ",
    "                            ",
  },
}

local random_index = math.random(#headers)
local header = headers[random_index]

---@type ChadrcConfig
local M = {}

M.nvdash = {
  header = header,
  load_on_startup = true,
  buttons = {
    { txt = "  Select Session", keys = "Spc q s", cmd = "lua require('persistence').select()" },
    { txt = "  Find File", keys = "Spc f f", cmd = "Telescope find_files" },
    { txt = "  Find Project", keys = "Spc f p", cmd = "Telescope project" },
    { txt = "  Find Dotfiles", keys = "Spc f D", cmd = "Telescope chezmoi find_files" },
    { txt = "󱐁  Zoxide List", keys = "Spc f Z", cmd = "Telescope zoxide list" },
    { txt = "󰈚  Recent Files", keys = "Spc f o", cmd = "Telescope oldfiles" },
    { txt = "  Bookmarks", keys = "Spc f m", cmd = "Telescope marks" },
    { txt = "  Themes", keys = "Spc t H", cmd = "Telescope themes" },
    { txt = "  Mappings", keys = "Spc c h", cmd = "NvCheatsheet" },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashFooter",
      no_gap = true,
    },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
  },
}

M.ui = {
  statusline = {
    theme = "minimal",
    separator_style = "block",
    modules = {
      trouble_statusline = statusline.trouble_statusline,
      trouble_file = function()
        if M.ui.statusline.theme == "minimal" then
          local config = M.ui.statusline
          local sep_style = (config ~= nil and config.separator_style ~= nil) and config.separator_style or "default"
          local utils = require "nvchad.stl.utils"

          sep_style = (sep_style ~= "round" and sep_style ~= "block") and "block" or sep_style

          local sep_icons = utils.separators
          local separators = (type(sep_style) == "table" and sep_style) or sep_icons[sep_style]

          local sep_l = separators["left"]
          local sep_r = "%#St_sep_r#" .. separators["right"] .. " %#ST_EmptySpace#"

          local function gen_block(icon, txt, symbols, sep_l_hlgroup, iconHl_group, txt_hl_group)
            local block = sep_l_hlgroup .. sep_l .. iconHl_group .. icon .. " " .. txt_hl_group .. " " .. txt

            if symbols and #symbols > 0 then
              block = block .. " " .. "%#TroubleSeparatorHighlight#" .. "> " .. symbols
            end

            block = block .. sep_r
            return block
          end

          local x = statusline.trouble_file()
          return gen_block(x[1], x[2], x[3], "%#St_file_sep#", "%#St_file_bg#", "%#St_file_txt#")
        end
        return ""
      end,
      lazy = function()
        return "%#LazyUpdates#" .. statusline.lazy()
      end,
      git_branch = function()
        return "%#St_gitIcons#" .. statusline.git_branch()
      end,
    },
    order = {
      "mode",
      "file",
      -- "trouble_file",
      "lazy",
      "git_branch",
      "%=",
      "lsp_msg",
      "trouble_statusline",
      "%=",
      "lsp",
      "cwd",
      "cursor",
    },
  },

  cmp = {
    --- @diagnostic disable-next-line: assign-type-mismatch
    style = "default",
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
      bg = "NONE",
      fg = "line",
    },
    ["TroubleStatusline1"] = {
      fg = "light_grey",
      bg = "one_bg",
    },
    ["TroubleSeparatorHighlight"] = {
      fg = "yellow",
      bg = "one_bg",
    },
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
      fg = "light_grey",
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

M.lsp = {
  signature = false,
}

return M
