local options = {
  themes = {
    { theme = "new_year", month = 1, day = 1 },
    { theme = "valentines_day", month = 2, day = 14 },
    { theme = "st_patricks_day", month = 3, day = 17 },
    { theme = "easter", holiday = "easter" },
    { theme = "april_fools", month = 4, day = 1 },
    { theme = "us_independence_day", month = 7, day = 4 },
    { theme = "art", month = 9, day = 1 },
    { theme = "halloween", month = 10, day = 31 },
    { theme = "us_thanksgiving", holiday = "us_thanksgiving" },
    { theme = "xmas", from = { month = 12, day = 24 }, to = { month = 12, day = 25 } },
    { theme = "leaves", from = { month = 9, day = 22 }, to = { month = 12, day = 20 } },
    { theme = "snow", from = { month = 12, day = 21 }, to = { month = 3, day = 19 } },
    { theme = "spring", from = { month = 3, day = 20 }, to = { month = 6, day = 20 } },
    { theme = "summer", from = { month = 6, day = 21 }, to = { month = 9, day = 21 } },
  },
  max = 75,
  interval = 150,
  filetypes = { "dashboard", "alpha", "ministarter", "nvdash" },
}

local win_width = vim.api.nvim_win_get_width(0)
local win_height = vim.api.nvim_win_get_height(0)

if win_width < 150 and win_height < 50 then
  options.max = 25
elseif win_width < 150 then
  options.max = 50
else
  options.max = 75
end

return options
