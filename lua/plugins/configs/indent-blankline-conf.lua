local hooks = require "ibl.hooks"
local ibl = require "ibl"
local opts = require "plugins.options.indent-blankline-opts"

dofile(vim.g.base46_cache .. "blankline")

hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
ibl.setup(opts)

dofile(vim.g.base46_cache .. "blankline")
