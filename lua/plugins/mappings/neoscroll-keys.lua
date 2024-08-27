local map = require("langmapper").map

local neoscroll = require "neoscroll"

-- stylua: ignore
local keymaps = {
  ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 320; easing = "sine" }) end;
  ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 320; easing = "sine" }) end;
  ["<C-b>"] = function() neoscroll.ctrl_b({ duration = 420; easing = "circular"; info = "cursorline" }) end;
  ["<C-f>"] = function() neoscroll.ctrl_f({ duration = 420; easing = "circular"; info = "cursorline" }) end;
  ["<C-y>"] = function() neoscroll.scroll(-0.1, { move_cursor=false; duration = 100; easing = "linear"; info = "cursorline" }) end;
  ["<C-e>"] = function() neoscroll.scroll(0.1,  { move_cursor=false; duration = 100; easing = "linear"; info = "cursorline" }) end;
  ["zt"]    = function() neoscroll.zt({ half_win_duration = 250 }) end;
  ["zz"]    = function() neoscroll.zz({ half_win_duration = 250 }) end;
  ["zb"]    = function() neoscroll.zb({ half_win_duration = 250 }) end;
}

local modes = { "n", "v" }

for key, func in pairs(keymaps) do
  map(modes, key, func)
end
