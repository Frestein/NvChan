local options = require "plugins.options.noice-opts"
local noice = require "noice"
local notify = require "notify"
local base46 = require "base46"

local function setup_lsp_specific_options()
  local filetype = vim.bo.filetype

  if filetype == "python" then
    options.lsp.progress.throttle = 1000 / 5
  end
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = setup_lsp_specific_options,
})

noice.setup(options)

-- Transparency fix
local base16 = base46.get_theme_tb "base_16"

notify.setup {
  background_colour = base16.base00,
}
