return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },

	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "gofumpt", "goimports" },
				nix = { "alejandra" },
				json = { "prettier", "jq" },
				html = { "prettier" },
				css = { "prettier" },
				sql = { "sql-formatter" },
				sh = { "shfmt" },
			},
		})

		-- CTRL + ALT + l to format
		vim.keymap.set("n", "<C-M-l>", function()
			require("conform").format({ async = false, lsp_fallback = true })
		end, { desc = "format file" })
	end,
}
