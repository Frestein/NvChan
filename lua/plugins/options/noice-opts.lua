dofile(vim.g.base46_cache .. "notify")

local options = {
  lsp = {
    progress = {
      throttle = 1000 / 30,
    },
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
    signature = { enabled = false },
    -- hover = { enabled = false },
  },
  presets = {
    bottom_search = false,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = true,
  },
  -- Transparency fix
  views = {
    mini = {
      win_options = {
        winblend = 0,
      },
    },
  },
}

return options
