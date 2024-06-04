local options = {
  formatters_by_ft = {
    -- scripts
    lua = { "stylua" },
    bash = { "shfmt" },
    python = { "ruff_format", "black" },

    -- web
    scss = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    yaml = { "prettier" },
    json = { "prettier" },

    -- jvm
    kotlin = { "ktlint" },

    -- c
    c = { "clang-format" },

    -- docs
    markdown = { "prettier" },
  },
}

require("conform").setup(options)
