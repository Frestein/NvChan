local set_keymaps = require("utils").set_keymaps
local map = require("langmapper").map

local telescope = require "telescope"
local telescope_builtin = require "telescope.builtin"

local keymaps = {
  ["<leader>ff"] = { func = telescope_builtin.find_files, desc = "telescope find files" },
  ["<leader>fm"] = { func = telescope_builtin.marks, desc = "telescope find marks" },
  ["<leader>fw"] = { func = telescope_builtin.live_grep, desc = "telescope live grep" },
  ["<leader>fb"] = { func = telescope_builtin.buffers, desc = "telescope find buffers" },
  ["<leader>fh"] = { func = telescope_builtin.help_tags, desc = "telescope help page" },
  -- spellchecker: disable-line
  ["<leader>fr"] = { func = telescope_builtin.oldfiles, desc = "telescope recent files" },
  ["<leader>fz"] = { func = telescope_builtin.current_buffer_fuzzy_find, desc = "telescope find in current buffer" },
  ["<leader>fd"] = { func = telescope_builtin.diagnostics, desc = "telescope find diagnostics" },
  ["<leader>ft"] = { func = telescope.extensions.terms.terms, desc = "telescope find terms" },
  ["<leader>th"] = {
    func = function()
      require("nvchad.themes").open { style = "bordered", border = true }
    end,
    desc = "telescope nvchad themes",
  },
}

set_keymaps(map, keymaps)
