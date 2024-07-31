local options = {
  font = "Maple Mono=34;FontAwesome;JetBrainsMono Nerd Font",
  to_clipboard = true,
  theme = "Nord",
  pad_horiz = 50,
  pad_vert = 40,
  language = function()
    return vim.bo.filetype
  end,
  window_title = function()
    return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
  end,
  output = function()
    return "~/Pictures/Screenshots/" .. os.date "!%Y-%m-%dT%H-%M-%SZ" .. "_code.png"
  end,
}

require("nvim-silicon").setup(options)
