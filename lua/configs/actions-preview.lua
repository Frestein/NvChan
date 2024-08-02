local telescope_defaults = require "nvchad.configs.telescope"

local options = {
  telescope = telescope_defaults,
}

require("actions-preview").setup(options)
