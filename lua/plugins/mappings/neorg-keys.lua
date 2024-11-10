local neorg_callbacks = require "neorg.core.callbacks"

neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
	keybinds.map_event_to_mode("norg", {
		n = {
			{ "<leader>fl", "core.integrations.telescope.find_linkable" },
		},
	}, {
		silent = true,
		noremap = true,
	})
end)
