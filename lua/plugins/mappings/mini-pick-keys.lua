local set_keymaps = require("utils").set_keymaps
local map = require("langmapper").map

local MiniPick = require "mini.pick"
local MiniExtra = require "mini.extra"

local function reload_theme(name)
  require("nvconfig").ui.theme = name
  require("base46").load_all_highlights()
  vim.api.nvim_exec_autocmds("User", { pattern = "NvChadThemeReload" })
end

local hooks = {
  pre_hooks = {},
  post_hooks = {},
}

vim.api.nvim_create_autocmd({ "User" }, {
  pattern = "MiniPickStart",
  group = vim.api.nvim_create_augroup("minipick-pre-hooks", { clear = true }),
  desc = "Invoke pre_hook for specific picker based on source.name.",
  callback = function(...)
    local opts = MiniPick.get_picker_opts() or {}
    local pre_hook = hooks.pre_hooks[opts.source.name] or function(...) end
    pre_hook(...)
  end,
})

vim.api.nvim_create_autocmd({ "User" }, {
  pattern = "MiniPickStop",
  group = vim.api.nvim_create_augroup("minipick-post-hooks", { clear = true }),
  desc = "Invoke post_hook for specific picker based on source.name.",
  callback = function(...)
    local opts = MiniPick.get_picker_opts() or {}
    local post_hook = hooks.post_hooks[opts.source.name] or function(...) end
    post_hook(...)
  end,
})

local selected_theme

hooks.pre_hooks.Themes = function()
  selected_theme = require("nvconfig").ui.theme
end

hooks.post_hooks.Themes = function()
  reload_theme(selected_theme)
end

MiniPick.registry.themes = function()
  local themes = require("nvchad.utils").list_themes()
  return MiniPick.start {
    source = {
      name = "Themes",
      items = themes,
      choose = function(item)
        selected_theme = item
      end,
      preview = function(buf_id, item)
        reload_theme(item)
        vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, { item })
      end,
    },
  }
end

local keymaps = {
  ["<leader>ff"] = {
    func = function()
      MiniPick.builtin.files { tool = "rg" }
    end,
    desc = "MiniPick find files",
  },
  ["<leader>fw"] = { func = MiniPick.builtin.grep, desc = "MiniPick grep files" },
  ["<leader>fW"] = { func = MiniPick.builtin.grep_live, desc = "MiniPick live grep files" },
  ["<leader>fb"] = { func = MiniPick.builtin.buffers, desc = "MiniPick find buffers" },
  ["<leader>fH"] = { func = MiniPick.builtin.help, desc = "MiniPick find help" },
  ["<leader>fr"] = { func = MiniPick.builtin.resume, desc = "MiniPick latest picker" },
  ["<leader>fz"] = {
    func = function()
      MiniExtra.pickers.buf_lines { scope = "current" }
    end,
    desc = "MiniPick buffer lines",
  },
  ["<leader>fm"] = { func = MiniExtra.pickers.marks, desc = "MiniPick marks" },
  ["<leader>th"] = { func = MiniPick.registry.themes, desc = "MiniPick nvchad themes" },
  -- spellchecker: disable-line
  ["<leader>fo"] = { func = MiniExtra.pickers.oldfiles, desc = "MiniPick oldfiles" },
  ["<leader>fs"] = { func = MiniExtra.pickers.spellsuggest, desc = "MiniPick spell suggestions" },
  ["<leader>fgb"] = { func = MiniExtra.pickers.git_branches, desc = "MiniPick git branches" },
  ["<leader>fgc"] = { func = MiniExtra.pickers.git_commits, desc = "MiniPick git commits" },
  ["<leader>fgf"] = { func = MiniExtra.pickers.git_files, desc = "MiniPick git files" },
  ["<leader>fgh"] = { func = MiniExtra.pickers.git_hunks, desc = "MiniPick git hunks" },
  ["<leader>fsh"] = { func = MiniExtra.pickers.history, desc = "MiniPick history" },
  ["<leader>fhl"] = { func = MiniExtra.pickers.hl_groups, desc = "MiniPick highlight groups" },
  ["<leader>fch"] = { func = MiniExtra.pickers.keymaps, desc = "MiniPick keymaps" },
}

set_keymaps(map, keymaps)
