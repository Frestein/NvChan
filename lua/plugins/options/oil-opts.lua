local detail = false

local options = {
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
  keymaps = {
    ["gd"] = {
      desc = "Toggle file detail view",
      callback = function()
        detail = not detail
        if detail then
          require("oil").set_columns { "icon", "permissions", "size", "mtime" }
        else
          require("oil").set_columns { "icon" }
        end
      end,
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
}

return options
