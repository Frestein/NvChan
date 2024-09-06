local set_keymaps = require("utils").set_keymaps
local map = require("langmapper").map

local lsp_buf = vim.lsp.buf
local actions_preview = require "actions-preview"

local M = {}

function M.on_attach(bufnr)
  -- stylua: ignore
  local keymaps = {
    ["gD"] = { func = lsp_buf.declaration, desc = "LSP go to declaration" },
    ["gd"] = { func = lsp_buf.definition, desc = "LSP go to definition" },
    ["gi"] = { func = lsp_buf.implementation, desc = "LSP go to implementation" },
    ["<leader>sh"] = { func = lsp_buf.signature_help, desc = "LSP show signature help" },
    ["<leader>wa"] = { func = lsp_buf.add_workspace_folder, desc = "LSP add workspace folder" },
    ["<leader>wr"] = { func = lsp_buf.remove_workspace_folder, desc = "LSP remove workspace folder" },
    ["gr"] = { func = lsp_buf.references, desc = "LSP show references" },
    ["<leader>D"] = { func = lsp_buf.type_definition, desc = "LSP go to type definition" },
    ["<leader>wl"] = {
      func = function()
        print(vim.inspect(lsp_buf.list_workspace_folders()))
      end,
      desc = "LSP list workspace folders",
    },
    ["<leader>ra"] = {
      func = function() require "nvchad.lsp.renamer"() end,
      desc = "LSP rename",
    },
    ["<leader>ca"] = {
      modes = { "n", "v" },
      func = function() actions_preview.code_actions() end,
      desc = "LSP code action",
    },
  }

  set_keymaps(map, keymaps, bufnr)
end

return M
