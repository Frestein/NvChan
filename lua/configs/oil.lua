-- @class GitCache
-- @field func function
-- @field results table
local GitCache = {}

-- @param func function
-- @return GitCache
function GitCache:new(func)
  local tbl = {
    func = func,
    results = {},
  }
  self.__index = self
  setmetatable(tbl, self)
  return tbl
end

-- @param dir string
function GitCache:_call(dir)
  local cmd =
    string.format('git -C %s ls-files --ignored --exclude-standard --others --directory | grep -v "/.*/"', dir)

  local handle = io.popen(cmd)
  if handle == nil then
    return
  end

  local output = handle:read "*a"
  handle:close()

  -- Clean the output a bit
  local lines = vim.split(output, "\n")
  local ignored_files = {}
  for _, line in ipairs(lines) do
    -- Remove trailing slash
    line = line:gsub("/$", "")
    table.insert(ignored_files, line)
  end
  table.insert(ignored_files, ".git")
  table.insert(ignored_files, "..")

  self.results[dir] = ignored_files
  self.checked = true
end

-- @param dir string
-- @return table
function GitCache:call(dir)
  if self.results[dir] == nil then
    -- Reset cache, we don't care about old dir results
    self.results = {}

    self:_call(dir)
  end
  return self.results[dir]
end

local cache = GitCache:new(get_ignored)

local function get_git_ignored_files_in(dir)
  local found = vim.fs.find(".git", {
    upward = true,
    path = dir,
  })
  if #found == 0 then
    return {}
  end

  return cache:call(dir)
end

local options = {
  keymaps = {
    ["<C-v>"] = "actions.select_vsplit",
    ["<Tab>"] = "actions.select",
  },
  view_options = {
    is_hidden_file = function(name, bufnr)
      local ignored_files = get_git_ignored_files_in(require("oil").get_current_dir())
      return vim.tbl_contains(ignored_files, name) or vim.startswith(name, ".")
    end,
  },
}

require("oil").setup(options)
