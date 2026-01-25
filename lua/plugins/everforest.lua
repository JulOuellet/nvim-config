return {
	"sainnhe/everforest",
	enabled = false,
	priority = 1000,

	config = function()
		vim.g.everforest_background = "medium"
		vim.g.everforest_better_performance = 1
		vim.cmd.colorscheme("everforest")
		vim.opt.cursorline = true
	end,
}
