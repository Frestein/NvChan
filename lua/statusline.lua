M = {}

local lsp_attached = false

function M.set_lsp_attached(value)
  lsp_attached = value
end

function M.navic()
  if not lsp_attached then
    return ""
  end

  local navic_status = require "nvim-navic"
  if navic_status.is_available() then
    return navic_status.get_location()
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
