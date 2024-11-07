local keymap_utils = require "utils.keymap"
local map_handler = require("langmapper").map
local lsp_buf = vim.lsp.buf

local function toggle_inlay_hints()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end

local M = {}

function M.on_attach(bufnr)
	--- @type Keymap[]
	local keymaps = {
		{ "gD", lsp_buf.declaration, "LSP go to declaration" },
		{ "gd", lsp_buf.definition, "LSP go to definition" },
		{ "gi", lsp_buf.implementation, "LSP go to implementation" },
		{ "<leader>sh", lsp_buf.signature_help, "LSP show signature help" },
		{ "<leader>wa", lsp_buf.add_workspace_folder, "LSP add workspace folder" },
		{ "<leader>wr", lsp_buf.remove_workspace_folder, "LSP remove workspace folder" },
		{ "gr", lsp_buf.references, "LSP show references" },
		{ "<leader>D", lsp_buf.type_definition, "LSP go to type definition" },
		{ "<F10>", toggle_inlay_hints, "LSP toggle inlay hints" },
		{
			"<leader>wl",
			function()
				print(vim.inspect(lsp_buf.list_workspace_folders()))
			end,
			"LSP list workspace folders",
		},
		{
			"<leader>ra",
			function()
				require "nvchad.lsp.renamer"()
			end,
			"LSP rename",
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
