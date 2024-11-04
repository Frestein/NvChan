local trouble, symbols
local lsp_attached = false

M = {}

function M.stbufnr()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

function M.set_lsp_attached(value)
  lsp_attached = value
  if lsp_attached then
    trouble = require "trouble"
    symbols = trouble.statusline {
      mode = "symbols",
      groups = {},
      title = false,
      filter = { range = true },
      format = "{kind_icon}{symbol.name:Normal}",
      -- hl_group = "St_file_txt",
      hl_group = "trouble_statusline",
    }
  end
end

function M.trouble_statusline()
  if not lsp_attached then
    return ""
  elseif symbols and symbols.has() then
    local statusline_symbols = symbols.get()

    -- PERF: Этот участок постоянно перевызывается, даже если тема не менялась. Найти другое решение.
    local colors = require("utils").get_base46_colors()
    if colors then
      vim.api.nvim_set_hl(0, "TroubleStatusline1", { fg = colors.light_grey, bg = colors.black })
    end

    return " " .. statusline_symbols
  end
  return ""
end

function M.git_branch()
  if not vim.b[M.stbufnr()].gitsigns_head or vim.b[M.stbufnr()].gitsigns_git_status then
    return ""
  end

  local git_status = vim.b[M.stbufnr()].gitsigns_status_dict
  local branch_name = " " .. git_status.head

  return " " .. branch_name
end

function M.lazy()
  local lazy_status = require "lazy.status"
  return lazy_status.has_updates() and (" " .. lazy_status.updates() .. " ") or ""
end

return M
