return {
    {
        'mfussenegger/nvim-dap',
        config = function()
            vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
            vim.fn.sign_define("DapBreakpoint", { text = '', texthl = 'DapBreak' })
        end

    },
    {
        'miroshQa/debugmaster.nvim',
        dependencies = { 'mfussenegger/nvim-dap' },
        config = function()
            vim.keymap.set('n', '<leader>d', require('debugmaster').mode.toggle, { nowait = true })
        end,
    },
}
