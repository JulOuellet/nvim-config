return {
  'lewis6991/gitsigns.nvim',
  enable = true,

  config = function()
    require('gitsigns').setup({
      signs = {
	add          = { text = '│' },
	change       = { text = '│' },
	delete       = { text = '_' },
	topdelete    = { text = '‾' },
	changedelete = { text = '~' },
	untracked    = { text = '┆' },
      },
      signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
      numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
    })
  end
}
