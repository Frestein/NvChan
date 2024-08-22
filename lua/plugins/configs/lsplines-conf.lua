local lsplines = require "lsp_lines"

local autocmd = vim.api.nvim_create_autocmd
local diag_conf = vim.diagnostic.config

lsplines.setup()

diag_conf({
  virtual_text = true,
  virtual_lines = false,
}, require("lazy.core.config").ns)

local function update_diagnostics()
  diag_conf {
    virtual_text = {
      format = function(diagnostic)
        local win_type = vim.fn.win_gettype()
        local cur_line = vim.fn.line "."

        if win_type == "popup" or win_type == "floating" then
          return diagnostic.message
        elseif diagnostic.lnum == cur_line - 1 then
          return nil
        end

        return diagnostic.message
      end,
    },
    virtual_lines = { only_current_line = true },
  }
end

update_diagnostics()

autocmd("CursorMoved", {
  callback = function()
    local win_type = vim.fn.win_gettype()

    if win_type == "popup" or win_type == "floating" then
      return
    end

    update_diagnostics()
  end,
})
