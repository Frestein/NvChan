require "nvchad.options"

local o = vim.o
local autocmd = vim.api.nvim_create_autocmd

local cursor_options = {
  "n-v-c:block",
  "i-ci-ve:ver25",
  "r-cr:hor20",
  "o:hor50",
  "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
  "sm:block-blinkwait175-blinkoff150-blinkon175",
}

o.guicursor = table.concat(cursor_options, ",")
o.cursorlineopt = "both"
o.relativenumber = true
o.swapfile = false
o.scrolloff = 5

vim.filetype.add {
  extension = { rasi = "rasi" },
  pattern = {
    [".*/hypr/.*%.conf"] = "hyprlang",
  },
}

-- Dynamic terminal padding {{{

-- autocmd("VimEnter", {
--   command = ":silent !kitty @ set-spacing padding=0 margin=0",
-- })
--
-- autocmd("VimLeavePre", {
--   command = ":silent !kitty @ set-spacing padding=10 margin=0",
-- })

-- }}}
-- Restore cursor position {{{

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
-- Langmap {{{

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
-- Conform {{{

vim.api.nvim_create_user_command("ConformFormat", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format { async = true, lsp_fallback = true, range = range }
end, { range = true })

-- }}}
-- Noice {{{

-- Transparency fix
require("notify").setup {
  background_colour = "#2e3440",
}

-- }}}
-- Neorg {{{

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "norg", "markdown" },
  callback = function()
    vim.wo.foldlevel = 99
    vim.wo.conceallevel = 2
  end,
})

-- }}}
-- vim:fileencoding=utf-8:foldmethod=marker
