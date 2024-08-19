local options = {
  map_all_ctrl = true,
  ctrl_map_modes = { "n", "o", "i", "c", "t", "v" },
  hack_keymap = true,
  disable_hack_modes = { "i" },
  automapping_modes = { "n", "v", "x", "s" },
  default_layout = [[ABCDEFGHIJKLMNOPQRSTUVWXYZ<>:"{}~abcdefghijklmnopqrstuvwxyz,.;'[]`]],
  layouts = {
    ru = {
      id = "ru",
      layout = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯБЮЖЭХЪËфисвуапршолдьтщзйкыегмцчнябюжэхъё",
    },
  },
}

return options
