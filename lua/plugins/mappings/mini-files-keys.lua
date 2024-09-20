local set_keymaps = require("utils").set_keymaps
local map = require("langmapper").map
local new_git_status = require("utils").new_git_status

local MiniFiles = require "mini.files"

local autocmd = vim.api.nvim_create_autocmd

local function minifiles_toggle(...)
  if not MiniFiles.close() then
    MiniFiles.open(...)
  end
end

-- Set custom marks {{{

local set_mark = function(id, path, desc)
  MiniFiles.set_bookmark(id, path, { desc = desc })
end

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesExplorerOpen",
  callback = function()
    set_mark("c", vim.fn.stdpath "config", "Config") -- path
    set_mark("w", vim.fn.getcwd, "Working directory") -- callable
    set_mark("~", "~", "Home directory")
  end,
})

-- }}}
-- Mapping to set current working directory {{{

local files_set_cwd = function(path)
  -- Works only if cursor is on the valid file system entry
  local cur_entry_path = MiniFiles.get_fs_entry().path
  local cur_directory = vim.fs.dirname(cur_entry_path)
  vim.fn.chdir(cur_directory)
end

autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    map("n", "g~", files_set_cwd, { buffer = args.data.buf_id, desc = "Set cwd" })
  end,
})

-- }}}
-- Mapping to use grug-far for search in the current directory {{{

local files_grug_far_replace = function(path)
  -- Works only if cursor is on the valid file system entry
  local cur_entry_path = MiniFiles.get_fs_entry().path
  local prefills = { paths = vim.fs.dirname(cur_entry_path) }
  local grug_far = require "grug-far"

  if not grug_far.has_instance "explorer" then
    grug_far.open {
      instanceName = "explorer",
      prefills = prefills,
      staticTitle = "Find and Replace from Explorer",
    }
  else
    grug_far.open_instance "explorer"
    -- Updating the prefills without crealing the search and other fields
    grug_far.update_instance_prefills("explorer", prefills, false)
  end
end

autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    map("n", "gs", files_grug_far_replace, { buffer = args.data.buf_id, desc = "Search in directory" })
  end,
})

-- }}}
-- Mapping to show/hide dot-files and git ignored files {{{

local git_status = new_git_status()

local show_hidden = false

local filter_show = function(fs_entry)
  return true
end

local filter_hide = require("plugins.options.mini-files-opts").create_filter

local toggle_dotfiles = function()
  show_hidden = not show_hidden
  local new_filter = show_hidden and filter_show or filter_hide(git_status)
  MiniFiles.refresh { content = { filter = new_filter } }
end

autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    local buf_id = args.data.buf_id
    -- Tweak left-hand side of mapping to your liking
    map("n", "g.", toggle_dotfiles, { buffer = buf_id, desc = "Toggle hidden" })
  end,
})

-- }}}
-- Mapping to show/hide preview window {{{

local show_preview = false

local toggle_preview = function()
  show_preview = not show_preview
  MiniFiles.refresh { windows = { preview = show_preview } }
end

autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    local buf_id = args.data.buf_id
    -- Tweak left-hand side of mapping to your liking
    map("n", "<C-p>", toggle_preview, { buffer = buf_id, desc = "Toggle preview" })
  end,
})

-- }}}
-- Mappings to modify target window via new tab {{{

local map_tab = function(buf_id, lhs)
  local rhs = function()
    local fs_entry = MiniFiles.get_fs_entry()

    if fs_entry then
      MiniFiles.close()
      vim.cmd("tabnew " .. fs_entry.path)
    end
  end

  map("n", lhs, rhs, { buffer = buf_id, desc = "Open in new tab" })
end

autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    local buf_id = args.data.buf_id
    map_tab(buf_id, "<C-t>")
  end,
})

-- }}}
-- Mappings to modify target window via split {{{

local map_split = function(buf_id, lhs, direction)
  local rhs = function()
    -- Make new window and set it as target
    local cur_target = MiniFiles.get_explorer_state().target_window

    local new_target = vim.api.nvim_win_call(cur_target, function()
      vim.cmd(direction .. " split")
      return vim.api.nvim_get_current_win()
    end)

    MiniFiles.set_target_window(new_target)
  end

  -- Adding `desc` will result into `show_help` entries
  map("n", lhs, rhs, { buffer = buf_id, desc = "Split " .. direction })
end

autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    local buf_id = args.data.buf_id
    -- Tweak keys to your liking
    map_split(buf_id, "<C-s>", "belowright horizontal")
    map_split(buf_id, "<C-v>", "belowright vertical")
  end,
})

-- }}}

-- stylua: ignore
local keymaps = {
  ["<leader>e"] = {
    func = function() minifiles_toggle(vim.api.nvim_buf_get_name(0)) end,
    desc = "MiniFiles toggle current directory",
  },
  ["<leader>E"] = {
    func = function() minifiles_toggle() end,
    desc = "MiniFiles toggle root directory",
  },
}

set_keymaps(map, keymaps)

-- vim:fileencoding=utf-8:foldmethod=marker
