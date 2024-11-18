vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

local icons = {
	Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
	Breakpoint = " ",
	BreakpointCondition = " ",
	BreakpointRejected = { " ", "DiagnosticError" },
	LogPoint = ".>",
}

for name, sign in pairs(icons) do
	sign = type(sign) == "table" and sign or { sign }
	vim.fn.sign_define(
		"Dap" .. name,
		{ text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
	)
end

-- setup dap config by VsCode launch.json file
local json = require "plenary.json"
local vscode = require "dap.ext.vscode"
vscode.json_decode = function(str)
	return vim.json.decode(json.json_strip_comments(str))
end
