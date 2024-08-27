local map = require("langmapper").map

local neoscroll = require "neoscroll"

-- stylua: ignore
local keymaps = {
  ["<C-u>"] = {
    func = function() neoscroll.ctrl_u({ duration = 320; easing = "sine" }) end,
    desc = "scroll scroll up half a page"
  },
  ["<C-d>"] = {
    func = function() neoscroll.ctrl_d({ duration = 320; easing = "sine" }) end,
    desc = "scroll scroll down half a page"
  },
  ["<C-b>"] = {
    func = function() neoscroll.ctrl_b({ duration = 420; easing = "circular"; info = "cursorline" }) end,
    desc = "scroll scroll up one full page"
  },
  ["<C-f>"] = {
    func = function() neoscroll.ctrl_f({ duration = 420; easing = "circular"; info = "cursorline" }) end,
    desc = "scroll scroll down one full page"
  },
  ["<C-y>"] = {
    func = function() neoscroll.scroll(-0.1, { move_cursor=false; duration = 100; easing = "linear"; info = "cursorline" }) end,
    desc = "scroll scroll up a little without moving the cursor"
  },
  ["<C-e>"] = {
    func = function() neoscroll.scroll(0.1, { move_cursor=false; duration = 100; easing = "linear"; info = "cursorline" }) end,
    desc = "scroll scroll down a little without moving the cursor"
  },
  ["zt"] = {
    func = function() neoscroll.zt({ half_win_duration = 250 }) end,
    desc = "scroll move the current line to the top of the window"
  },
  ["zz"] = {
    func = function() neoscroll.zz({ half_win_duration = 250 }) end,
    desc = "scroll center the current line in the window"
  },
  ["zb"] = {
    func = function() neoscroll.zb({ half_win_duration = 250 }) end,
    desc = "scroll move the current line to the bottom of the window"
  },
}

local modes = { "n", "v" }

for key, value in pairs(keymaps) do
  map(modes, key, value.func, { desc = value.desc })
end
