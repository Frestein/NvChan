local base30 = require("base46").get_theme_tb "base_30"

local options = {
  keymaps = {
    accept_suggestion = "<C-f>",
    accept_word = "<C-w>",
    clear_suggestion = "<C-c>",
  },
  color = {
    suggestion_color = base30.light_grey,
  },
  log_level = "off",
}

return options
