return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    opts = {
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
    }
}
