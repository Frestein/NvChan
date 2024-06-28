local options = {
  load = {
    ["core.defaults"] = {},
    ["core.concealer"] = {},
    ["core.completion"] = {
      config = {
        engine = "nvim-cmp",
      },
    },
    ["core.dirman"] = {
      config = {
        workspaces = {
          notes = "~/Documents/notes",
        },
        default_workspace = "notes",
      },
    },
    ["core.integrations.telescope"] = {
      config = {
        insert_file_link = {
          show_title_preview = true,
        },
      },
    },
  },
}

vim.wo.foldlevel = 99
vim.wo.conceallevel = 2
return options
