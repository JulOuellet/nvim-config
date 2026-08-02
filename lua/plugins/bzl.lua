return {
	"JulOuellet/bzl.nvim",
	-- loads ~/projects/bzl.nvim when present (see dev in config/lazy.lua)
	dev = true,
	cmd = "Bzl",
	keys = {
		{ "<leader>bs", "<cmd>Bzl sync<cr>", desc = "Bazel Sync" },
		{ "<leader>bt", "<cmd>Bzl targets<cr>", desc = "Bazel Targets" },
		{ "<leader>bh", "<cmd>Bzl targets here<cr>", desc = "Bazel Targets (here)" },
	},
	opts = {},
}
