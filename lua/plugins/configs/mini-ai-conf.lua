local mini_utils = require "utils.mini"
local opts = require "plugins.options.mini-ai-opts"
local utils = require "utils"

require("mini.ai").setup(opts)
utils.on_load("which-key.nvim", function()
	vim.schedule(function()
		mini_utils.ai_whichkey(opts)
	end)
end)
