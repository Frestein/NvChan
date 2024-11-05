M = {}

local symbols, colors

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    symbols = require("trouble").statusline {
      mode = "symbols",
      groups = {},
      title = false,
      filter = { range = true },
      format = "{kind_icon}{symbol.name:Normal}",
      hl_group = "trouble_statusline",
    }
  end,
})

function M.trouble()
  if symbols and symbols.has() then
    local statusline_symbols = symbols.get()

    if not colors then
      colors = require("utils").get_base46_colors()
      if colors then
        vim.api.nvim_set_hl(0, "TroubleStatusline1", { fg = colors.light_grey, bg = colors.black })
      end
    end

    return " " .. statusline_symbols
  end
  return ""
end

function M.lazy()
  local lazy_status = require "lazy.status"
  local lazy_updates = lazy_status.has_updates() and (" " .. lazy_status.updates() .. " ") or ""
  return "%#LazyUpdates#" .. lazy_updates
end

return M
