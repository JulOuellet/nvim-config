return {
	"neovim/nvim-lspconfig",
	enabled = true,
	dependencies = {
		"saghen/blink.cmp",
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},

	config = function()
		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf }
				local client = vim.lsp.get_client_by_id(ev.data.client_id)

				if client and client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
				end

				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>th", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
				end, { buffer = ev.buf, desc = "[T]oggle Inlay [H]ints" })
			end,
		})

		vim.lsp.config("*", {
			capabilities = require("blink.cmp").get_lsp_capabilities(),
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					hint = {
						enable = true,
					},
					diagnostics = {
						globals = { "vim", "Snacks" },
					},
				},
			},
		})

		vim.lsp.config("gopls", {
			root_dir = function(bufnr, on_dir)
				local fname = vim.api.nvim_buf_get_name(bufnr)
				on_dir(vim.fs.root(fname, {
					"MODULE.bazel",
					"WORKSPACE.bazel",
					"WORKSPACE",
				}) or vim.fs.root(fname, { "go.work", "go.mod", ".git" }))
			end,
			settings = {
				gopls = {
					hints = {
						assignVariableTypes = true,
						compositeLiteralFields = true,
						compositeLiteralTypes = true,
						constantValues = true,
						functionTypeParameters = true,
						parameterNames = true,
						rangeVariableTypes = true,
					},
				},
			},
		})

		vim.lsp.config("ts_ls", {
			settings = {
				typescript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
				javascript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayVariableTypeHints = true,
					},
				},
			},
		})

		vim.lsp.config("pyright", {
			settings = {
				python = {
					analysis = {
						diagnosticSeverityOverrides = {
							reportOptionalMemberAccess = "information",
							reportArgumentType = "information",
							reportAttributeAccessIssue = "information",
						},
					},
				},
			},
		})

		vim.lsp.config("rust_analyzer", {
			settings = {
				["rust-analyzer"] = {
					check = { command = "clippy" },
					cargo = { allFeatures = true },
				},
			},
		})

		vim.lsp.config("clangd", {
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=iwyu",
				"--completion-style=detailed",
			},
		})

		vim.lsp.enable({
			"lua_ls",
			"gopls",
			"ts_ls",
			"sqls",
			"templ",
			"pyright",
			"nixd",
			"cssls",
			"bashls",
			"html",
			"jsonls",
			"rust_analyzer",
			"taplo",
			"clangd",
		})
	end,
}
