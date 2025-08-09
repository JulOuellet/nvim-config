return {
  'neovim/nvim-lspconfig',
  enabled = true,
  dependencies = {
    'saghen/blink.cmp',
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
	library = {
	  { path = "${3rd}/luv/library", words = { "vim%.uv" } },
	},
      }
    }
  },

  config = function()
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })

    local capabilities = require('blink.cmp').get_lsp_capabilities()
    local lspconfig = require("lspconfig")

    lspconfig.lua_ls.setup { capabilities = capabilities }
    lspconfig.nixd.setup { capabilities = capabilities }
    lspconfig.cssls.setup { capabilities = capabilities }
    lspconfig.bashls.setup { capabilities = capabilities }
    lspconfig.html.setup { capabilities = capabilities }
    lspconfig.jsonls.setup { capabilities = capabilities }
    lspconfig.gopls.setup { capabilities = capabilities }
    lspconfig.sqls.setup { capabilities = capabilities }
  end
}
