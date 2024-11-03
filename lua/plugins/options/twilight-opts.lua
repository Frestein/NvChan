local colors = dofile(vim.g.base46_cache .. "colors")

local opts = {
  dimming = {
    alpha = 1.0,
    color = { colors.grey_fg },
    term_bg = colors.black,
  },
}

return opts
