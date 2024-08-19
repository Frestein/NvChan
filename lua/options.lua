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

autocmd("FileType", {
  pattern = { "norg", "markdown" },
  callback = function()
    vim.wo.foldlevel = 99
    vim.wo.conceallevel = 2
  end,
})

-- Restore cursor position
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
