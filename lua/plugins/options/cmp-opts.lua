local opts = require "nvchad.configs.cmp"
local symbol_map = require("utils").symbol_map

local cmp = require "cmp"
local cmp_ui = require("nvconfig").ui.cmp
local cmp_style = cmp_ui.style

local lspkind = require "lspkind"

-- local neocodeium = require "neocodeium"
-- local commands = require "neocodeium.commands"
-- local supermaven_api = require "supermaven-nvim.api"

-- cmp.event:on("menu_opened", function()
--   -- commands.disable()
--   -- neocodeium.clear()
--   supermaven_api.stop()
-- end)

-- cmp.event:on("menu_closed", function()
--   -- commands.enable()
--   supermaven_api.start()
-- end)

local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

opts.window = {
  completion = {
    side_padding = (
      cmp_style ~= "atom"
      and cmp_style ~= "atom_colored"
      and cmp_style ~= "nvchan"
      and cmp_style ~= "nvchan_colored"
    )
        and 1
      or 0,
    winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
    scrollbar = false,
    autocomplete = false,
  },
  documentation = {
    winhighlight = "FloatBorder:CmpPmenu,Normal:CmpPmenu",
    border = { "", "", "", " ", "", "", "", " " },
  },
}

local field_arrangement = {
  atom = { "kind", "abbr", "menu" },
  atom_colored = { "kind", "abbr", "menu" },
  nvchan = { "kind", "abbr", "menu" },
  nvchan_colored = { "kind", "abbr", "menu" },
}

opts.formatting = {
  fields = field_arrangement[cmp_style] or { "abbr", "kind", "menu" },
  format = lspkind.cmp_format {
    mode = "symbol_text",
    maxwidth = 50,
    show_labelDetails = true,
    ellipsis_char = "󰇘",
    before = function(entry, item)
      local icons = symbol_map
      local icon = (cmp_ui.icons and icons[item.kind]) or ""

      if cmp_style == "atom" or cmp_style == "atom_colored" then
        item.menu = cmp_ui.lspkind_text and " (" .. item.kind .. ")" or ""
        item.kind = icon
      elseif cmp_style == "nvchan" or cmp_style == "nvchan_colored" then
        item.menu = cmp_ui.lspkind_text and " " .. item.kind or ""
        item.kind = icon
      else
        icon = cmp_ui.lspkind_text and (" " .. icon .. " ") or icon
        item.kind = string.format("%s %s", icon, cmp_ui.lspkind_text and item.kind or "")
      end

      return item
    end,
  },
}

if cmp_style ~= "atom" and cmp_style ~= "atom_colored" and cmp_style ~= "nvchan" and cmp_style ~= "nvchan_colored" then
  opts.window.completion.border = border "CmpBorder"
end

opts.mapping = {
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

return opts
