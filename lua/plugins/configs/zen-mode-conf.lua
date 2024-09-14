local opts = require "plugins.options.zen-mode-opts"
local sbl_us_opts = require "plugins.options.symbol-usage-opts"

opts.on_open = function(win)
  sbl_us_opts.opts.text_format = sbl_us_opts.plain_text
  require("symbol-usage").setup(sbl_us_opts.opts)
  require("symbol-usage").refresh()
end

opts.on_close = function()
  sbl_us_opts.opts.text_format = sbl_us_opts.bubbles
  require("symbol-usage").setup(sbl_us_opts.opts)
  require("symbol-usage").refresh()
end

require("zen-mode").setup(opts)
