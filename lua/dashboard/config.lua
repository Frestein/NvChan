local M = {}

function M.get_header()
  local utils = require "dashboard.utils"
  local headers = M.headers
  local themes = M.themes

  math.randomseed(os.time())

  local date = os.date "*t"
  local year = tonumber(date.year)
  local month = tonumber(date.month)
  local day = tonumber(date.day)

  for _, t in ipairs(themes) do
    if t.holiday == "easter" then
      local easter = utils.calculate_easter()
      t.month = easter.month
      t.day = easter.day
      t.holiday = nil
    elseif t.holiday == "us_thanksgiving" then
      local thanksgiving = utils.calculate_us_thanksgiving()
      t.month = thanksgiving.month
      t.day = thanksgiving.day
      t.holiday = nil
    end

    local from = t.from or t
    local to = t.to or t

    if month >= from.month then
      from.year = year
      to.year = to.month < from.month and year + 1 or year
    else -- month < from.month
      from.year = year - 1
      to.year = to.month < from.month and year or year - 1
    end

    local ff = from.year * 10000 + from.month * 100 + from.day
    local tt = to.year * 10000 + to.month * 100 + to.day
    local dd = year * 10000 + month * 100 + day

    if dd >= ff and dd <= tt then
      local random_index = math.random(#headers[t.theme])
      return headers[t.theme][random_index]
    end
  end

  local random_index = math.random(#headers["default"])
  return headers["default"][random_index]
end

M.themes = {
  { theme = "halloween", month = 10, day = 31 },
  { theme = "starwars", from = { month = 11, day = 1 }, to = { month = 11, day = 30 } },
  { theme = "xmas", from = { month = 12, day = 28 }, to = { month = 1, day = 14 } },
}

M.buttons = {
  { txt = "  Select Session", keys = "Spc q s", cmd = "lua require('persistence').select()" },
  { txt = "  Find File", keys = "Spc f f", cmd = "Telescope find_files" },
  { txt = "  Find Project", keys = "Spc f p", cmd = "Telescope project" },
  { txt = "  Find Dotfiles", keys = "Spc f D", cmd = "Telescope chezmoi find_files" },
  { txt = "󱐁  Zoxide List", keys = "Spc f Z", cmd = "Telescope zoxide list" },
  { txt = "󰈚  Recent Files", keys = "Spc f o", cmd = "Telescope oldfiles" },
  { txt = "  Bookmarks", keys = "Spc f m", cmd = "Telescope marks" },
  { txt = "  Themes", keys = "Spc t H", cmd = "Telescope themes" },
  { txt = "  Mappings", keys = "Spc c h", cmd = "NvCheatsheet" },

  { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

  {
    txt = function()
      local stats = require("lazy").stats()
      local ms = math.floor(stats.startuptime) .. " ms"
      return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
    end,
    hl = "NvDashFooter",
    no_gap = true,
  },

  { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
}

M.headers = {
  ["default"] = {
    {
      "                                   ",
      "   ⡆⣿⣿⣦⠹⣳⣳⣕⢅⠈⢗⢕⢕⢕⢕⢕⢈⢆⠟⠋⠉⠁⠉⠉⠁⠈⠼⢐⢕   ",
      "   ⡗⢰⣶⣶⣦⣝⢝⢕⢕⠅⡆⢕⢕⢕⢕⢕⣴⠏⣠⡶⠛⡉⡉⡛⢶⣦⡀⠐⣕   ",
      "   ⡝⡄⢻⢟⣿⣿⣷⣕⣕⣅⣿⣔⣕⣵⣵⣿⣿⢠⣿⢠⣮⡈⣌⠨⠅⠹⣷⡀⢱   ",
      "   ⡝⡵⠟⠈⢀⣀⣀⡀⠉⢿⣿⣿⣿⣿⣿⣿⣿⣼⣿⢈⡋⠴⢿⡟⣡⡇⣿⡇⡀   ",
      "   ⡝⠁⣠⣾⠟⡉⡉⡉⠻⣦⣻⣿⣿⣿⣿⣿⣿⣿⣿⣧⠸⣿⣦⣥⣿⡇⡿⣰⢗   ",
      "   ⠁⢰⣿⡏⣴⣌⠈⣌⠡⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣬⣉⣉⣁⣄⢖⢕⢕   ",
      "   ⡀⢻⣿⡇⢙⠁⠴⢿⡟⣡⡆⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣵⣵   ",
      "   ⡻⣄⣻⣿⣌⠘⢿⣷⣥⣿⠇⣿⣿⣿⣿⣿⣿⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿   ",
      "   ⣷⢄⠻⣿⣟⠿⠦⠍⠉⣡⣾⣿⣿⣿⣿⣿⣿⢸⣿⣦⠙⣿⣿⣿⣿⣿⣿⣿⣿   ",
      "   ⡕⡑⣑⣈⣻⢗⢟⢞⢝⣻⣿⣿⣿⣿⣿⣿⣿⠸⣿⠿⠃⣿⣿⣿⣿⣿⣿⡿⠁   ",
      "                                   ",
      "          Hello, master!         ",
      "                                   ",
    },
    {
      "                            ",
      "     ▄▄         ▄ ▄▄▄▄▄▄▄   ",
      "   ▄▀███▄     ▄██ █████▀    ",
      "   ██▄▀███▄   ███           ",
      "   ███  ▀███▄ ███           ",
      "   ███    ▀██ ███           ",
      "   ███      ▀ ███           ",
      "   ▀██ █████▄▀█▀▄██████▄    ",
      "     ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀   ",
      "                            ",
      "     Powered By  eovim    ",
      "                            ",
    },
  },
  ["halloween"] = {
    {
      "                                                                     ",
      "                                              ,           ^'^  _     ",
      "                                              )               (_) ^'^",
      "         _/\\_                    .---------. ((        ^'^          ",
      "         (('>                    )`'`'`'`'`( ||                 ^'^  ",
      "    _    /^|                    /`'`'`'`'`'`\\||           ^'^       ",
      "    =>--/__|m---               /`'`'`'`'`'`'`\\|                     ",
      "         ^^           ,,,,,,, /`'`'`'`'`'`'`'`\\      ,              ",
      "                     .-------.`|`````````````|`  .   )               ",
      "                   / .^. .^. \\|  ,^^, ,^^,  |  / \\ ((              ",
      "                  /  |_| |_|  \\  |__| |__|  | /,-,\\||              ",
      '       _         /_____________\\ |")| |  |  |/ |_| \\|              ',
      "      (\")         |  __   __  |  '==' '=='  /_______\\     _        ",
      "     (' ')        | /  \\ /  \\ |   _______   |,^, ,^,|    (\")      ",
      "      \\  \\        | |--| |--| |  ((--.--))  ||_| |_||   (' ')      ",
      '     _  ^^^ _      | |__| |("| |  ||  |  ||  |,-, ,-,|   /  /        ',
      "   ,' ',  ,' ',    |           |  ||  |  ||  ||_| |_||   ^^^         ",
      ".,,|RIP|,.|RIP|,.,,'==========='==''=='==''=='=======',,....,,,,.,,..",
      "                                                                     ",
      "                         👻 Happy Halloween! 🎃                      ",
      "                                                                     ",
    },
    {
      "                                                  ",
      "                           .,'                    ",
      "                        .''.'                     ",
      "                       .' .'                      ",
      "            .    ' . ~,'  `.~ . `    .            ",
      "       . '  .  '   .`:_. . _:'.   `  .  ` .       ",
      "     .'   .'     ,     .'^'.    .     `.   `.     ",
      "    .    .       .A.  .     . .A.       .    .    ",
      "               .d000b.      .d000b.               ",
      "   '    '    .d0000000b.  .d0000000b.    `    `   ",
      "   .    .      .      . db  .     .      .    .   ",
      "                       d00b                       ",
      "    `    `?0o.  `     `     '    '  .o0P'    '    ",
      "      .    `?00   ooooo.  .ooooo   00P' .   .     ",
      "       ` .   `?00000P ?0bd0P ?00000P' .' . '      ",
      "             . . `~~   ~~~~  .~~'  . .            ",
      "                 ~     - ~~ -    ~                ",
      "                                                  ",
      "              👻 Happy Halloween! 🎃              ",
      "                                                  ",
    },
  },
  ["xmas"] = {
    {
      "                                    ",
      "   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⡀⣴⢦⡀⠀⠀⠀⠀⠀⠀⠀   ",
      "   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡴⠖⢦⡀⠀⠀⣀⡘⣧⠙⠚⠀⡇⠀⠀⠀⠀⠀⠀⠀   ",
      "   ⠀⠀⠀⠀⢀⣀⡀⠀⠀⠀⢧⣀⣴⠃⠀⠘⢯⣭⠉⣤⠤⠞⠁⠀⠀⠀⠀⠀⠀⠀   ",
      "   ⠀⠀⣰⢲⣸⠄⢧⡼⣫⠇⢀⡼⠉⢉⣛⣒⣶⣫⠾⢁⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀   ",
      "   ⠀⠀⠸⣄⣀⣀⣠⢮⣙⣒⣾⠴⠊⠉⠉⣈⠉⣷⢞⡽⠋⡿⠀⠀⠀⠀⠀⠀⠀⠀   ",
      "   ⠀⠀⠀⠀⠉⠉⢀⣠⣤⣤⣧⣀⡴⠚⠉⠉⠉⠃⣾⡤⠞⠁⠀⠀⢰⣲⣶⣵⣄⠀   ",
      "   ⠀⠀⠀⠀⠀⠈⠻⣍⣙⣒⣮⡍⠀⠀⡀⢀⣀⠀⠈⢧⡀⠀⠀⠀⣞⣿⡏⡿⡷⠁   ",
      "   ⢠⡤⣴⣶⠀⠀⠀⠀⠈⠉⢹⠀⠀⠘⠿⠘⠋⠀⠀⠀⢳⡀⠀⠀⠀⠹⠝⠊⠊⠀   ",
      "   ⢰⡕⡊⣻⣿⠃⠀⠀⠀⠀⢸⠀⢀⡤⠖⡺⢯⠉⠉⠓⢆⢧⠀⠀⠀⠀⠀⠀⠀⠀   ",
      "   ⠀⠑⠷⠛⠛⠀⠀⠀⠀⠀⢸⢰⠏⠀⠀⠓⠋⠀⡀⠀⡼⡿⠀⠀⠀⠀⠀⠀⠀⠀   ",
      "   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢈⣯⣧⣄⣈⣒⣒⣩⠴⢚⣵⡇⠀⠀⠀⠀⠀⠀⠀⠀   ",
      "   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣦⣏⣳⠻⠿⡷⠲⠛⣋⣸⡏⠀⠀⠀⠀⠀⠀⠀⠀   ",
      "   ⠀⠀⠀⠀⠀⠀⢀⣀⣀⡀⣰⠃⠉⠉⢙⡿⡟⠋⣭⠍⢇⢳⡀⢀⣀⣄⠀⠀⠀⠀   ",
      "   ⠀⠀⠀⠀⠀⠀⣾⠀⢻⠉⡏⠀⠀⠀⣏⡼⢉⣠⡗⠒⢹⠈⡏⢉⡏⠈⡇⠀⠀⠀   ",
      "   ⠀⠀⠀⠀⠀⠀⢻⡀⣾⠀⡇⠀⠀⠀⣏⠓⠦⢞⣯⣩⠜⠀⡇⠸⡇⢰⠃⠀⠀⠀   ",
      "   ⠀⠀⠀⠀⠀⠀⠈⠓⠧⠖⢳⡖⠋⠉⢹⡶⠶⣾⠉⠉⠓⢶⠓⠦⠗⠋⠀⠀⠀⠀   ",
      "   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠒⠒⠛⠁⠀⠘⠓⠒⠒⠋⠀⠀⠀⠀⠀⠀⠀⠀   ",
      "                                    ",
      "           Merry Christmas!         ",
      "                                    ",
    },
  },
  ["starwars"] = {
    {
      "     .    .     .            +         .         .                 .  .    ",
      "              .    ,,o         .                  __.o+.                   ",
      "    .            od8^                  .      oo888888P^b           .      ",
      '     .       ,".o\'      .     .             `b^\'""`b -`b   .             ',
      "             ,'.'o'             .   .          t. = -`b -`t.    .          ",
      "            ; d o' .        ___          _.--.. 8  -  `b  =`b              ",
      "        .  dooo8<       .o:':__;o.     ,;;o88%%8bb - = `b  =`b.    .       ",
      "  .     |^88^88=. .,x88/::/ | \\\\`;;;;;;d%%%%%88%88888/%x88888            ",
      "        :-88=88%%L8`%`|::|_>-<_||%;;%;8%%=;:::=%8;;\\%%%%\\8888            ",
      "      .   |=88 88%%|HHHH|::| >-< |||;%;;8%%=;:::=%8;;;%%%%+|]88        .   ",
      "          | 88-88%%LL.%.%b::Y_|_Y/%|;;;;`%8%%oo88%:o%.;;;;+|]88  .         ",
      "       Yx88o88^^'\"`^^%8boooood..-\\H_Hd%P%%88%P^%%^'\\;;;/%%88            ",
      '     . `"\\^\\          ~""""\'      d%P ""^" ;   = `+\' - P               ',
      "   .        `.`.b   .                :<%%>  .   :  -   d' - P      . .     ",
      "              .`.b     .        .    `788      ,'-  = d' =.'               ",
      "       .       ``.b.                           :..-  :'  P                 ",
      "            .   `q.>b         .               `^^^:::::,'       .          ",
      '                  ""^^               .                     .               ',
      "    .         .          .                 .        +         .            ",
      "                                                                           ",
      "                    Sienar Fleet Systems' TIE Bomber                       ",
      "                                                                           ",
    },
    {
      "                                                                              ",
      "                                                          _._        *        ",
      "                                        _______..........-`-'-..__  /         ",
      "                               ...###/   \\        \\         ____\\/         ",
      "                         ...########/     \\  ___...\\--     / _   \\         ",
      "                __..---#############/_..---'''     ========/ //  __\\____      ",
      "         __..--''  /     /  / --..__  ```-------________________//      =     ",
      "   __--''       /      /   /________=        \\                 //_______=    ",
      "  `-.._____  /       /    /             ___   \\               ______/__      ",
      "           `````-----------------------////----\\----------'''' ______//      ",
      "                                               /_____.....-----               ",
      "                                                                              ",
      "                        Ubrikkian's GAV Q7 Space-trotter                      ",
      "                                                                              ",
    },
    {
      "                                        .                                       ",
      "                              .-o                                               ",
      "                 .           /  |                                               ",
      "        .                 . /   |   .                                           ",
      "                           /    |                                               ",
      "                  .       /     |                                               ",
      "  .                      /      /         .                                     ",
      "             .          /    _./   .                                            ",
      "                   _.---~-.=:_                                                  ",
      "                  (_.-=() <~`-`-.                                               ",
      "                 _/ _() ~`-==-._,>                                              ",
      "         ..--====--' `~-._.__()                                                 ",
      "     o===''~~             |()                                                   ",
      "               .         \\   |             .                                   ",
      "                         \\  \\                                                 ",
      "                          \\  \\     .                                          ",
      "      .                    \\  \\           Sienar Fleet Systems                ",
      "               .            \\  \\          Lambda-class Imperial Shuttle (3)   ",
      "                             \\_ \\        .                                    ",
      "                                 ~o                                             ",
      "                                                                                ",
    },
  },
}

return M
