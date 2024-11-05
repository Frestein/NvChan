local opts = require "plugins.options.zen-mode-opts"
local zen_mode = require "zen-mode"
local sbl_us = require "symbol-usage"
local sbl_us_opts = require "plugins.options.symbol-usage-opts"
local incline = require "incline"

opts.on_open = function(win)
  incline.disable()

  sbl_us_opts.opts.text_format = sbl_us_opts.plain_text
  sbl_us.setup(sbl_us_opts.opts)
  sbl_us.refresh()
end

opts.on_close = function()
  incline.enable()

  sbl_us_opts.opts.text_format = sbl_us_opts.plain_text_symbol
  sbl_us.setup(sbl_us_opts.opts)
  sbl_us.refresh()
end

zen_mode.setup(opts)
