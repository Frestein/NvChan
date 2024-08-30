M = {}

local lsp_attached = false
local highlight_set = false

function M.set_lsp_attached(value)
  lsp_attached = value
end

local trouble = require "trouble"
local symbols = trouble.statusline {
  mode = "lsp_document_symbols",
  groups = {},
  title = false,
  filter = { range = true },
  format = "{kind_icon}{symbol.name:Normal}",
  hl_group = "lualine_a_normal",
}

local function set_trouble_highlights()
  if not highlight_set then
    local base46 = require "base46"
    local base30 = base46.get_theme_tb "base_30"
    vim.api.nvim_set_hl(0, "TroubleStatusline1", { fg = base30.light_grey })
    highlight_set = true
  end
end

function M.trouble()
  if not lsp_attached then
    return ""
  end

  if symbols.has() then
    local statusline_symbols = symbols.get()
    set_trouble_highlights()
    return statusline_symbols
  else
    return ""
  end
end

function M.lazy()
  local lazy_status = require "lazy.status"
  if lazy_status.has_updates() then
    return ("%#LazyUpdates#" .. " " .. lazy_status.updates() .. " ")
  else
    return ""
  end
end

return M
