local colors = dofile(vim.g.base46_cache .. "colors")

local opts = {
  hi = {
    fg = colors.line,
  },
}

return opts
