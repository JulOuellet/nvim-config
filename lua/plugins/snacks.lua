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
		words = { enabled = true },
		explorer = { enabled = true },
		picker = {
			enabled = true,
		},
	},

	keys = {
		{
			"<leader>e",
			function()
				Snacks.explorer()
			end,
			desc = "Toggle Explorer",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Find Grep",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Find Buffers",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Find Recent",
		},
		{
			"<leader>fd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Find Diagnostics",
		},
		{
			"<leader>gb",
			function()
				Snacks.picker.git_branches()
			end,
			desc = "Find Git Branches",
		},
		{
			"<leader>gc",
			function()
				Snacks.picker.git_commits()
			end,
			desc = "Find Git Commits",
		},
		{
			"<leader>gd",
			function()
				Snacks.picker.git_diff()
			end,
			desc = "Find Git Diff",
		},
	},
}
