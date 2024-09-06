local M = {}

M.symbol_map = {
  Array = " ",
  Boolean = "󰨙 ",
  Class = " ",
  Codeium = "󰘦 ",
  Color = "󰏘 ",
  Control = " ",
  Collapsed = " ",
  Constant = "󰏿 ",
  Constructor = " ",
  Copilot = " ",
  Enum = " ",
  EnumMember = " ",
  Event = " ",
  Field = "󰜢 ",
  File = "󰈙 ",
  Folder = "󰉋 ",
  Function = "󰊕 ",
  Interface = " ",
  Key = " ",
  Keyword = " ",
  Method = "󰊕 ",
  Module = " ",
  Namespace = "󰦮 ",
  Null = " ",
  Number = "󰎠 ",
  Object = " ",
  Operator = "󰆕 ",
  Package = " ",
  Property = "󰜢 ",
  Reference = " ",
  Snippet = " ",
  String = " ",
  Struct = "󰙅 ",
  TabNine = "󰏚 ",
  Text = "󰉿 ",
  TypeParameter = " ",
  Unit = " ",
  Value = "󰎠 ",
  Variable = "󰀫 ",
}

--- Sets key mappings for the specified modes.
-- @param map The function used to set the key mappings.
-- @param keymaps A table containing keys and their parameters (functions and descriptions).
-- Each entry can include:
--   - `func`: The function to be called when the key is pressed.
--   - `desc`: A description of the key.
--   - `modes` (optional): A table of modes for the key mapping. If not provided, defaults to normal mode ("n").
-- @param bufnr (optional) The buffer number, if key mappings should be set only for a specific buffer.
function M.set_keymaps(map, keymaps, bufnr)
  for key, value in pairs(keymaps) do
    local modes = value.modes or "n"
    local options = { desc = value.desc }
    if bufnr then
      options.buffer = bufnr
    end
    map(modes, key, value.func, options)
  end
end

return M
