local set_keymaps = require("utils").set_keymaps
local map = require("langmapper").map

local lsp_buf = vim.lsp.buf

local function toggle_inlay_hints()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end

local M = {}

function M.on_attach(bufnr)
	local keymaps = {
		["gD"] = { func = lsp_buf.declaration, desc = "LSP go to declaration" },
		["gd"] = { func = lsp_buf.definition, desc = "LSP go to definition" },
		["gi"] = { func = lsp_buf.implementation, desc = "LSP go to implementation" },
		["<leader>sh"] = { func = lsp_buf.signature_help, desc = "LSP show signature help" },
		["<leader>wa"] = { func = lsp_buf.add_workspace_folder, desc = "LSP add workspace folder" },
		["<leader>wr"] = { func = lsp_buf.remove_workspace_folder, desc = "LSP remove workspace folder" },
		["gr"] = { func = lsp_buf.references, desc = "LSP show references" },
		["<leader>D"] = { func = lsp_buf.type_definition, desc = "LSP go to type definition" },
		["<F10>"] = { func = toggle_inlay_hints, desc = "LSP toggle inlay hints" },
		["<leader>wl"] = {
			func = function()
				print(vim.inspect(lsp_buf.list_workspace_folders()))
			end,
			desc = "LSP list workspace folders",
		},
		["<leader>ra"] = {
			func = function()
				require "nvchad.lsp.renamer"()
			end,
			desc = "LSP rename",
		},
		["<leader>ca"] = {
			modes = { "n", "v" },
			func = function()
				require("tiny-code-action").code_action()
			end,
			desc = "LSP code action",
		},
		["<leader>X"] = {
			func = function()
				for _, client in ipairs(vim.lsp.get_clients()) do
					require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
				end
			end,
			desc = "LSP populate workspace diagnostics",
		},
	}

	set_keymaps(map, keymaps, bufnr)
end

return M
