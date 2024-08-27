local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
  pattern = { "norg", "markdown" },
  callback = function()
    vim.wo.foldlevel = 99
    vim.wo.conceallevel = 2
  end,
})

-- Restore cursor position
autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if
      line > 1
      and line <= vim.fn.line "$"
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd 'normal! g`"'
    end
  end,
})
