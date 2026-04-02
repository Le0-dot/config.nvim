vim.keymap.set(
    'n',
    'gyf',
    function()
        local path = vim.fn.expand("%:.")
        vim.fn.setreg("", path)
        vim.fn.setreg("+", path)
    end,
    { desc = 'Copy relative file path to system clipboard' }
)
vim.keymap.set(
    'n',
    'gyd',
    function()
        local path = vim.fn.expand("%:.:h")
        vim.fn.setreg("", path)
        vim.fn.setreg("+", path)
    end,
    { desc = 'Copy relative directory path to system clipboard' }
)

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Hightlight selection on yank',
    callback = function()
        vim.hl.on_yank({ higroup = 'DiffText', timeout = 500 })
    end,
})
