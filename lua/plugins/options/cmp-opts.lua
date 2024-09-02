local options = require "nvchad.configs.cmp"
local cmp = require "cmp"
local cmp_ui = require("nvconfig").ui.cmp
local cmp_style = cmp_ui.style
-- local neocodeium = require "neocodeium"
-- local commands = require "neocodeium.commands"
-- local supermaven_api = require "supermaven-nvim.api"

-- cmp.event:on("menu_opened", function()
--   -- commands.disable()
--   -- neocodeium.clear()
--   supermaven_api.stop()
-- end)
--
-- cmp.event:on("menu_closed", function()
--   -- commands.enable()
--   supermaven_api.start()
-- end)

options.window = {
  completion = {
    side_padding = (cmp_style ~= "atom" and cmp_style ~= "atom_colored") and 1 or 0,
    winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
    scrollbar = false,
    autocomplete = false,
  },
  documentation = {
    winhighlight = "FloatBorder:CmpPmenu,Normal:CmpPmenu",
    border = { "", "", "", " ", "", "", "", " " },
  },
}

options.mapping = {
  ["<C-p>"] = cmp.mapping.select_prev_item(),
  ["<C-n>"] = cmp.mapping.select_next_item(),
  ["<C-k>"] = cmp.mapping.scroll_docs(-4),
  ["<C-j>"] = cmp.mapping.scroll_docs(4),
  ["<C-Space>"] = cmp.mapping.complete(),
  ["<C-e>"] = cmp.mapping.close(),

  ["<CR>"] = cmp.mapping.confirm {
    behavior = cmp.ConfirmBehavior.Insert,
    select = true,
  },

  ["<Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif require("luasnip").expand_or_jumpable() then
      require("luasnip").expand_or_jump()
    else
      fallback()
    end
  end, { "i", "s" }),

  ["<S-Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif require("luasnip").jumpable(-1) then
      require("luasnip").jump(-1)
    else
      fallback()
    end
  end, { "i", "s" }),
}

return options
