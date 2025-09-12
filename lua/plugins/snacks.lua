return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,

	opts = {
		bigfile = { enabled = true },
		image = { enabled = true },
		notifier = {
			enabled = true,
			style = "minimal",
			width = { min = 30, max = 0.3 },
			height = { min = 1, max = 0.4 },
		},
		input = { enabled = true },
	},
}
