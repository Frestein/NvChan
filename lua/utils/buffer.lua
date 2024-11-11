local M = {}

local cur_buf = vim.api.nvim_get_current_buf
local set_buf = vim.api.nvim_set_current_buf

local function buf_index(bufnr)
  for i, value in ipairs(vim.t.bufs) do
    if value == bufnr then
      return i
    end
  end
end

M.next = function()
  local bufs = vim.t.bufs
  local curbufIndex = buf_index(cur_buf())

  if not curbufIndex then
    set_buf(vim.t.bufs[1])
    return
  end

  set_buf((curbufIndex == #bufs and bufs[1]) or bufs[curbufIndex + 1])
end

M.prev = function()
  local bufs = vim.t.bufs
  local curbufIndex = buf_index(cur_buf())

  if not curbufIndex then
    set_buf(vim.t.bufs[1])
    return
  end

  set_buf((curbufIndex == 1 and bufs[#bufs]) or bufs[curbufIndex - 1])
end

M.move_buf = function(n)
  local bufs = vim.t.bufs

  for i, bufnr in ipairs(bufs) do
    if bufnr == cur_buf() then
      if n < 0 and i == 1 or n > 0 and i == #bufs then
        bufs[1], bufs[#bufs] = bufs[#bufs], bufs[1]
      else
        bufs[i], bufs[i + n] = bufs[i + n], bufs[i]
      end

      break
    end
  end

  vim.t.bufs = bufs
  vim.cmd "redrawtabline"
end

return M
