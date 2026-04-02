vim.pack.add({
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },
})

vim.cmd.TSUpdate()

    -- opts = {
    --     auto_install = true,
    --     highlight = { enable = true },
    --     indent = { enable = true },
    -- }
