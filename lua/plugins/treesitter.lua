return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",

	config = function()
		require("nvim-treesitter").install({
			"lua",
			"nix",
			"css",
			"html",
			"json",
			"go",
			"templ",
			"sql",
			"python",
			"java",
			"javascript",
			"typescript",
			"bash",
			"markdown",
			"markdown_inline",
			"latex",
			"typst",
			"yaml",
		})

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
			callback = function(ev)
				-- no-op for filetypes without an installed parser
				if pcall(vim.treesitter.start, ev.buf) then
					vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
