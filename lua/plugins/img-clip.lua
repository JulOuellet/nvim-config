return {
	"HakonHarnes/img-clip.nvim",
	event = "VeryLazy",
	opts = {
		default = {
			dir_path = "assets",
			file_name = "%Y-%m-%d-%H-%M-%S",
			use_absolute_path = false,
			prompt_for_file_name = true,
			show_confirmation_lines = false,
		},
		filetypes = {
			markdown = {
				url_encode_path = true,
				template = "![$CURSOR]($FILE_PATH)",
			},
		},
	},
	keys = {
		{ "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from clipboard" },
	},
}
