local opts = {
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
  },
  presets = {
    command_palette = true,
    long_message_to_split = true,
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

return opts
