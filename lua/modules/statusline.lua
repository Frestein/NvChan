local utils = require "utils"

local M = {}

local trouble_stl, colors

function M.trouble()
	if not trouble_stl then
		utils.on_load("trouble.nvim", function()
			trouble_stl = require("trouble").statusline {
				mode = "symbols",
				groups = {},
				title = false,
				filter = { range = true },
				format = "{kind_icon}{symbol.name:Normal}",
				hl_group = "trouble_statusline",
			}
		end)
	elseif trouble_stl.has() then
		local result = trouble_stl.get()
		if not colors then
			colors = utils.get_base46_colors()
			if colors then
				vim.api.nvim_set_hl(0, "TroubleStatusline1", { fg = colors.light_grey, bg = colors.black })
			end
		end
		return " " .. result
	end
end

function M.lazy()
	local status = require "lazy.status"
	return status.has_updates() and ("%#LazyUpdates#" .. " " .. status.updates() .. " ") or ""
end

function M.aw()
	local ok, aw = pcall(require, "aw_watcher")
	if ok then
		return aw.is_connected() and "%#AwConnected#" .. " "
	end
end

return M
