local options = require "nvchad.configs.cmp"

options.window = {
  completion = {
    side_padding = 0,
    winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
    scrollbar = false,
  },
  documentation = {
    winhighlight = "FloatBorder:CmpPmenu,Normal:CmpPmenu",
    border = { "", "", "", " ", "", "", "", " " },
  },
}

return options
