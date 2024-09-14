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
    signature = {
      enabled = true,
      opts = {
        size = {
          max_width = 65,
          max_height = 20,
        },
      }
    },
  },
  presets = {
    command_palette = true,
    long_message_to_split = true,
    lsp_doc_border = false,
  },
  -- Transparency fix
  views = {
    mini = {
      win_options = {
        winblend = 0,
      },
    },
    hover = {
      size = {
        max_width = 80,
      }
    }
  },
}

return opts
