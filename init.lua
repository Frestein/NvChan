vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Load compatibility
require "compat"

-- Load plugins
require "plugins.configs.lazy-conf"

-- Load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- Load options
require "options"
require "autocmds"
require "mappings"

-- Load modules
require("modules.improve-visual-block").setup()
require "modules.punto-switcher"

-- Automap keybindings
require("langmapper").automapping { global = true, buffer = true }
