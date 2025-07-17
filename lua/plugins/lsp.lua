return {
  'neovim/nvim-lspconfig',
  enabled = true,
  dependencies = {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
	{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
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

    local lspconfig = require("lspconfig")

    lspconfig.lua_ls.setup({})
    lspconfig.nixd.setup({})

  end
}
