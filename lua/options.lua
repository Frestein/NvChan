require "nvchad.options"

local o = vim.o

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

o.pumblend = 15
