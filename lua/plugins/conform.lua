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
				sql = { "pg_format" },
				sh = { "shfmt" },
				templ = { "templ" },
				python = { "ruff_imports", "ruff_format" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			},
			formatters = {
				ruff_imports = {
					command = "ruff",
					args = { "check", "--select", "I", "--fix", "--stdin-filename", "$FILENAME", "-" },
					stdin = true,
				},
			},
		})

		-- CTRL + ALT + l to format
		vim.keymap.set("n", "<C-M-l>", function()
			require("conform").format({ async = false, lsp_fallback = true })
		end, { desc = "format file" })
	end,
}
