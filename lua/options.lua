-- vim:fileencoding=utf-8:foldmethod=marker
require "nvchad.options"

local o = vim.o

o.relativenumber = true
o.swapfile = false
o.scrolloff = 5
o.cursorlineopt = "both"

vim.filetype.add {
  extension = { rasi = "rasi" },
  pattern = {
    [".*/waybar/config"] = "jsonc",
    [".*/kitty/*.conf"] = "bash",
    [".*/hypr/.*%.conf"] = "hyprlang",
  },
}
