dofile(vim.g.base46_cache .. "whichkey")

local lmu = require "langmapper.utils"
local state = require "which-key.state"
local check_orig = state.check

state.check = function(state, key)
	if key ~= nil then
		key = lmu.translate_keycode(key, "default", "ru")
	end

	return check_orig(state, key)
end

return {}
