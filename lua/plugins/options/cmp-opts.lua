dofile(vim.g.base46_cache .. "cmp")

local cmp = require "cmp"
local defaults = require "cmp.config.default"()
local luasnip = require "luasnip"

vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
local auto_select = true

-- This is a better implementation of `cmp.confirm`:
--  * check if the completion menu is visible without waiting for running sources
--  * create an undo point before confirming
-- This function is both faster and more reliable.
---@param opts? {select: boolean, behavior: cmp.ConfirmBehavior}
local function confirm(opts)
	opts = vim.tbl_extend("force", {
		select = true,
		behavior = cmp.ConfirmBehavior.Insert,
	}, opts or {})
	return function(fallback)
		if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
			require("utils").create_undo()
			if cmp.confirm(opts) then
				return
			end
		end
		return fallback()
	end
end

local opts = {
	completion = {
		completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
	},
	preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert {
		["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
		["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = confirm { select = auto_select },
		["<C-y>"] = confirm { select = true },
		["<S-CR>"] = confirm { behavior = cmp.ConfirmBehavior.Replace }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<C-CR>"] = function(fallback)
			cmp.abort()
			fallback()
		end,
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = cmp.config.sources {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "lazydev", group_index = 0 },
	},
	experimental = {
		ghost_text = {
			hl_group = "CmpGhostText",
		},
	},
	sorting = defaults.sorting,
}

return vim.tbl_deep_extend("force", opts, require "nvchad.cmp")
