local utils = require "utils"

local M = {}

local symbols, colors

function M.trouble()
	if not symbols then
		utils.on_load("trouble.nvim", function()
			symbols = require("trouble").statusline {
				mode = "symbols",
				groups = {},
				title = false,
				filter = { range = true },
				format = "{kind_icon}{symbol.name:Normal}",
				hl_group = "trouble_statusline",
			}
		end)
	elseif symbols.has() then
		local statusline_symbols = symbols.get()
		if not colors then
			colors = utils.get_base46_colors()
			if colors then
				vim.api.nvim_set_hl(0, "TroubleStatusline1", { fg = colors.light_grey, bg = colors.black })
			end
		end
		return " " .. statusline_symbols
	end
end

function M.lazy()
	local lazy_status = require "lazy.status"
	return lazy_status.has_updates() and ("%#LazyUpdates#" .. " " .. lazy_status.updates() .. " ") or ""
end

function M.aw()
	local has_aw, _ = pcall(require, "aw_watcher")
	if has_aw then
		return require("aw_watcher").is_connected() and "%#AwConnected#" .. " "
	end
end

return M
