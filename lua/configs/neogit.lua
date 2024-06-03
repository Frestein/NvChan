local options = {
  signs = { section = { "", "" }, item = { "", "" } },
  integrations = {
    telescope = true,
    diffview = true,
  },
}

require("neogit").setup(options)
