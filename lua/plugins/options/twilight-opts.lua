local base30 = require("base46").get_theme_tb "base_30"

local opts = {
  dimming = {
    alpha = 1.0,
    color = { base30.grey_fg },
    term_bg = base30.black,
  },
}

return opts
