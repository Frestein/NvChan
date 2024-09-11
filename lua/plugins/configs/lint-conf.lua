local lint = require "lint"

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local function get_lsp_root()
  local clients = vim.lsp.get_clients()
  for _, client in ipairs(clients) do
    if client.name == "lua_ls" then
      return client.config.root_dir
    end
  end
  return nil
end

local function find_selene_config(root)
  local config_paths = {
    root .. "/.selene/selene.toml",
    root .. "/.selene/config.toml",
    root .. "/.selene/linter.toml",
    root .. "/selene/selene.toml",
    root .. "/selene/config.toml",
    root .. "/selene/linter.toml",
    root .. "/selene.toml",
    root .. "/linter.toml",
  }

  for _, path in ipairs(config_paths) do
    if vim.fn.filereadable(path) == 1 then
      return path
    end
  end

  return nil
end

local linter_error_notify = nil

local function setup_linting()
  local lua_root = get_lsp_root()
  if lua_root then
    local config_path = find_selene_config(lua_root)
    if config_path then
      local selene = lint.linters.selene
      selene.args = { "--config", config_path, "--display-style", "json", "-" }
    else
      linter_error_notify = vim.notify(
        "Configuration file for selene not found.",
        vim.log.levels.ERROR,
        { title = "Linter", replace = linter_error_notify }
      )
    end
  end
end

lint.linters_by_ft = {
  lua = { "selene" },
  python = { "ruff" },
  yaml = { "yamllint" },
  bash = { "shellharden", "shellcheck" },
  ["yaml.ansible"] = { "ansible_lint" },
  dockerfile = { "hadolint" },
  go = { "golangci-lint" },
  gomod = { "golangci-lint" },
}

local lint_augroup = augroup("nvim_lint", { clear = true })

-- FIX:: Disable the linter if the configuration for Selene is not found,
-- and ensure the notification about the missing config is shown only once.
autocmd({ "LspAttach", "BufEnter", "TextChanged" }, {
  group = lint_augroup,
  callback = function()
    local clients = vim.lsp.get_clients()
    for _, client in ipairs(clients) do
      if client.name == "lua_ls" then
        setup_linting()
        break
      end
    end
    lint.try_lint()
  end,
})

autocmd({ "BufEnter", "TextChanged", "InsertLeave" }, {
  group = lint_augroup,
  pattern = "*.lua",
  callback = function()
    lint.try_lint "codespell"
  end,
})
