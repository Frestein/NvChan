return {
  events = {
    "BufReadPost",
    "BufWritePost",
    "InsertLeave",
    "TextChanged",
  },
  linters_by_ft = {
    lua = { "selene" },
    python = { "ruff" },
    yaml = { "yamllint" },
    bash = { "shellharden", "shellcheck" },
    ["yaml.ansible"] = { "ansible_lint" },
    dockerfile = { "hadolint" },
    go = { "golangcilint" },
    gomod = { "golangcilint" },
  },
}
