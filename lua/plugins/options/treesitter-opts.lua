pcall(function()
	dofile(vim.g.base46_cache .. "syntax")
	dofile(vim.g.base46_cache .. "treesitter")
end)

---@type string
local xdg_config = vim.env.XDG_CONFIG_HOME or vim.env.HOME .. "/.config"

---@param path string
local function have(path)
	return vim.uv.fs_stat(vim.env.HOME .. "/" .. path) or vim.uv.fs_stat(xdg_config .. "/" .. path) ~= nil
end

vim.filetype.add {
	extension = { rasi = "rasi", rofi = "rasi", wofi = "rasi" },
	filename = {
		["vifmrc"] = "vim",
	},
	pattern = {
		[".*/waybar/config"] = "jsonc",
		[".*/mako/config"] = "dosini",
		[".*/kitty/.+%.conf"] = "bash",
		[".*/ghostty/config"] = "bash",
		[".*/hypr/.+%.conf"] = "hyprlang",
		["%.env%.[%w_.-]+"] = "sh",
	},
}

---@type TSConfig
---@diagnostic disable-next-line: missing-fields
local opts = {
	highlight = { enable = true, use_languagetree = true },
	indent = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-space>",
			node_incremental = "<C-space>",
			scope_incremental = false,
			node_decremental = "<bs>",
		},
	},
	textobjects = {
		move = {
			enable = true,
			goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
			goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
			goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
			goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
		},
	},
	ensure_installed = {
		"bash",
		"c",
		"css",
		"desktop",
		"diff",
		"dockerfile",
		"git_config",
		"git_rebase",
		"gitattributes",
		"gitcommit",
		"gitignore",
		"go",
		"gomod",
		"gosum",
		"gowork",
		"html",
		"ini",
		"json",
		"json5",
		"jsonc",
		"lua",
		"luadoc",
		"luap",
		"markdown",
		"markdown_inline",
		"norg",
		"python",
		"regex",
		"toml",
		"vim",
		"vimdoc",
		"xml",
		"yaml",
	},
}

local function add(lang)
	if type(opts.ensure_installed) == "table" then
		table.insert(opts.ensure_installed, lang)
	end
end

if have "hypr" then
	add "hyprlang"
end

if have "fish" then
	add "fish"
end

if have "rofi" or have "wofi" then
	add "rasi"
end

if have "zathura" then
	add "zathurarc"
end

if have ".Xresources" then
	add "xresources"
end

return opts
