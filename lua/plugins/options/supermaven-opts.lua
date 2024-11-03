local colors = dofile(vim.g.base46_cache .. "colors")

return {
  keymaps = {
    accept_suggestion = "<C-f>",
    accept_word = "<C-w>",
    clear_suggestion = "<C-c>",
  },
  color = {
    suggestion_color = colors.light_grey,
  },
  log_level = "off",
}
