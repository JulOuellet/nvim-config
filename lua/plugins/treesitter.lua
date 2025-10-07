return {
	"nvim-treesitter/nvim-treesitter",
	enabled = true,
	build = ":TSUpdate",

	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua",
				"nix",
				"css",
				"shell",
				"html",
				"json",
				"go",
				"sql",
				"templ",
				"python",
			},
			auto_install = true,
			sync_install = false,
			ignore_install = {},
			modules = {},
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn", -- Start selection
					node_incremental = "grn", -- Increment node
					node_decremental = "grm", -- Decrement node
				},
			},
			autotag = {
				enable = true,
			},
		})
	end,
}
