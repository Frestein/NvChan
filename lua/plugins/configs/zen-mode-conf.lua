local opts = require "plugins.options.zen-mode-opts"
local sbl_us_opts = require "plugins.options.symbol-usage-opts"
local incline = require "incline"

opts.on_open = function(win)
  incline.disable()

  sbl_us_opts.opts.text_format = sbl_us_opts.plain_text
  require("symbol-usage").setup(sbl_us_opts.opts)
  require("symbol-usage").refresh()
end

opts.on_close = function()
  incline.enable()

  sbl_us_opts.opts.text_format = sbl_us_opts.bubbles
  require("symbol-usage").setup(sbl_us_opts.opts)
  require("symbol-usage").refresh()
end

require("zen-mode").setup(opts)
