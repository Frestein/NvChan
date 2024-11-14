local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map
local lsp = vim.lsp.buf

local M = {}

function M.on_attach(bufnr)
	--- @type Keymap[]
	local keymaps = {
		{ "<leader>cS", lsp.signature_help, "LSP show signature help" },
		{ "<leader>wa", lsp.add_workspace_folder, "LSP add workspace folder" },
		{ "<leader>wr", lsp.remove_workspace_folder, "LSP remove workspace folder" },
		{
			"<leader>rf",
			function()
				Snacks.rename.rename_file()
			end,
			"Rename File",
		},
		{
			"<leader>wl",
			function()
				print(vim.inspect(lsp.list_workspace_folders()))
			end,
			"LSP list workspace folders",
		},
		{
			"<leader>ra",
			function()
				require("live-rename").rename { insert = true }
			end,
			"LSP rename",
		},
		{
			"<leader>rA",
			function()
				require("live-rename").rename { text = "", insert = true }
			end,
			"LSP rename (empty)",
		},
		{
			"<leader>ca",
			mode = { "n", "v" },
			function()
				require("tiny-code-action").code_action()
			end,
			"LSP code action",
		},
		{
			"<leader>X",
			function()
				for _, client in ipairs(vim.lsp.get_clients()) do
					require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
				end
			end,
			"LSP populate workspace diagnostics",
		},
	}
	keymap_utils.add_params_to_desc(keymaps, { buffer = bufnr })
	keymap_utils.map(map_handler, keymaps)
end

return M
