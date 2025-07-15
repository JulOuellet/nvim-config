-- lua/plugins/telescope.lua
return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        require('telescope').setup({
            defaults = {
                layout_config = {
                    prompt_position = 'top',
                },
                sorting_strategy = 'ascending',
                mappings = {
                    i = {
                        ["<C-k>"] = "move_selection_previous",
                        ["<C-j>"] = "move_selection_next",
                    },
                },
            },
        })

        -- Keybinds
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope: Find files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope: Live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope: Buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope: Help tags' })
    end
}
