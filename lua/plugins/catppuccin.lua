return {
	"catppuccin/nvim",
	enabled = true,
	name = "catppuccin",
	priority = 1000,
	lazy = false,
	config = function()
		require("catppuccin").setup({
			flavour = "macchiato",
		})
		vim.cmd.colorscheme("catppuccin-macchiato")
	end,
}
