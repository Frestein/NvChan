local telescope = require "telescope"

local M = {}

function M.sg()
  return telescope.extensions.ast_grep.ast_grep()
end

function M.lazy()
  return telescope.extensions.lazy.lazy()
end

function M.project()
  return telescope.extensions.project.project()
end

function M.import()
  return telescope.extensions.import.import()
end

function M.heading()
  return telescope.extensions.heading.heading()
end

function M.zoxide()
  return telescope.extensions.zoxide.list()
end

function M.undo()
  return telescope.extensions.undo.undo()
end

function M.chezmoi()
  return telescope.extensions.chezmoi.find_files()
end

return M
