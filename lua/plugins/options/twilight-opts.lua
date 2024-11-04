local colors = require("utils").get_base46_colors()

local opts = {
  dimming = {
    alpha = 1.0,
    color = { "Normal", "#ffffff" },
    term_bg = "#000000",
  },
}

if colors then
  opts.dimming.color = { colors.grey_fg }
  opts.dimming.term_bg = colors.black
end

return opts
