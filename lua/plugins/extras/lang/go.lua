return {
	"ray-x/go.nvim",
	ft = { "go", "gomod" },
	config = function(_, opts)
		require("go").setup(opts)
	end,
}
