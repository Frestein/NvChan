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

function M.set_keymaps(map, modes, keymaps, bufnr)
  for key, value in pairs(keymaps) do
    local options = { desc = value.desc }
    if bufnr then
      options.buffer = bufnr
    end
    map(modes, key, value.func, options)
  end
end

return M
