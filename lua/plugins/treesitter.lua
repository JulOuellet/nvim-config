-- lua/plugins/treesitter.lua
return {
    'nvim-treesitter/nvim-treesitter',
    enabled = true,
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = { "lua", "nix", "java", "go", "rust" },
            highlight = {
                enable = true,
            },
            indent = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn", -- Start selection
                    node_incremental = "grn", -- Increment node
                    node_decremental = "grm", -- Decrement node
                },
            },
            autotag = {
                enable = true,
            },
        })
    end
}

