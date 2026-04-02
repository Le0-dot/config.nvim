vim.pack.add({
    { src = 'https://github.com/mfussenegger/nvim-dap' },
    { src = 'https://github.com/miroshQa/debugmaster.nvim'},
})

vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
vim.fn.sign_define("DapBreakpoint", { text = '', texthl = 'DapBreak' })

vim.keymap.set('n', '<leader>d', require('debugmaster').mode.toggle, { nowait = true })
