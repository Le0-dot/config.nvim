vim.pack.add({
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },
})

vim.cmd.TSUpdate()

vim.api.nvim_create_autocmd('FileType', {
    desc = 'Install treesitter parsers when opening new filetypes',
    callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        local treesitter = require('nvim-treesitter')
        local installed = vim.list_contains(treesitter.get_installed(), lang)
        local available = vim.list_contains(treesitter.get_available(), lang)

        if not installed and available then
            treesitter.install({ lang }, { summary = true })
        end
    end
})
