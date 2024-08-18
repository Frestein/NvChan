local function update_diagnostics()
  vim.diagnostic.config {
    virtual_text = {
      format = function(diagnostic)
        if diagnostic.lnum == vim.fn.line "." - 1 then
          return nil
        end
        return diagnostic.message
      end,
    },
    virtual_lines = { only_current_line = true },
  }
end

update_diagnostics()

vim.api.nvim_create_autocmd("CursorMoved", {
  callback = update_diagnostics,
})

require("lsp_lines").setup()
