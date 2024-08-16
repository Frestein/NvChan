local options = require "nvchad.configs.gitsigns"

options.current_line_blame = true
options.current_line_blame_opts = {
  delay = 500,
}
options.on_attach = function(bufnr)
  local gitsigns = package.loaded.gitsigns
  local map = vim.keymap.set

  local function opts(desc)
    return { buffer = bufnr, desc = desc }
  end

  map("n", "<leader>grh", gitsigns.reset_hunk, opts "Gitsigns Reset Hunk")
  map("n", "<leader>gph", gitsigns.preview_hunk, opts "Gitsigns Preview Hunk")
  map("n", "<leader>gb", gitsigns.blame_line, opts "Gitsigns Blame Line")
  map("n", "<leader>gtb", gitsigns.toggle_current_line_blame, opts "Gitsigns Toggle Blame Line")
  map("n", "<leader>gtd", gitsigns.toggle_deleted, opts "Gitsigns Toggle Deleted")
  map("n", "<leader>gtn", gitsigns.toggle_numhl, opts "Gitsigns Toggle Numhl")
end

return options
