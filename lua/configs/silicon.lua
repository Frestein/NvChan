local options = {
  font = "JetBrains Mono=34;Noto Color Emoji=34",
  to_clipboard = true,
  theme = "Nord",
  pad_horiz = 50,
  pad_vert = 40,
  window_title = function()
    return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
  end,
}

require("silicon").setup(options)
