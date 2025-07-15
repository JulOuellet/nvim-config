-- lua/plugins/nvim-tree.lua
return {
    'nvim-tree/nvim-tree.lua',
    enabled = true,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('nvim-tree').setup({
            git = { enable = true, ignore = false },
            view = { width = 30, side = 'left' },
            renderer = {
                icons = {
                    show = { git = true, folder = true, file = true, folder_arrow = true }
                },
            },
        })
        vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle file explorer (nvim-tree)' })
    end
}
