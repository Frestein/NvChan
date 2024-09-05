local oil = require "oil"

local detail = false

local opts = {
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
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

return opts
