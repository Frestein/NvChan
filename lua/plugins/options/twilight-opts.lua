local base46 = require "base46"
local base30 = base46.get_theme_tb "base_30"
local base16 = base46.get_theme_tb "base_16"

local opts = {
  dimming = {
    colors = { "Normal", base16.base05 },
    term_bg = base30.black,
  },
}

return opts
