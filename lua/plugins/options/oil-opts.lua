local oil = require "oil"
local is_git_repo = require("utils").is_git_repo

local detail = false

local opts = {
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,

  win_options = {},

  keymaps = {
    ["gd"] = {
      callback = function()
        detail = not detail

        if detail then
          oil.set_columns { "icon", "permissions", "size", "mtime" }
        else
          oil.set_columns { "icon" }
        end
      end,
      desc = "file toggle detail view",
    },
  },

  git = {
    add = function(path)
      return true
    end,
    mv = function(src_path, dest_path)
      return true
    end,
    rm = function(path)
      return true
    end,
  },

  float = {
    padding = 3,
  },
}

local function update_win_options()
  if is_git_repo() then
    opts.win_options.signcolumn = "yes:2"
  else
    opts.win_options.signcolumn = "no"
  end
end

vim.api.nvim_create_autocmd("DirChanged", {
  callback = function()
    update_win_options()
    oil.setup(opts)
  end,
})

return opts
