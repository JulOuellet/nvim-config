return {
	"nvim-lualine/lualine.nvim",
	enabled = true,
	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
			},

			sections = {
				lualine_a = { "mode" },
				lualine_b = { "filetype" },
				lualine_c = { "filename", "encoding" },
				lualine_x = {
					function()
						local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
						if next(buf_clients) == nil then
							return "-"
						end
						local names = {}
						for _, client in ipairs(buf_clients) do
							table.insert(names, client.name)
						end
						return " " .. table.concat(names, ", ")
					end,
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},

			tabline = {
				lualine_a = { "fileformat" },
				lualine_b = {
					{
						"buffers",
						symbols = { alternate_file = "", modified = "●" },
						buffers_color = {
							active = "lualine_a_normal",
							inactive = "lualine_b_inactive",
						},
					},
				},
				lualine_c = {},
				lualine_x = {},
				lualine_y = { "branch", "diff", "diagnostics" },
				lualine_z = { "tabs" },
			},
		})
	end,
}
