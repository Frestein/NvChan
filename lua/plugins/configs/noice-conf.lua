local notify = require "notify"
local base46 = require "base46"

-- Transparency fix
local base16 = base46.get_theme_tb "base_16"

notify.setup {
  background_colour = base16.base00,
}
