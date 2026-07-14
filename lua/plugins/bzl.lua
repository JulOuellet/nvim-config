return {
	"JulOuellet/bzl.nvim",
	-- loads ~/projects/bzl.nvim when present (see dev in config/lazy.lua)
	dev = true,
	cmd = "Bzl",
	keys = {
		{
			"<leader>bt",
			function()
				require("bzl").targets("testable", "here")
			end,
			desc = "Bazel Tests (project)",
		},
		{
			"<leader>bT",
			function()
				require("bzl").tree("testable")
			end,
			desc = "Bazel Tests (workspace)",
		},
		{
			"<leader>br",
			function()
				require("bzl").targets("runnable", "here")
			end,
			desc = "Bazel Runnables (project)",
		},
		{
			"<leader>bR",
			function()
				require("bzl").tree("runnable")
			end,
			desc = "Bazel Runnables (workspace)",
		},
		{
			"<leader>bb",
			function()
				require("bzl").targets()
			end,
			desc = "Bazel All Targets",
		},
		{
			"<leader>bs",
			function()
				require("bzl").sync()
			end,
			desc = "Bazel Sync",
		},
	},
	opts = {},
}
