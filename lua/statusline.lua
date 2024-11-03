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

    local colors = dofile(vim.g.base46_cache .. "colors")
    vim.api.nvim_set_hl(0, "TroubleStatusline1", { fg = colors.light_grey, bg = colors.black })

    return " " .. statusline_symbols
  else
    return ""
  end
end

function M.trouble_file()
  local icon = "󰈚"
  local path = vim.api.nvim_buf_get_name(M.stbufnr())
  local name = (path == "" and "Empty") or path:match "([^/\\]+)[/\\]*$"
  local statusline_symbols

  if name ~= "Empty" then
    local devicons_present, devicons = pcall(require, "nvim-web-devicons")

    if devicons_present then
      local ft_icon = devicons.get_icon(name)
      icon = (ft_icon ~= nil and ft_icon) or icon
    end
    if lsp_attached then
      if symbols and symbols.has() then
        statusline_symbols = symbols.get()

        local colors = dofile(vim.g.base46_cache .. "colors")
        vim.api.nvim_set_hl(0, "TroubleStatusline1", { fg = colors.light_grey, bg = colors.one_bg })

        return { icon, name, statusline_symbols }
      else
        return { icon, name }
      end
    end
  end

  return { icon, name }
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
  if lazy_status.has_updates() then
    return (" " .. lazy_status.updates() .. " ")
  else
    return ""
  end
end

return M
