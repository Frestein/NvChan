-- keymap.lua
--- Table of key mappings.
--- @class Keymap
--- @field [1] string Left-hand side key (lhs).
--- @field [2] string|function The function or command to be called when the key is pressed (rhs).
--- @field [3]? string|table The description of the key or a table with parameters.
--- @field mode? string|table The mode in which the key mapping should be applied.

local M = {}

--- Adds parameters to keymap descriptions.
--- @param keymaps Keymap[] The table of key mappings.
--- @param params table A table of parameters to set in the keymap descriptions.
function M.add_params_to_desc(keymaps, params)
	for _, keymap in ipairs(keymaps) do
		local desc = keymap[3]
		if type(desc) == "string" then
			keymap[3] = { desc = desc }
		elseif type(desc) == "table" then
			for k, v in pairs(params) do
				desc[k] = v
			end
		end

		for k, v in pairs(params) do
			keymap[3][k] = v
		end
	end
end

---Sets key mappings for the specified modes.
---@param handler function The function used to set the key mappings.
---@param keymaps Keymap[] A table containing keys and their parameters (functions and descriptions).
function M.map(handler, keymaps)
	for _, options in pairs(keymaps) do
		local mode = options.mode or "n"
		local lhs = options[1]
		local rhs = options[2]
		local opts = options[3] or {}

		if type(opts) == "string" then
			opts = { desc = opts }
		end

		if opts.bufnr then
			opts.buffer = opts.bufnr
			opts.bufnr = nil
		end

		handler(mode, lhs, rhs, opts)
	end
end

return M
