return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    opts = {
        ensure_installed = { "lua", "python", "robot" },
        auto_install = true,

        highlight = { enable = true },
        indent = { enable = true },
    }
}
