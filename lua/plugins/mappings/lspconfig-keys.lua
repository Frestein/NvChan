local M = {}

function M.on_attach(bufnr)
	local lsp = vim.lsp.buf

	local keymaps = {
		{
			"<Tab>",
			function()
				lsp.hover()
			end,
			desc = "Show Information",
		},
		{
			"<leader>cS",
			function()
				lsp.signature_help()
			end,
			desc = "Show Signature",
		},
		{
			"<leader>wa",
			function()
				lsp.add_workspace_folder()
			end,
			desc = "Add Workspace Folder (LSP)",
		},
		{
			"<leader>wr",
			function()
				lsp.remove_workspace_folder()
			end,
			desc = "Remove Workspace Folder (LSP)",
		},
		{
			"<leader>wl",
			function()
				print(vim.inspect(lsp.list_workspace_folders()))
			end,
			desc = "List Workspace Folders (LSP)",
		},
		{
			"<leader>X",
			function()
				for _, client in ipairs(vim.lsp.get_clients()) do
					require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
				end
			end,
			desc = "Populate Workspace Diagnostics (LSP)",
		},
		{
			"<leader>rf",
			function()
				Snacks.rename.rename_file()
			end,
			desc = "Rename File",
		},
		{
			"<leader>ra",
			function()
				require("live-rename").rename { insert = true }
			end,
			desc = "Rename",
		},
		{
			"<leader>rA",
			function()
				require("live-rename").rename { text = "", insert = true }
			end,
			desc = "Clear Rename",
		},
		{
			"<leader>ca",
			mode = { "n", "v" },
			function()
				require("tiny-code-action").code_action()
			end,
			desc = "Code Action",
		},
	}

	for _, keymap in ipairs(keymaps) do
		vim.keymap.set("n", keymap[1], keymap[2], { desc = keymap.desc, buffer = bufnr })
	end
end

return M
