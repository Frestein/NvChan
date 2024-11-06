local conform = require "conform"
local opts = require "plugins.options.conform-opts"

conform.setup(opts)

vim.api.nvim_create_user_command("ConformFormat", function(args)
	local range = nil
	if args.count ~= -1 then
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line:len() },
		}
	end
	conform.format { async = true, lsp_fallback = true, range = range }
end, { range = true })
