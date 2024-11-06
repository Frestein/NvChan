local incline = require "incline"
local opts = require "plugins.options.zen-mode-opts"
local zen_mode = require "zen-mode"

opts.on_open = function()
	incline.disable()
end

opts.on_close = function()
	incline.enable()
end

zen_mode.setup(opts)
