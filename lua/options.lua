-- vim:fileencoding=utf-8:foldmethod=marker
require "nvchad.options"

local o = vim.o
local autocmd = vim.api.nvim_create_autocmd

o.relativenumber = true
o.swapfile = false
o.scrolloff = 5
o.cursorlineopt = "both"

vim.filetype.add {
  extension = { rasi = "rasi" },
  pattern = {
    [".*/hypr/.*%.conf"] = "hyprlang",
  },
}

-- Langmap{{{

local function escape(str)
  local escape_chars = [[;,."|\]]
  return vim.fn.escape(str, escape_chars)
end

local en = [[qwertyuiop[]asdfghjkl;zxcvbnm,.]]
local ru = [[йцукенгшщзхъфывапролджячсмитьбю]]
local en_shift = [[QWERTYUIOP{}ASDFGHJKL:ZXCVBNM<>]]
local ru_shift = [[ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЯЧСМИТЬБЮ]]
o.langmap = vim.fn.join({ escape(ru_shift) .. ";" .. escape(en_shift), escape(ru) .. ";" .. escape(en) }, ",")

-- }}}
-- Dynamic terminal padding{{{

autocmd("VimEnter", {
  command = ":silent !kitty @ set-spacing padding=0 margin=0",
})

autocmd("VimLeavePre", {
  command = ":silent !kitty @ set-spacing padding=10 margin=0",
})

-- }}}
-- Restore cursor position{{{

autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if
      line > 1
      and line <= vim.fn.line "$"
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd 'normal! g`"'
    end
  end,
})

-- }}}
-- Show only modified buffers{{{

autocmd({ "BufAdd", "BufEnter", "tabnew" }, {
  callback = function()
    vim.t.bufs = vim.tbl_filter(function(bufnr)
      return vim.api.nvim_buf_get_option(bufnr, "modified")
    end, vim.t.bufs)
  end,
})

-- }}}
