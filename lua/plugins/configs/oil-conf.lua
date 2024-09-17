local opts = require "plugins.options.oil-opts"
local new_git_status = require("utils").new_git_status

local git_status = new_git_status()

-- Clear git status cache on refresh
local refresh = require("oil.actions").refresh
local orig_refresh = refresh.callback
refresh.callback = function(...)
  git_status = new_git_status()
  orig_refresh(...)
end

opts.view_options = {
  is_hidden_file = function(name, _)
    local dir = require("oil").get_current_dir()
    local is_dotfile = vim.startswith(name, ".") and name ~= ".."
    -- if no local directory (e.g. for ssh connections), just hide dotfiles
    if not dir then
      return is_dotfile
    end
    -- dotfiles are considered hidden unless tracked
    if is_dotfile then
      return not git_status[dir].tracked[name]
    else
      -- Check if file is gitignored
      return git_status[dir].ignored[name]
    end
  end,
}

require("oil").setup(opts)
