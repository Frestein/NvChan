require "nvchad.options"

-- user options

local o = vim.o
-- o.relativenumber = true
o.swapfile = false
o.scrolloff = 5
o.cursorlineopt = "both"
-- o.langmap = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"

vim.filetype.add {
  extension = { rasi = "rasi" },
  pattern = {
    [".*/waybar/config"] = "jsonc",
    [".*/mako/config"] = "dosini",
    [".*/kitty/*.conf"] = "bash",
    [".*/hypr/.*%.conf"] = "hyprlang",
  },
}
