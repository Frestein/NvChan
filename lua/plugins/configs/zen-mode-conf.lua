local opts = require "plugins.options.zen-mode-opts"
local zen_mode = require "zen-mode"

local ok, incline = pcall(require, "incline")
if ok then
	opts.on_open = function()
		incline.disable()
	end

	opts.on_close = function()
		incline.enable()
	end
end

zen_mode.setup(opts)
