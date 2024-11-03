-- vim:fileencoding=utf-8:foldmethod=marker

local statusline = require "statusline"
local dashboard = require "dashboard.config"

---@type ChadrcConfig
local M = {}

M.nvdash = {
  header = dashboard.get_header(),
  buttons = dashboard.buttons,
  load_on_startup = true,
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
    ["NvimSeparator"] = {
      bg = "NONE",
      fg = "line",
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
    -- lazy.nvim statusline module
    ["LazyUpdates"] = {
      fg = "green",
      bg = "NONE",
    },
    -- highlight-undo.nvim {{{
    ["HighlightUndo"] = {
      bg = { "black", "blue", 40 },
    },
    ["HighlightRedo"] = {
      bg = { "black", "red", 40 },
    },
    -- }}}
    -- twilight.nvim {{{
    ["Twilight"] = {
      bg = "black",
      fg = "grey_fg",
    },
    -- }}}
    -- gitsigns.nvim {{{
    ["GitSignsCurrentLineBlame"] = {
      fg = "light_grey",
      italic = true,
    },
    -- }}}
    -- trouble.nvim {{{
    ["TroubleStatusline1"] = {
      fg = "light_grey",
      bg = "one_bg",
    },
    ["TroubleSeparatorHighlight"] = {
      fg = "yellow",
      bg = "one_bg",
    },
    -- }}}
    -- neocodeium {{{
    ["NeoCodeiumSuggestion"] = { fg = "light_grey" },
    -- }}}
    -- nvim-tree.lua {{{
    ["NvimTreeEndOfBuffer"] = { bg = "NONE" },
    ["NvimTreeWinSeparator"] = { bg = "NONE" },
    -- }}}
    -- symbol-usage.nvim {{{
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
    "blankline",
    "cmp",
    "devicons",
    "diffview",
    "git",
    "neogit",
    "notify",
    "nvcheatsheet",
    "nvimtree",
    "statusline",
    "syntax",
    "tbline",
    "telescope",
    "todo",
    "treesitter",
    "trouble",
    "whichkey",
  },

  transparency = false,
}

M.cheatsheet = {
  theme = "simple",
  excluded_groups = {
    ":help (i)",
    ":help",
    "LM (x)",
    "LSP (v)",
    "Nvim",
    "Opens",
    "autopairs",
    "general (i)",
    "motion (x)",
    "scroll (v)",
    "terminal (t)",
  },
}

M.lsp = {
  signature = false,
}

return M
