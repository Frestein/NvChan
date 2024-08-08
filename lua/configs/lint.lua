local lint = require "lint"

lint.linters_by_ft = {
  python = { "ruff" },
  yaml = { "yamllint" },
}

local lint_augroup = vim.api.nvim_create_augroup("nvim_lint_au", { clear = true })

vim.api.nvim_create_autocmd({ "LspAttach", "BufEnter", "TextChanged" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})
