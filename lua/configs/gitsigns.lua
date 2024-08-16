local opts = require "nvchad.configs.gitsigns"

opts.current_line_blame = true
opts.current_line_blame_opts = {
  delay = 500,
}
opts.on_attach = function(bufnr)
  local gs = package.loaded.gitsigns
  local map = vim.keymap.set

  local function options(desc)
    return { buffer = bufnr, desc = desc }
  end

  map("n", "<leader>grh", gs.reset_hunk, options "Gitsigns Reset Hunk")
  map("n", "<leader>gph", gs.preview_hunk, options "Gitsigns Preview Hunk")
  map("n", "<leader>gb", gs.blame_line, options "Gitsigns Blame Line")
  map("n", "<leader>gtb", gs.toggle_current_line_blame, options "Gitsigns Toggle Blame Line")
  map("n", "<leader>gtd", gs.toggle_deleted, options "Gitsigns Toggle Deleted")
  map("n", "<leader>gtn", gs.toggle_numhl, options "Gitsigns Toggle Numhl")
end

return opts
