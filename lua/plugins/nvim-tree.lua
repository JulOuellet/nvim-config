return {
	"nvim-tree/nvim-tree.lua",
	enabled = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		require("nvim-tree").setup({
			git = { enable = true, ignore = true },
			view = { width = 30, side = "left" },
			renderer = {
				group_empty = true,
				root_folder_modifier = ":t",
				indent_markers = {
					enable = true,
					icons = {
						corner = "└",
						edge = "├",
						item = "├",
					},
				},
				highlight_git = true,
				icons = {
					show = { git = false, folder = true, file = true, folder_arrow = true },
				},
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true,
			},
		})

		vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
	end,
}
